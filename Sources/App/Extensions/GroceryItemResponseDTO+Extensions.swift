//
//  GroceryItemResponseDTO+Extensions.swift
//  grocery-app-server
//
//  Created by Rychillie Umpierre de Oliveira on 26/11/24.
//

import Foundation
import Vapor
import GroceryAppSharedDTO

extension GroceryItemResponseDTO: Content {
    init?(_ groceryItem: GroceryItem) {
        guard let groceryItemId = groceryItem.id else {
            return nil
        }

        self.init(
            id: groceryItemId,
            title: groceryItem.title,
            price: groceryItem.price,
            quantity: groceryItem.quantity
        )
    }
}
