//
//  AuthenticationService.swift
//  GlanzCleaniOS
//
//  Created by Adrian Gabriel Chiper on 18.01.2024.
//

import Foundation

class AuthenticationService {
    func register(user: POST.Register) async -> APIResponse<RegisterResponse> {
        do {
            guard let data: [RegisterResponse]? = try await APIRequest.request(apiRouter: .register(bodyParam: user)) else {return APIResponse(status: .Success, message: "Account successfully created!", data: nil)} // Created but not returned from API
            return APIResponse(status: .Success, message: "Account succesfully created!", data: data) // Created and returned from API
        } catch {
            return APIResponse(status: .Failure, message: "Failed to create account", data: nil) // Failed to create in API
        }
    }
    
    func login(user: POST.Login) async -> APIResponse<LoginResponse> {
        do {
            guard let data: LoginResponse = try await APIRequest.request(apiRouter: .login(bodyParam: user)) else {return APIResponse(status: .Failure, message: "Login failed. Data missing", data: nil)}
            if let token = data.token {
                return APIResponse(status: .Success, message: "Success login.", data: [data])
            }
            return APIResponse(status: (200..<300).contains(data.StatusCode ?? 500) ? .Success : .Failure, message: data.Message, data: [data])
        } catch {
            return APIResponse(status: .Failure, message: "Failed to login", data: nil)
        }
    }
}
