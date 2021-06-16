//
//  Network.swift
//  
//
//  Created by João Leite on 16/06/21.
//

import Foundation
import Vapor
import NIOFoundationCompat

typealias NetworkResponse = [String : Any]

class Network {
    
    static func get(_ url: String,
                    completionHandler: @escaping (NetworkResponse?, Error?) -> ()) {
        let client = HTTPClient(eventLoopGroupProvider: .createNew)
        _ = client.get(url: url).map { response in
            do {
                completionHandler(response.body?.asDictionary(), nil)
                try client.syncShutdown()
            } catch {
                fatalError()
            }
        }
    }
    
    static func get(_ url: String) -> EventLoopFuture<(HTTPClient, HTTPClient.Response)> {
        let client = HTTPClient(eventLoopGroupProvider: .createNew)
        return client.get(url: url).map { response in
            return (client, response)
        }
    }
    
}

