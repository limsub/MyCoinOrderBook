//
//  WebSocketManager.swift
//  MyCoinOrderBook
//
//  Created by 임승섭 on 12/29/23.
//

import Foundation
import Combine

final class WebSocketManager: NSObject {
    
    static let shared = WebSocketManager()
    
    private override init() {
        super.init()
    }
    
    // 필요한 프로퍼티
    private var timer: Timer?    // 5초에 한 번씩 Ping 보내기
    private var webSocket: URLSessionWebSocketTask?
    private var isOpen = false   // 소켓 연결 상태
    var orderBookSbj = PassthroughSubject<OrderBookWS, Never>()
    
    /* ===  RxSwift vs. Combine === */
    // RxSwift PublishSubject   -> Combine PassthroughSubject
    // RxSwift BehaviorSubject  -> Combine CurrentValueSubject
    
    // Rx에서는 데이터 타입만 설정          (PublishSubject<OrderBookWS>)
    // Combine에서는 오류에 대한 타입도 설정 (PassthroughSubject<OrderBookWS, Never>)
    
    // RxSwift onNext           -> Combine send
    
    
    
    // 메서드 정의
    // 1. open (클라이언트 : 소켓 연결해줘) -> didOpen으로 열렸는지 확인
    func openWebSocket() {
        if let url = URL(string: "wss://api.upbit.com/websocket/v1") {
            let session = URLSession(configuration: .default, delegate: self, delegateQueue: nil)
            // -> URLSessionWebSocketDelegate 프로토콜 채택
            webSocket = session.webSocketTask(with: url)
            webSocket?.resume()
            
            ping()
        }
    }
    
    // 2. close (클라이언트 : 소켓 닫아줘) -> didClose로 닫혔는지 확인
    func closeWebSocket() {
        // 다양한 CloseCode 존재. 주로 사용 : goingAway, messageTooBig
        webSocket?.cancel(with: .goingAway, reason: nil)
        webSocket = nil
        
        // 타이머 관리 (뷰컨트롤러와 따로 동작하기 때문에 잘 다뤄야 한다. 키워드 : Runloop
        timer?.invalidate()
        timer = nil
        
        isOpen = false  // 어차피 didClose에서 쓸텐데 여기 굳이 있을 필요가 있나..?
    }
    
    // 3. send (소켓 통신으로 받고 싶은 데이터를 요청한다)
    func send() {
        // 업비트는 string 기반으로 요청한다
        let requestStr = """
        [{"ticket":"test"},{"type":"orderbook","codes":["KRW-BTC"]}]
        """
        
        webSocket?.send(.string(requestStr), completionHandler: { error  in
            if let error { print("send Error : \(error.localizedDescription)") }
        })
    }
    
    // 4. receive (필요한 순간에 서버에서 데이터를 받는다)
    func receive() {
        if isOpen { // 소켓이 열렸을 때만 데이터 수신이 가능하도록 한다
            
            webSocket?.receive(completionHandler: { [weak self] result  in
                switch result {
                case .success(let success):
                    print("receive Success : \(success)")
                    
                    switch success {
                    case .data(let data):
                        print("success - data : \(data)")
                        
                    case .string(let string):
                        print("success - string : \(string)")
                        
                    @unknown default:
                        fatalError()
                    }
                    
                case .failure(let failure):
                    print("receive Fail : \(failure.localizedDescription)")
                    self?.closeWebSocket()  // 소켓 데이터가 제대로 오지 않기 때문에, 닫아준다
                }
                
                // 재귀
                self?.receive()
            })
            
        }
    }
    
    // 5. ping (서버에 의해 연결이 끊어지지 않도록 주기적으로 ping을 서버에 보낸다)
    private func ping() {
        // 타이머 이용해서 5초에 한 번씩 보낼 수 있도록 한다.
        self.timer = Timer.scheduledTimer(withTimeInterval: 5.0, repeats: true, block: { [weak self] _ in
            
            self?.webSocket?.sendPing(pongReceiveHandler: { error  in
                if let error {
                    print("Ping Error : \(error.localizedDescription)")
                } else {
                    print("Ping Success") 
                }
            })
        })
    }
    
}


extension WebSocketManager: URLSessionWebSocketDelegate {
    // WebSocketManager가 NSObject를 채택하고 있지 않으면 에러 발생 -> 이유는?
    
    
    func urlSession(_ session: URLSession, webSocketTask: URLSessionWebSocketTask, didOpenWithProtocol protocol: String?) {
        print(#function)
        print("WebSocket OPEN")
        
        isOpen = true
        
//        receive()
    }
    
    func urlSession(_ session: URLSession, webSocketTask: URLSessionWebSocketTask, didCloseWith closeCode: URLSessionWebSocketTask.CloseCode, reason: Data?) {
        print(#function)
        print("WebSocket CLOSE")
        
        isOpen = false
    }
}
