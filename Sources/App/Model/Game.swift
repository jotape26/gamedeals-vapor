//
//  Game.swift
//  
//
//  Created by João Leite on 16/06/21.
//

import Foundation
import Vapor
//import Fluent
import NIOFoundationCompat

final class Game: Content /*, Model, Migration*/ {
//    func prepare(on database: Database) -> EventLoopFuture<Void> {
//        database.schema(Game.schema)
//            .field(.definition(name: .key("productId"), dataType: .string, constraints: [.required]))
//            .field(.definition(name: .key("gameName"), dataType: .string, constraints: []))
//            .field(.definition(name: .key("originalPrice"), dataType: .double, constraints: []))
//            .field(.definition(name: .key("discountedPrice"), dataType: .double, constraints: []))
//            .field(.id, .uuid, .required)
//            .create()
//    }
//
//    func revert(on database: Database) -> EventLoopFuture<Void> {
//        return database.schema(Game.schema).update()
//    }
//
//
//    static let schema = "deals"
//
//    @ID(key: .id)
//    var id : UUID?
//    @Field(key: "productId")
//    @Field(key: "gameName")
    
    var productId  : String
    var gameInfo   : GameInformation
    var princeInfo : PriceInfo
    
    init(productId: String, game: GameInformation, price: PriceInfo) {
        
        self.productId = productId
        self.gameInfo = game
        self.princeInfo = price
        
    }
}

final class GameInformation: Content {

    var publisherName : String
    var gameImages : [GameImageInfo]
    
    var shortDescription : String
    var productType : String
    
    var relatedProductsID : [String]
    
    init(publisherName: String,
         images: [GameImageInfo],
         description: String,
         type: String,
         relatedIds: [String]) {
        
        self.publisherName = publisherName
        self.gameImages = images
        self.shortDescription = description
        self.productType = type
        self.relatedProductsID = relatedIds
        
    }
    
}

final class GameImageInfo: Content {
    
    var imageUrl : String
    var height : Double
    var width : Double
    
    init(imageUrl: String, height: Double, width: Double) {
        
        self.imageUrl = imageUrl
        self.height = height
        self.width = width
        
    }
    
}

final class PriceInfo: Content {
    
    var currencyCode  : String
    var originalMSRP  : Double
    var discountPrice : Double
    
    init(currencyCode: String, originalMSRP: Double, discountPrice: Double) {
        
        self.currencyCode = currencyCode
        self.originalMSRP = originalMSRP
        self.discountPrice = discountPrice
        
    }
    
}
