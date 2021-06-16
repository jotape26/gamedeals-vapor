import Vapor

func routes(_ app: Application) throws {

    app.get { req in
        return "It works!"
    }
    app.get("gameDeals") { req -> [GameDeal] in
        return Session.current.activeDeals
    }
}
