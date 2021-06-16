//
//  XboxDataBusiness.swift
//  
//
//  Created by João Leite on 16/06/21.
//

import Foundation
import Vapor
import NIOFoundationCompat

struct DealsListResponse: Content {
    var Items : [GameItems]
}
struct GameItems: Content {
    var Id: String
    var ItemType : String
}

final class XboxDataBusiness {
    
    func populateDatabase(fromApp app: Application) throws {
        
        _ = app.client
            .get("https://reco-public.rec.mp.microsoft.com/channels/Reco/V8.0/Lists/Computed/Deal?Market=br&Language=pt&ItemTypes=Game&deviceFamily=Windows.Xbox&count=2000&skipitems=0")
            .map { resp in
                
                guard let gameIds = try? resp.content.decode(DealsListResponse.self)
                        .Items
                        .map({ $0.Id }) else { return }
                
                _ = app.client
                    .get("https://displaycatalog.mp.microsoft.com/v7.0/products?market=BR&languages=pt-br&MS-CV=DGU1mcuYo0WMMp+F.1&bigIds=\(gameIds.joined(separator: ","))")
                    .map({ resp in
                        
                        guard let body = resp.body,
                              let bodyData = body.getData(at: 0, length: body.writerIndex, byteTransferStrategy: .automatic),
                              let responseString = String(data: bodyData, encoding: .utf8),
                              let responseDictionary = responseString.convertToDictionary() else { return }
                        
                        
                        guard let products = responseDictionary["Products"] as? [[String : Any]] else { return }
                        
                        let gameDealsList = products.enumerated().map { index, product -> Game in
                            
                            let skuAvailabilities = (product["DisplaySkuAvailabilities"] as? [[String : Any]])?.first ?? [:]
                            let localizedProperties = (product["LocalizedProperties"] as? [[String : Any]])?.first ?? [:]
                            let marketProperties = (product["MarketProperties"] as? [[String : Any]])?.first ?? [:]
                            
                            let availabilities = (skuAvailabilities["Availabilities"] as? [[String: Any]])?.first ?? [:]
                            let priceInfo = (availabilities["OrderManagementData"] as? [String : Any])?["Price"] as? [String : Any] ?? [:]
                            
                            
                            let images = (localizedProperties["Images"] as? [[String : Any]] ?? [])
                                .compactMap({ imageDict -> GameImageInfo? in
                                    
                                    if let url = imageDict["Uri"] as? String,
                                       let height = imageDict["Height"] as? Double,
                                       let width = imageDict["Width"] as? Double {
                                        return GameImageInfo(imageUrl: url, height: height, width: width)
                                    }
                                    
                                    return nil
                                })
                            
                            let relatedIds = (marketProperties["RelatedProducts"] as? [[String : Any]] ?? [])
                                .compactMap { relatedInfo -> String? in
                                    return relatedInfo["RelatedProductId"] as? String
                                }
//
                            let gameInformation = GameInformation(publisherName: localizedProperties["PublisherName"] as? String ?? "",
                                                                  images: images,
                                                                  description: localizedProperties["ShortDescription"] as? String ?? "",
                                                                  type: product["ProductType"] as? String ?? "",
                                                                  relatedIds: relatedIds)
                            
                            let gamePriceInfo = PriceInfo(currencyCode: priceInfo["CurrencyCode"] as? String ?? "",
                                                      originalMSRP: priceInfo["MSRP"] as? Double ?? 0.0,
                                                      discountPrice: priceInfo["ListPrice"] as? Double ?? 0.0)
                            
                            
                            return Game(productId: gameIds[index],
                                        game: gameInformation,
                                        price: gamePriceInfo)
//                            var publisherName : String
//                            var gameImages : [GameImageInfo]
//
//                            var shortDescription : String
//                            var productType : String
//
//                            var relatedProductsID : [String]
//
//
//                            return Game(productId: product["ProductId"] as! String,
//                                            gameName: localizedProperties["SkuTitle"] as! String,
//                                            originalPrice: priceInfo["MSRP"] as! Double,
//                                            discountedPrice: priceInfo["ListPrice"] as! Double)
                        }
                        
//                        gameDealsList.forEach {
//                            _ = $0.create(on: app.db)
//                        }
                        
                        Session.current.activeDeals = gameDealsList
                        
                        print("database created")
                    })
            }
    }
}
