//
//  GroceryController.swift
//  grocery-app-server
//
//  Created by Rychillie Umpierre de Oliveira on 24/11/24.
//

import Foundation
import Vapor

class GroceryController: RouteCollection {
    
    func boot(routes: RoutesBuilder) throws {
        
        // /api/users/:userId
        let api = routes.grouped("api", "users", ":userId")
        
        // /api/users/:userId/grocery-categories
        api.post("grocery-categories", use: saveGroceryCategory)
        
    }
    
    func saveGroceryCategory(req: Request) async throws -> String {
        // TODO: DTO for the request
        
        // TODO: DTO for the response
        
        return "ok"
    }
    
}
