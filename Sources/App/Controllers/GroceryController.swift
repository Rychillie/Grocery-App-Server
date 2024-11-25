//
//  GroceryController.swift
//  grocery-app-server
//
//  Created by Rychillie Umpierre de Oliveira on 24/11/24.
//

import Foundation
import Vapor
import GroceryAppSharedDTO
import Fluent

class GroceryController: RouteCollection {
    
    func boot(routes: RoutesBuilder) throws {
        
        // /api/users/:userId
        let api = routes.grouped("api", "users", ":userId")
        
        // POST: /api/users/:userId/grocery-categories
        api.post("grocery-categories", use: saveGroceryCategory)
        
        // GET: /api/users/:userId/grocery-categories
        api.get("grocery-categories", use: getGroceryCategoriesByUser)
        
        // DELETE: /api/users/:userId/grocery-categories/:groceryCategoryId
        api.delete("grocery-categories", ":groceryCategoryId", use: deleteGroceryCategory)
        
    }
    
    func deleteGroceryCategory(req: Request) async throws -> GroceryCategoryResponseDTO {
        
        guard let userId = req.parameters.get("userId", as: UUID.self),
              let groceryCategoryId = req.parameters.get("groceryCategoryId", as: UUID.self)
        else {
            throw Abort(.badRequest)
        }
        
        guard let groceryCategory = try await GroceryCategory.query(on: req.db)
            .filter(\.$user.$id == userId)
            .filter(\.$id == groceryCategoryId)
            .first() else {
                throw Abort(.notFound)
            }
        
        
        try await groceryCategory.delete(on: req.db)
        
        guard let groceryCategoryResponseDTO = GroceryCategoryResponseDTO(groceryCategory) else {
            throw Abort(.internalServerError)
        }
        
        return groceryCategoryResponseDTO
        
    }
    
    func getGroceryCategoriesByUser(req: Request) async throws -> [GroceryCategoryResponseDTO] {
        
        guard let userId = req.parameters.get("userId", as: UUID.self) else {
            throw Abort(.badRequest)
        }
        
        return try await GroceryCategory.query(on: req.db)
            .filter(\.$user.$id == userId)
            .all()
            .compactMap(GroceryCategoryResponseDTO.init)
        
    }
    
    func saveGroceryCategory(req: Request) async throws -> GroceryCategoryResponseDTO {
        
        guard let userId = req.parameters.get("userId", as: UUID.self) else {
            throw Abort(.badRequest)
        }
        
        let groceryCategoryRequestDTO = try req.content.decode(GroceryCategoryRequestDTO.self)
        
        let groceryCategory = GroceryCategory(
            title: groceryCategoryRequestDTO.title,
            colorCode: groceryCategoryRequestDTO.colorCode,
            userId: userId
        )
        
        try await groceryCategory.save(on: req.db)
        
        guard let groceryCategoryResponseDTO = GroceryCategoryResponseDTO(groceryCategory) else {
            throw Abort(.internalServerError)
        }
        
        return groceryCategoryResponseDTO
        
    }
    
}
