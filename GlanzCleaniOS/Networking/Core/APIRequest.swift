//
//  APIRequest.swift
//  GlanzCleaniOS
//
//  Created by Adrian Gabriel Chiper on 31.12.2023.
//

import Foundation
class APIRequest {
//    class func request<T: Codable>(apiRouter: APIRouter) async throws -> T {
//        // The URLComponent is what we consturct based on the APIRouter Enum which is passed as an argument to this function
//        var components = URLComponents()
//        components.host = apiRouter.host
//        components.path = apiRouter.path
//        components.scheme = apiRouter.scheme
//        components.queryItems = apiRouter.parameters
//        
//        
//        // The URLComponent contains a property that allows us to get na optional URL back which will reutrn nil if the URL cannot be constructed. Here we throw a custom error if we fail to get the compelte URL
//        guard let url = components.url else {throw APIRequestError.badUrl}
//        
//        var urlRequest = URLRequest(url: url)
//        urlRequest.httpMethod = apiRouter.method
//        
//        let session = URLSession(configuration: .default)
//        // try await withCheckedThrowingContinuation is an Async/Await function which suspends the current task and calls the closure with the result of the async work
//        return try await withCheckedThrowingContinuation { continuation in
//            let dataTask = session.dataTask(with: urlRequest) { data, response, error in
//                if let error = error {
//                    return continuation.resume(with: .failure(error))
//                }
//                
//                guard let data = data else {return continuation.resume(with: .failure(APIRequestError.noData))}
//                
//                do {
//                    let responseObject = try JSONDecoder().decode(T.self, from: data)
//                    DispatchQueue.main.async {
//                        return continuation.resume(with: .success(responseObject))
//                    }
//                } catch {
//                    return continuation.resume(with: .failure(error))
//                }
//            }
//            dataTask.resume()
//        }
//    }
    
    
    class func request<T: Codable>(apiRouter: APIRouter) async throws -> T? {
        // The URLComponent is what we consturct based on the APIRouter Enum which is passed as an argument to this function
        var components = URLComponents()
        components.host = apiRouter.host
        components.path = apiRouter.path
        components.scheme = apiRouter.scheme
        components.queryItems = apiRouter.queryParameters
        
        
        // The URLComponent contains a property that allows us to get na optional URL back which will reutrn nil if the URL cannot be constructed. Here we throw a custom error if we fail to get the compelte URL
        guard let url = components.url else {throw APIRequestError.BadUrl}
        
        // Create the URL request
        var urlRequest = URLRequest(url: url)
        // Set headers
        if let token = UserDefaults.standard.string(forKey: "token") {
            urlRequest.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        }
        // Set the HTTP method
        urlRequest.httpMethod = apiRouter.method
        // Set the body
        if let bodyParameters = apiRouter.bodyParameters {
            //urlRequest.httpBody = try? JSONSerialization.data(withJSONObject: bodyParameters)
            urlRequest.httpBody = try? JSONEncoder().encode(bodyParameters)
            urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
        }
        // Print the request
        printRequest(urlRequest: urlRequest)
    
        let session = URLSession(configuration: .default)
        // try await withCheckedThrowingContinuation is an Async/Await function which suspends the current task and calls the closure with the result of the async work
        return try await withCheckedThrowingContinuation { continuation in
            let dataTask = session.dataTask(with: urlRequest) { data, response, error in
                if let error = error {
                    print("Request failed")
                    return continuation.resume(with: .failure(error))
                }
                
                guard let httpResponse = response as? HTTPURLResponse else {
                    print("Failed to get the http response")
                    return continuation.resume(with: .failure(APIRequestError.FailedToGetHttpResponse))
                }
                
                if httpResponse.statusCode == 401 {
                    print("Not authorized")
                    return continuation.resume(with: .failure(APIRequestError.NotAuthorized))
                }
                
                guard let data = data else {
                    if (200..<300).contains(httpResponse.statusCode) {
                        print("Success. No data returned.")
                        return continuation.resume(with: .success(nil))
                    }
                    else {
                        print("Failed. No data returned from the API")
                        return continuation.resume(with: .failure(APIRequestError.NoData))
                    }
                }
                
                do {
                    let responseObject = try JSONDecoder().decode(T.self, from: data)
                    DispatchQueue.main.async {
                        print("Success. Data successfully decoded.")
                        return continuation.resume(with: .success(responseObject))
                    }
                } catch {
                    print("Failed to decode the data.")
                    return continuation.resume(with: .failure(error))
                }
            }
            dataTask.resume()
        }
        
        func printRequest(urlRequest: URLRequest) {
            print("=== Request ===")
            print("URL: \(urlRequest.url?.absoluteString ?? "nil")")
            print("HTTP Method: \(urlRequest.httpMethod ?? "nil")")
            if let allHeaders = urlRequest.allHTTPHeaderFields {
                print("Headers:")
                for (key,value) in allHeaders {
                    print("\(key): \(value)")
                }
            }
            if let bodyData = urlRequest.httpBody, let bodyString = String(data: bodyData, encoding: .utf8) {
                print("HTTP Body:")
                print(bodyString)
            }
            print("=========================")
        }
    }
    

}
