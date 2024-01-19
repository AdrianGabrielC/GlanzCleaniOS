//
//  ContentViewModel.swift
//  GlanzCleaniOS
//
//  Created by Adrian Gabriel Chiper on 18.01.2024.
//

import Foundation

@MainActor
class ContentViewModel: ObservableObject {
    static let shared = ContentViewModel()
    var serviceManager = ServiceManager()
    
    @Published var isLogged = UserDefaults.standard.string(forKey: "token") != nil
    @Published var isLoading = false
    
    private init() {}
    
    @Published var token:String = (UserDefaults.standard.string(forKey: "token") ?? "")
    
    func register(user: POST.Register) async -> APIResponseStatus {
        isLoading = true
        let result = await serviceManager.authenticationService.register(user: user)
        if result.status == .Success {
            return await login(user: POST.Login(userName: user.email, password: user.password))
        }
        else {
            print("Failed to register:\(result.message)")
            return .Failure
        }
    }
    
    func login(user: POST.Login) async -> APIResponseStatus {
        isLoading = true
        let result = await serviceManager.authenticationService.login(user: user)
        isLoading = false
        if result.status == .Success, let token = result.data?[0].token {
            UserDefaults.standard.set(token, forKey: "token")
            self.token = token
            isLogged = true
            return .Success
        }
        else {
            print("Failed to login:\(result.message)")
            return .Failure
        }
        
    }
    
    func logout() {
        UserDefaults.standard.removeObject(forKey: "token")
        self.token = ""
        self.isLogged = false
    }
    
}
