import Vapor

func routes(_ app: Application) throws {
    app.get { req in
        return "It works!"
    }
    app.get("gameDeals") { req -> EventLoopFuture<[GameDeal]> in
        return GameDeal.query(on: req.db).all()
    }
}
