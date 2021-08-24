//
//  ApiConfiguration.swift
//  bMuse-WeatherApp
//
//  Created by Ilya Kharebashvili on 21.08.2021.
//

import Alamofire

public protocol APIConfiguration: URLRequestConvertible {
    var method: HTTPMethod { get }
    var path: String { get }
    var parameters: RequestParams { get }
    var url: String { get }
}

public extension APIConfiguration {
    
    // Creating a request based on method, parameters and path
    func asURLRequest() throws -> URLRequest {
        
        let url: URL = URL(string: url)!
        
        var urlRequest = URLRequest(url: url.appendingPathComponent(path))
        urlRequest.httpMethod = method.rawValue
        urlRequest.setValue(ContentType.json.rawValue,
                            forHTTPHeaderField: HTTPHeaderField.contentType.rawValue)
        
        switch parameters {
        case .body(let params):
            urlRequest.httpBody = try JSONSerialization.data(withJSONObject: params, options: [])
        case .url(let params):
            let queryParams = params.map { pair  in
                return URLQueryItem(name: pair.key, value: "\(pair.value)")
            }
            
            var components = URLComponents(string: url.appendingPathComponent(path).absoluteString)
            components?.queryItems = queryParams
            urlRequest.url = components?.url
        }
        
        return urlRequest
    }
}

public enum RequestParams {
    case body(_: Parameters)
    case url(_: Parameters)
}

public enum ContentType: String {
    case json = "application/json"
}

public enum HTTPHeaderField: String {
    case authentication = "Authorization"
    case contentType = "Content-Type"
}

public enum Endpoint: String {
    case weatherApi = "https://api.met.no"
    case locationApi = "https://api.bigdatacloud.net/"
}
