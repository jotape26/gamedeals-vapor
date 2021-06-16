import Vapor

func routes(_ app: Application) throws {

    app.get { req in
        return "It works!"
    }
    
    app.get("getAllGameDeals") { req -> [GameSimple] in
        
        guard let params = req.body.data?.asDictionary() else { throw Abort(.badRequest) }
        
        var activeDeals = Session.current.activeDeals
        
        if let platformString = params["platform"] as? String {
            guard let platform = Game.DealPlatform(rawValue: platformString) else { throw Abort(.custom(code: 400, reasonPhrase: "Invalid Platform")) }
            activeDeals = activeDeals.filter({
                $0.platform == platform
            })
        }
        
        return activeDeals.map({ $0.getSimplifiedReturn() })
    }
    
    app.get("getDealDetail") { req -> Game in
        guard let params = req.body.data?.asDictionary() else { throw Abort(.badRequest) }
        guard !params.isEmpty else { throw Abort(.custom(code: 400, reasonPhrase: "No params provided")) }
        
        guard let productID = params["productID"] as? String else { throw Abort(.custom(code: 400, reasonPhrase: "No \"ProductID\" provided")) }
        
        if let deal = Session.current.activeDeals.first(where: { $0.productId == productID }) {
            return deal
        } else {
            throw Abort(.custom(code: 404, reasonPhrase: "ProductID not found. Maybe not on sale?"))
        }
        
    }
    
    app.get("getRelatedDetail") { req -> Game in
        
        guard let params = req.body.data?.asDictionary() else { throw Abort(.badRequest) }
        guard !params.isEmpty else { throw Abort(.custom(code: 400, reasonPhrase: "No params provided")) }
        
        guard let productID = params["productID"] as? String else { throw Abort(.custom(code: 400, reasonPhrase: "No \"ProductID\" provided")) }
        
        if let deal = Session.current.activeDeals.first(where: { $0.productId == productID }) {
            return deal
        } else {
            let sem = DispatchSemaphore(value: 1)
            var fetchedGame : Game!
            
            sem.wait()
            XboxDataBusiness().getRelatedDetails(relatedID: productID) { game in
                fetchedGame = game
                sem.signal()
            }
            
            sem.wait()
            guard fetchedGame != nil else { sem.signal(); throw Abort(.internalServerError) }
            sem.signal()
            
            return fetchedGame
        }
    }
}

extension ByteBuffer {
    func asString() -> String? {
        guard let data = self.getData(at: 0, length: self.writerIndex, byteTransferStrategy: .automatic) else { return nil }
        return String(data: data, encoding: .utf8)
    }
    
    func asDictionary() -> [String : Any]? {
        return asString()?.convertToDictionary()
    }
}
