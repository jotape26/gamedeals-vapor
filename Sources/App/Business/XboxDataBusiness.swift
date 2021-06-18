//
//  XboxDataBusiness.swift
//  
//
//  Created by João Leite on 16/06/21.
//

import Foundation
import Vapor
import NIOFoundationCompat

enum XboxConsole : String {
    case One = "ConsoleGen8"
    case Series = "ConsoleGen9"
    
    var friendlyName : String {
        get {
            switch self {
            case .One : return "Xbox One"
            case .Series : return "Xbox Series S|X"
            }
        }
    }
}

enum PlayStationConsole : String {
    case PS4 = "PS4"
    case PS5 = "PS5"
}

protocol PlatformBusiness {
    func getGameDeals(completion: @escaping ([Game]) -> ()) throws
    func getGameDetails(gameIDs: [String], completion: @escaping ([Game]) -> ())
    //    func populateDatabase(fromApp app: Application) throws
}

struct DealsListResponse: Content {
    var Items : [GameItems]
}
struct GameItems: Content {
    var Id: String
    var ItemType : String
}

final class XboxDataBusiness: PlatformBusiness {
    
    func getGameDeals(completion: @escaping ([Game]) -> ()) throws {
        
        Network.get("https://reco-public.rec.mp.microsoft.com/channels/Reco/V8.0/Lists/Computed/Deal?Market=br&Language=pt&ItemTypes=Game&deviceFamily=Windows.Xbox&count=2000&skipitems=0") { response, error in
            
            guard let response = response else { return }
            guard let gameItems = response["Items"] as? [[String : Any]] else { return }

            self.getGameDetails(gameIDs: gameItems.compactMap({ $0["Id"] as? String }),
                           completion: completion)
            
        }
    }
    
    func getGameDetails(gameIDs: [String], completion: @escaping ([Game]) -> ()) {
        Network.get("https://displaycatalog.mp.microsoft.com/v7.0/products?market=BR&languages=pt-br&MS-CV=DGU1mcuYo0WMMp+F.1&bigIds=\(gameIDs.joined(separator: ","))") { resp, error in
            
            guard let body = resp else { return }
            guard let products = body["Products"] as? [[String : Any]] else { return }
            
            completion(products.enumerated().map { index, product -> Game in
                return self.parseDetails(product, productID: gameIDs[index])
            })
            
        }
    }
    
    func getRelatedDetails(relatedID: String, completion: @escaping (Game?) -> ())  {
        Network.get("https://displaycatalog.mp.microsoft.com/v7.0/products?market=BR&languages=pt-br&MS-CV=DGU1mcuYo0WMMp+F.1&bigIds=\(relatedID)") { (resp, error) -> Void in
            
            guard let body = resp else { completion(nil); return () }
            guard let products = body["Products"] as? [[String : Any]] else { completion(nil); return () }
            
            if let productInfo = products.first {
                completion(self.parseDetails(productInfo, productID: relatedID))
            } else {
                completion(nil)
            }
            
            return ()
        }
    }
    
    func parseDetails(_ product: [String : Any], productID: String) -> Game {
        let skuAvailabilities = (product["DisplaySkuAvailabilities"] as? [[String : Any]])?.first ?? [:]
        let localizedProperties = (product["LocalizedProperties"] as? [[String : Any]])?.first ?? [:]
        let marketProperties = (product["MarketProperties"] as? [[String : Any]])?.first ?? [:]
        
        let availabilities = (skuAvailabilities["Availabilities"] as? [[String: Any]])?.first ?? [:]
        
        let generalProperties = (product["Properties"] as? [String : Any]) ?? [:]
        let compatibleConsoles : [String] = (generalProperties["XboxConsoleGenCompatible"] as? [String] ?? [])
            .compactMap { XboxConsole(rawValue: $0)?.friendlyName }
        
        let priceInfo = (availabilities["OrderManagementData"] as? [String : Any])?["Price"] as? [String : Any] ?? [:]
        
        var promotionalImage: GameImageInfo?
        
        let images = (localizedProperties["Images"] as? [[String : Any]] ?? [])
            .compactMap({ imageDict -> GameImageInfo? in
                
                if let url = imageDict["Uri"] as? String,
                   let height = imageDict["Height"] as? Double,
                   let width = imageDict["Width"] as? Double {
                    
                    let image = GameImageInfo(type: .Image, mediaURL: url, height: height, width: width)
                    
                    if let purpose = imageDict["ImagePurpose"] as? String, purpose == "FeaturePromotionalSquareArt" {
                        promotionalImage = image
                    } else {
                        return image
                    }
                    
                }
                
                return nil
            })
        
        let relatedIds = (marketProperties["RelatedProducts"] as? [[String : Any]] ?? [])
            .compactMap { relatedInfo -> String? in
                return relatedInfo["RelatedProductId"] as? String
            }
        
        let gameInformation = GameInformation(productName: localizedProperties["ProductTitle"] as? String ?? "",
                                              publisherName: localizedProperties["PublisherName"] as? String ?? "",
                                              images: images,
                                              consoles: compatibleConsoles,
                                              description: localizedProperties["ShortDescription"] as? String ?? "",
                                              type: product["ProductType"] as? String ?? "",
                                              relatedIds: relatedIds)
        
        let gamePriceInfo = PriceInfo(currencyCode: priceInfo["CurrencyCode"] as? String ?? "",
                                      originalMSRP: priceInfo["MSRP"] as? Double ?? 0.0,
                                      discountPrice: priceInfo["ListPrice"] as? Double ?? 0.0)
        
        
        return Game(platform: .Xbox,
                    productId: productID,
                    game: gameInformation,
                    price: gamePriceInfo,
                    coverImage: promotionalImage)
    }
}
