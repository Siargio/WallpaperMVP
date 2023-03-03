//
//  NetworkService.swift
//  WallpaperMVP
//
//  Created by Sergio on 3.03.23.
//

import Foundation

protocol NetworkServiceProtocol: AnyObject {
    func performRequest<T: Decodable>(endpoint: EndpointProtocol, completion: @escaping (Result<T, Error>) -> Void)
}

final class NetworkService: NetworkServiceProtocol {
    func performRequest<T: Decodable>(endpoint: EndpointProtocol, completion: @escaping (Result<T, Error>) -> Void) {
        var components = URLComponents()
        components.scheme = endpoint.scheme
        components.percentEncodedHost = endpoint.host
        components.path = endpoint.path
        components.queryItems = endpoint.parameters

        guard let url = components.url else { return }
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = endpoint.method.rawValue

        if let headers = endpoint.headers {
            for (key, value) in headers {
                urlRequest.setValue(value, forHTTPHeaderField: key)
            }
        }

        URLSession.shared.dataTask(with: urlRequest) { data, _, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            do {
                if let data = data {
                    if let JSONString = String(data: data, encoding: String.Encoding.utf8)
                    {
                        print(JSONString)
                    }
                    let obj = try JSONDecoder().decode(T.self, from: data)
                    completion(.success(obj))
                }
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
}

