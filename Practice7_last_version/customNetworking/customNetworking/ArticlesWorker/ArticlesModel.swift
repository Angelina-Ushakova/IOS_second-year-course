//
//  ArticleModel.swift
//  customNetworking
//
//  Created by Aleksa Khruleva on 15.12.2023.
//

import Foundation

// MARK: - ArticlesModel
struct ArticlesModel: Codable {
    let news: [News]
}

// MARK: - News
struct News: Codable {
    let newsId, storyId, score: Int
    let img: Img
    let sourceName: String?
    let sourceLink: String
    let sourceIcon: String?
    let date, title, announce, sectionName: String
    let timeOfReading: String
    let genreId, clusterCount: Int
    let isRead: Bool
    let objectStat: [ObjectStat]
    let isHotNews: Bool
    let newsType: Int
    let hidden: Bool
}

// MARK: - Img
struct Img: Codable {
    let isRemote: Bool
    let width, height, brightness: Int
    let url: String
}

// MARK: - ObjectStat
struct ObjectStat: Codable {
    let typeId, count: Int
    let name: String
}
