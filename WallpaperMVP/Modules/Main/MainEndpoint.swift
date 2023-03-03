//
//  MainEndpoint.swift
//  WallpaperMVP
//
//  Created by Sergio on 3.03.23.
//

import Foundation

enum MainEndpoint: EndpointProtocol {
    case getCuratedPhotos(page: Int)
    case getPhotosByName(keyword: String, page: Int)

    var scheme: String {
        return "https"
    }

    var host: String {
        return "api.pexels.com"
    }

    var method: RequestMethod {
        return .GET
    }

    var headers: [String: String]? {
        return ["Authorization" : "1tdfoPtrGNI02OzqgaxkGyibkJ1KAk9agmGU1rCqZAPjAEwFWH4RdECh"]
    }

    var path: String {
        switch self {
        case .getCuratedPhotos:
            return "/v1/curated"
        case .getPhotosByName:
            return "/v1/search"
        }
    }

    var parameters: [URLQueryItem]? {
        switch self {
        case .getCuratedPhotos(let page):
            return [
                URLQueryItem(name: "page", value: "\(page)"),
                URLQueryItem(name: "per_page", value: "16")
            ]
        case .getPhotosByName(let query , let page):
            return [
                URLQueryItem(name: "query", value: "\(query)"),
                URLQueryItem(name: "page", value: "\(page)"),
            ]
        }
    }
}
