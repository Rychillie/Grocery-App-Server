//
//  CreateUsersMigration.swift
//  grocery-app-server
//
//  Created by Rychillie Umpierre de Oliveira on 23/11/24.
//

import Foundation
import Fluent

struct CreateUsersTableMigration: AsyncMigration {
    
    func prepare(on database: any Database) async throws {
        try await database.schema("users")
            .id()
            .field("username", .string, .required).unique(on: "username")
            .field("password", .string, .required)
            .create()
    }
    
    func revert(on database: any Database) async throws {
        try await database.schema("users")
            .delete()
    }
    
}
