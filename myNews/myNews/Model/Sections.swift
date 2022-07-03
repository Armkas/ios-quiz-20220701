//
//  Sections.swift
//  myNews
//
//  Created by Pu Yue - PU YUE on 2022/06/28.
//

import Foundation

struct Sections: Codable {
    let sections: [Section]
}

struct Section: Codable {
    let title: String?//タイトル大　SectionCell
    let groups: [Item]
}

struct Item: Codable {
    let title: String?//タイトル小 ItemCell
    let hits: [Hit]
}

struct Hit: Codable {
    let id: String?
    let label: String?
    let type: String?
    let followersCount: Int?

    enum CodingKeys: String, CodingKey {
        case id
        case label
        case type
        case followersCount = "followers_count"
    }
}
