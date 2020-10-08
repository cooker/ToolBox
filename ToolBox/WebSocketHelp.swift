//
//  WebSocketClient.swift
//  ToolBox
//
//  Created by grant on 27/9/2020.
//

import Foundation
import SwiftUI
import Starscream

class WebSocketHelp: WebSocketDelegate {
    func didReceive(event: WebSocketEvent, client: WebSocket) {
        switch event {
        case .connected(let headers):
            
            print("websocket is connected: \(headers)")
        case .disconnected(let reason, let code):
            
            print("websocket is disconnected: \(reason) with code: \(code)")
        case .text(let string):
            print("Received text: \(string)")
        case .binary(let data):
            print("Received data: \(data.count)")
        case .ping(_):
            break
        case .pong(_):
            break
        case .viabilityChanged(_):
            break
        case .reconnectSuggested(_):
            break
        case .cancelled:
            break
        case .error(_):
            break
        }
    }
}
