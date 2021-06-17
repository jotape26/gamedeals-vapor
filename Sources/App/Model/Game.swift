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
    var productTitle: String
    var platform : String
    var gameCoverURL: String?
    var priceInfo : PriceInfo
    
    fileprivate init(productID: String, gameName: String, system: String, imageURL: String? = nil, priceInfo: PriceInfo) {
        
        self.productID = productID
        self.productTitle = gameName
        self.platform = system
        self.gameCoverURL = imageURL
        self.priceInfo = priceInfo
        
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
    var priceInfo  : PriceInfo!
    var storeURL   : String!
    
    var coverImage : GameImageInfo?
    
    init(){}
    
    init(platform: DealPlatform, productId: String, game: GameInformation, price: PriceInfo, coverImage: GameImageInfo?) {
        
        self.platform = platform
        self.productId = productId
        self.gameInfo = game
        self.priceInfo = price
        self.storeURL = getStoreURL()
        
        self.coverImage = coverImage ?? game.gameImages.first ?? nil
        
    }
    
    func getSimplifiedReturn() -> GameSimple {
        return GameSimple(productID: productId,
                          gameName: gameInfo.productTitle,
                          system: platform.rawValue,
                          imageURL: gameInfo.gameImages.first?.imageUrl,
                          priceInfo: priceInfo)
    }
    
    private func getStoreURL() -> String {
        let name = gameInfo.productTitle
        let regex = try! NSRegularExpression(pattern: "[^A-Za-z0-9 ]")
        
        var regexedName = regex.stringByReplacingMatches(in: name,
                                                         options: [],
                                                         range: (name as NSString).range(of: name),
                                                         withTemplate: "")
        
        regexedName = regexedName.replacingOccurrences(of: " ", with: "-")
        
        
        return "https://www.microsoft.com/pt-br/p/\(regexedName)/\(productId!)"
    }
}

final class GameInformation: Content {
    
    var productTitle       : String
    var publisherName      : String
    var gameImages         : [GameImageInfo]
    
    var compatibleConsoles : [String]
    var shortDescription   : String
    var productType        : String
    
    var relatedProductsID : [String]
    
    init(productName: String,
         publisherName: String,
         images: [GameImageInfo],
         consoles: [String],
         description: String,
         type: String,
         relatedIds: [String]) {
        
        self.productTitle = productName
        self.publisherName = publisherName
        self.gameImages = images
        self.compatibleConsoles = consoles
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
