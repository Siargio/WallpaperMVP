//
//  EndpointProtocol.swift
//  WallpaperMVP
//
//  Created by Sergio on 3.03.23.
//

import Foundation

protocol EndpointProtocol {
    var scheme: String { get }
    var host: String { get }
    var method: RequestMethod { get }
    var headers: [String: String]? { get }
    var path: String { get }
    var parameters: [URLQueryItem]? { get }
}

extension EndpointProtocol {
    var headers: [String: String]? {
       return nil
    }

    var parameters: [URLQueryItem]? {
        return nil
    }
}
