//
//  UserModel.swift
//  grocery-app-server
//
//  Created by Rychillie Umpierre de Oliveira on 23/11/24.
//

import Foundation
import Fluent
import Vapor

final class User: Model, Content, Validatable {
    
    static let schema = "users"
    
    @ID(key: .id)
    var id: UUID?
    
    @Field(key: "username")
    var username: String
    
    @Field(key: "password")
    var password: String
    
    init() { }
    
    init(id: UUID? = nil, username: String, password: String) {
        self.id = id
        self.username = username
        self.password = password
    }
    
    static func validations(_ validations: inout Validations) {
        validations.add("username", as: String.self, is: !.empty, customFailureDescription: "Username cannot be empty.")
        validations.add("password", as: String.self, is: !.empty, customFailureDescription: "Password cannot be empty.")
        validations.add("password", as: String.self, is: .count(8...16), customFailureDescription: "Password must be between 8 and 16 characters long.")
    }
    
}
