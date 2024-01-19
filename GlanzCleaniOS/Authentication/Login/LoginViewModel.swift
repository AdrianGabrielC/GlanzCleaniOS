//
//  LoginViewModel.swift
//  GlanzCleaniOS
//
//  Created by Adrian Gabriel Chiper on 18.01.2024.
//

import Foundation

@MainActor
class LoginViewModel: ObservableObject {
    var serviceManager = ServiceManager()
    @Published var email = "info.glanzclean@gmail.com"
    @Published var password = "Parolamea1!"
    @Published var isLoading = false
    @Published var showErr = false
    
    func login() async -> Void  {
        showErr = false
        let user = POST.Login(userName: self.email, password: self.password)
        isLoading = true
        var result = await ContentViewModel.shared.login(user: user)
        showErr = result == .Failure
        isLoading = false
    }
}
