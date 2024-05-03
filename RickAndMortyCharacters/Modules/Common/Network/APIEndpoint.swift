//
//  APIEndpoint.swift
//  RickAndMortyCharacters
//
//  Created by Dmytro Kmytiuk on 02.05.2024.
//

import Foundation

protocol APIEndpoint {
    var baseURL: URL { get }
    var path: String { get }
    var method: HTTPMethod { get }
    var parameters: [String: Any]? { get }
}

enum HTTPMethod: String {
    case get = "GET"
}

fileprivate enum APIError: Error {
    case invalidResponse
    case invalidData
}

enum RickAndMortyEndpoint: APIEndpoint {
    case getCharacters(page: Int)
    
    var baseURL: URL {
        guard let url = URL(string: "https://rickandmortyapi.com") else {
            fatalError("Failed to create baseURL.")
        }
        return url
    }
    
    var path: String {
        switch self {
        case .getCharacters:
            return "/api/character/"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .getCharacters:
            return .get
        }
    }
    
    var parameters: [String : Any]? {
        switch self {
        case .getCharacters(let page):
            return ["page": page]
        }
    }
}

protocol APIClient {
    associatedtype EndpointType: APIEndpoint
    func request<T: Decodable>(_ endpoint: EndpointType) async throws -> T
}

struct URLSessionAPIClient<EndpointType: APIEndpoint>: APIClient {
    func request<T: Decodable>(_ endpoint: EndpointType) async throws -> T {
        var components = URLComponents(url: endpoint.baseURL, resolvingAgainstBaseURL: true)
        components?.path = endpoint.path
        
        if let parameters = endpoint.parameters {
            components?.queryItems = parameters.map{ key, value in
                URLQueryItem(name: key, value: "\(value)")
            }
        }
        
        guard let url = components?.url else {
            throw URLError(.badURL)
        }
                
        var request = URLRequest(url: url)
        request.httpMethod = HTTPMethod.get.rawValue
        
        do {
            let (data, response) = try await URLSession.shared.data(for: request)
            guard let httpResponse = response as? HTTPURLResponse,
                  (200...299).contains(httpResponse.statusCode) else {
                throw APIError.invalidResponse
            }
            let decodedData = try JSONDecoder().decode(T.self, from: data)
            return decodedData
        } catch {
            throw error
        }
    }
}
