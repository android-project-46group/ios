//
//  File.swift
//  saka
//
//  Created by Takahiro Tominaga on 2022/01/22.
//

import Foundation

struct Member: Identifiable, Codable {
    let id = UUID()
    var user_id: Int
    var user_name: String
    var birthday: String
    var generation: String
    var height: String
    var blood_type: String
    var blog_url: String
    var img_url: String
}
