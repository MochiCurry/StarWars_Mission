//
//  Mission.swift
//  Phun App
//
//  Created by Kerry Ferguson on 3/12/21.
//

import Foundation

struct Mission: Decodable {
    let id: Int
    let description: String?
    let title: String?
    let timestamp: String?
    let image: String?
    let date: String?
    let locationline1: String?
    let locationline2: String?
    let phone: String?
}
