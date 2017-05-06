//
//  SocketIOClientSpec.swift
//  Socket.IO-Client-Swift
//
//  Created by Erik Little on 1/3/16.
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.

import Dispatch

protocol SocketIOClientSpec : class {
    var handleQueue: DispatchQueue { get set }
    var nsp: String { get set }
    var waitingPackets: [SocketPacket] { get set }

    func didConnect()
    func didDisconnect(reason: String)
    func didError(reason: String)
    func handleAck(_ ack: Int, data: [Any])
    func handleEvent(_ event: String, data: [Any], isInternalMessage: Bool, withAck ack: Int)
    func joinNamespace(_ namespace: String)
}

extension SocketIOClientSpec {
    func didError(reason: String) {
        DefaultSocketLogger.Logger.error("%@", type: "SocketIOClient", args: reason)

        handleEvent("error", data: [reason], isInternalMessage: true, withAck: -1)
    }
}
