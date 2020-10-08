//
//  ContentView.swift
//  ToolBox
//
//  Created by grant on 27/9/2020.
//

import SwiftUI
import Starscream


var socket:WebSocket?

struct ContentView: View {
    
    @State private var url:String = "123.207.136.134:9010/ajaxchattest"
    @State private var sendMesg:String = ""
    @State private var respMesg:String = ""
    @State private var conState:Bool = false
    var body: some View {
        VStack{
            Spacer()
                .frame(width: /*@START_MENU_TOKEN@*/100.0/*@END_MENU_TOKEN@*/, height: 20.0)
            HStack {
                Spacer().frame(width: 20, height: 3, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                Text("ws://")
                TextField("localhost:8080/ws", text: $url).frame(minWidth: 0/*@END_MENU_TOKEN@*/, idealWidth: 100, maxWidth: 250.0, minHeight: /*@START_MENU_TOKEN@*/0, idealHeight: 20, maxHeight: 20, alignment: .center)
                !conState ?
                Button("连接"){
                    var request = URLRequest(url: URL(string: "ws://" + self.url)!)
                    request.timeoutInterval = 5
                    socket = WebSocket(request: request)
                    socket!.onEvent = {
                        event in switch event {
                            case .text(let string):
                                self.respMesg += "\n" + string
                                break
                        case .connected(_):
                            self.respMesg += "\n服务器连接..."
                            self.conState = true
                            break
                        case .disconnected(_, _):
                            self.respMesg += "\n服务器断开..."
                            break
                        case .binary(_):
                            break
                        case .pong(_):
                            break
                        case .ping(_):
                            break
                        case .error(_):
                            self.respMesg += "\n错误..."
                            break
                        case .viabilityChanged(_):
                            break
                        case .reconnectSuggested(_):
                            break
                        case .cancelled:
                            break
                        }
                    }
                    socket!.connect()
                }:
                Button("断开"){
                    self.conState = false
                    socket?.disconnect()
                }
                Button("发送"){
                    socket!.write(string: self.sendMesg)
                    self.sendMesg = ""
                }
                Spacer()
            }
            VStack{
                HStack{
                    Spacer().frame(width: 20, height: 3, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    TextField("发送消息", text: $sendMesg).fixedSize(horizontal: false, vertical: /*@START_MENU_TOKEN@*/true/*@END_MENU_TOKEN@*/)
                    Spacer().frame(width: 20, height: 3, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                }
            }
            
            VStack{
                HStack{
                    Spacer().frame(width: 20, height: 3, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    Button("清除"){
                        self.respMesg = ""
                    }
                    Spacer()
                }
                Divider().frame(width: 20, height: 3, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                ScrollView(.vertical){
                    HStack{
                        Spacer().frame(width: 20, height: 3, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                        Text(self.respMesg)
                        Spacer()
                    }
                }
            }
            
        }.frame(width: 1024, height: 678, alignment: .top)
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
