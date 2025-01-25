//
//  JSONWebTokenAuthenticator.swift
//  grocery-app-server
//
//  Created by Rychillie Umpierre de Oliveira on 24/01/25.
//

import Foundation
import Vapor

struct JSONWebTokenAuthenticator: AsyncRequestAuthenticator {

    func authenticate(request: Request) async throws {
        try request.jwt.verify(as: AuthPayload.self)
    }

}