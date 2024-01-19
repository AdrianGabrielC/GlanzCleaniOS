//
//  SelectableObjectProtocol.swift
//  GlanzCleaniOS
//
//  Created by Adrian Gabriel Chiper on 19.01.2024.
//

import Foundation
struct SelectableObject: Selectable {
    var id: String
    var name: String
    var secondaryName:String?
    var isActive:Bool?
    var email: String?
    var selected:Bool
    var img: String?
    var assetImg: String?
}

enum SelectableObjectType {
    case customer, facility, operation, employee
}

protocol SelectableObjectsProvider: ObservableObject {
    associatedtype T: Selectable
    var selectableObjects: [T] {get set}
    var newSelectableObject: SelectableObject? {get set}
    
    func addItem(type: SelectableObjectType) async -> APIResponseStatus
    func getData(type: SelectableObjectType) async -> APIResponseStatus
}

protocol Selectable {
    var name: String {get set }
    var secondaryName:String? {get set}
    var isActive: Bool? {get set}
    var email: String? {get set}
    var selected:Bool {get set}
    var img: String? {get set}
    var assetImg: String? {get set}
}
