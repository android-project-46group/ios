//
//  File.swift
//  saka
//
//  Created by Takahiro Tominaga on 2022/01/22.
//

import Foundation

struct Member: Identifiable, Codable {
    var id = UUID()
    var user_id: Int
    var user_name: String
    var birthday: String
    var generation: String
    var height: String
    var blood_type: String
    var blog_url: String
    var img_url: String

    private enum CodingKeys: String, CodingKey {
        case user_id
        case user_name
        case birthday
        case generation
        case height
        case blood_type
        case blog_url
        case img_url
    }
}
