//
//  GameDeal.swift
//  
//
//  Created by João Leite on 16/06/21.
//

import Foundation
import Vapor
//import Fluent
import NIOFoundationCompat

final class GameDeal: Content/*, Model, Migration*/ {
//    func prepare(on database: Database) -> EventLoopFuture<Void> {
//        database.schema(GameDeal.schema)
//            .field(.definition(name: .key("productId"), dataType: .string, constraints: [.required]))
//            .field(.definition(name: .key("gameName"), dataType: .string, constraints: []))
//            .field(.definition(name: .key("originalPrice"), dataType: .double, constraints: []))
//            .field(.definition(name: .key("discountedPrice"), dataType: .double, constraints: []))
//            .field(.id, .uuid, .required)
//            .create()
//    }
//
//    func revert(on database: Database) -> EventLoopFuture<Void> {
//        return database.schema(GameDeal.schema).update()
//    }
//
//
//    static let schema = "deals"
//
//    @ID(key: .id)
    var id : UUID?
    
//    @Field(key: "productId")
    var productId: String
    
//    @Field(key: "gameName")
    var gameName: String
    
//    @Field(key: "originalPrice")
    var originalPrice : Double
    
//    @Field(key: "discountedPrice")
    var discountedPrice : Double
    
//    init() {}
    
    init(productId: String, gameName: String, originalPrice: Double, discountedPrice: Double) {
        self.id = UUID()
        self.productId = productId
        self.gameName = gameName
        self.originalPrice = originalPrice
        self.discountedPrice = discountedPrice
    }
}
