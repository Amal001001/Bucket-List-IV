//  Tasks.swift
//  Bucket List

import Foundation

struct Tasks: Codable{
    var id: Int
    var objective: String
    var createdAt: String
    
    enum CodingKeys: String, CodingKey {
            case  id
            case objective
            case createdAt = "created_at"
    }
}
