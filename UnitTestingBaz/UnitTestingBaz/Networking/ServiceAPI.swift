//
//  ServiceAPI.swift
//  UnitTestingBaz
//
//  Created by Heber Raziel Alvarez Ruedas on 31/10/22.
//

import Foundation

enum ServiceError: Error {
    case noData
    case response
    case parsingData
    case internalServer
}

protocol URLSessionDataTaskProtocol {
    func resume()
}

extension URLSessionDataTask: URLSessionDataTaskProtocol {}

extension URLSession: URLSessionProtocol {
    func performDataTask(with request: URLRequest, completionHandler: @escaping DataTaskResult) -> URLSessionDataTaskProtocol {
        return dataTask(with: request, completionHandler: completionHandler) as URLSessionDataTaskProtocol
    }
}

protocol URLSessionProtocol { typealias DataTaskResult = (Data?, URLResponse?, Error?) -> Void
    func performDataTask(with request: URLRequest, completionHandler: @escaping DataTaskResult) -> URLSessionDataTaskProtocol
}

class ServiceAPI {
    let session: URLSessionProtocol
    
    init(session: URLSessionProtocol) {
        self.session = session
    }
    
    func get(_ endpoint: Endpoint, callback: @escaping (_ data: Data?, _ error: Error?) -> Void) {
        let request = endpoint.request
        let task = session.performDataTask(with: request) { (data, response, error) in
            if let error: Error = error {
                debugPrint("error", error)
                callback(nil, error)
                return
            }
            
            guard let data: Data = data else {
                callback(nil, ServiceError.response)
              return
            }
            
            guard let response: HTTPURLResponse = response as? HTTPURLResponse else {
              callback(nil, ServiceError.response)
              return
            }
            
            guard (200 ... 299) ~= response.statusCode else {
              print("statusCode should be 2xx, but is \(response.statusCode)")
              print("response = \(response)")
              callback(nil, ServiceError.internalServer)
              return
            }
            
            callback(data, error)
            
//            do {
//              let postTweet = try JSONDecoder().decode(PokemonList.self, from: data)
//                callback(data, nil)
//            } catch {
//              callback(nil, ServiceError.parsingData)
//            }
        }
        task.resume()
    }
    
    //    func load(_ endpoint: Endpoint, completion: @escaping (Result<[Movies], Error>) -> ()) {
    //
    //        let request = endpoint.request
    //        session.dataTask(with: request) { data, response, error in
    //
    //            if let error = error {
    //                completion(.failure(error))
    //                return
    //            }
    //
    //            guard let data = data else {
    //                completion(.failure(TweetAPIError.noData))
    //                return
    //            }
    //
    //            do {
    //                let timeline = try JSONDecoder().decode([Tweet].self, from: data)
    //                completion(.success(timeline))
    //
    //            } catch {
    //                completion(.failure(TweetAPIError.parsingData))
    //            }
    //
    //        }.resume()
    //    }
    
}
