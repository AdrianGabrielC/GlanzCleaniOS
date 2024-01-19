//
//  APIRequestError.swift
//  GlanzCleaniOS
//
//  Created by Adrian Gabriel Chiper on 31.12.2023.
//

import Foundation
enum APIRequestError: Error {
    case BadUrl, NoData, FailedToGetHttpResponse, NotAuthorized
}
