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
        return Strings.scheme
    }

    var host: String {
        return Strings.host
    }

    var method: RequestMethod {
        return .GET
    }

    var headers: [String: String]? {
        return [Strings.authorization : Strings.headers]
    }

    var path: String {
        switch self {
        case .getCuratedPhotos:
            return Strings.pathCurated
        case .getPhotosByName:
            return Strings.pathSearch
        }
    }

    var parameters: [URLQueryItem]? {
        switch self {
        case .getCuratedPhotos(let page):
            return [
                URLQueryItem(name: Strings.page, value: "\(page)"),
                URLQueryItem(name: Strings.per_page, value: Strings.value)
            ]
        case .getPhotosByName(let query , let page):
            return [
                URLQueryItem(name: Strings.query, value: "\(query)"),
                URLQueryItem(name: Strings.page, value: "\(page)"),
            ]
        }
    }
}

// MARK: - Strings
extension MainEndpoint {
    enum Strings {
        static let scheme = "https"
        static let host = "api.pexels.com"
        static let authorization = "Authorization"
        static let headers = "1tdfoPtrGNI02OzqgaxkGyibkJ1KAk9agmGU1rCqZAPjAEwFWH4RdECh"
        static let pathCurated = "/v1/curated"
        static let pathSearch = "/v1/search"
        static let page = "page"
        static let per_page = "per_page"
        static let value = "16"
        static let query = "query"
    }
}
