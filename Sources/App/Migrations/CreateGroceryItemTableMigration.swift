//
//  CreateGroceryItemTableMigration.swift
//  grocery-app-server
//
//  Created by Rychillie Umpierre de Oliveira on 26/11/24.
//

import Foundation
import Fluent

class CreateGroceryItemTableMigration: AsyncMigration {

    func prepare(on database: any Database) async throws {
        try await database.schema("grocery_items")
            .id()
            .field("title", .string, .required)
            .field("price", .double, .required)
            .field("quantity", .int, .required)
            .field("grocery_category_id", .uuid, .required, .references("grocery_categories", "id", onDelete: .cascade))
            .create()
    }

    func revert(on database: any Database) async throws {
        try await database.schema("grocery_items").delete()
    }

}
