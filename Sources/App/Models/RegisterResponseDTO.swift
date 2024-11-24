//
//  RegisterResponseDTO.swift
//  grocery-app-server
//
//  Created by Rychillie Umpierre de Oliveira on 23/11/24.
//

import Foundation
import Vapor

struct RegisterResponseDTO: Content {
    let error: Bool
    var reason: String? = nil
}
