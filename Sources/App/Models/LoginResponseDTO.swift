//
//  LoginResponseDTO.swift
//  grocery-app-server
//
//  Created by Rychillie Umpierre de Oliveira on 23/11/24.
//

import Foundation
import Vapor

struct LoginResponseDTO: Content {
    let error: Bool
    var reason: String? = nil
    let token: String?
    let userId: UUID
}
