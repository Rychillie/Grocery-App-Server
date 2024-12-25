//
//  GroceryCategoryResponseDTO+Extensions.swift
//  grocery-app-server
//
//  Created by Rychillie Umpierre de Oliveira on 24/11/24.
//

import Foundation
import GroceryAppSharedDTO
import Vapor

extension GroceryCategoryResponseDTO: Content {

    init?(_ groceryCategory: GroceryCategory) {
        guard let id = groceryCategory.id
        else {
            return nil
        }

        self.init(id: id, title: groceryCategory.title, colorCode: groceryCategory.colorCode)
    }

}

