//
//  Todo.swift
//  todos
//
//  Created by Ruben Granet on 30/08/2022.
//

import Foundation

struct Todo {
    let id : Int
    let title : String
    var completed:Bool
    var isImportant = false
    
}

extension Todo : Codable {
     enum CodingKeys: String, CodingKey {
        case id
        case title
        case completed
     }
}
extension Todo : Identifiable {}
extension Todo : Equatable {}
