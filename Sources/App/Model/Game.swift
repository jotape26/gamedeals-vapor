//
//  Game.swift
//  
//
//  Created by João Leite on 16/06/21.
//

import Foundation
import Vapor
import NIOFoundationCompat

final class GameSimple: Content {
    
    var productID: String
    var gameName: String
    var system : String
    var originalPrice: Double
    var discountedPrice: Double
    var imageURL: String?
    
    fileprivate init(productID: String, gameName: String, system: String, originalPrice: Double, discountedPrice: Double, imageURL: String? = nil) {
        
        self.productID = productID
        self.gameName = gameName
        self.system = system
        self.originalPrice = originalPrice
        self.discountedPrice = discountedPrice
        self.imageURL = imageURL
        
    }
}

final class Game: Content {
    
    enum DealPlatform : String, Content {
        case Xbox = "xbx"
        case Playstation = "ps"
        
        func getScreenName() -> String {
            switch self {
            case .Xbox: return "Xbox"
            case .Playstation: return "PlayStation"
            }
        }
    }
    
    var platform   : DealPlatform!
    var productId  : String!
    var gameInfo   : GameInformation!
    var priceInfo : PriceInfo!
    
    init(){}
    
    init(platform: DealPlatform, productId: String, game: GameInformation, price: PriceInfo) {
        
        self.platform = platform
        self.productId = productId
        self.gameInfo = game
        self.priceInfo = price
        
    }
    
    func getSimplifiedReturn() -> GameSimple {
        return GameSimple(productID: productId,
                          gameName: gameInfo.productTitle,
                          system: platform.getScreenName(),
                          originalPrice: priceInfo.originalMSRP,
                          discountedPrice: priceInfo.discountPrice,
                          imageURL: gameInfo.gameImages.first?.imageUrl)
    }
}

final class GameInformation: Content {
    
    var productTitle      : String
    var publisherName     : String
    var gameImages        : [GameImageInfo]
    
    var shortDescription  : String
    var productType       : String
    
    var relatedProductsID : [String]
    
    init(productName: String,
         publisherName: String,
         images: [GameImageInfo],
         description: String,
         type: String,
         relatedIds: [String]) {
        
        self.productTitle = productName
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

// Fluent Code
//import Fluent
/*, Model, Migration { */
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
