//
//  File.swift
//  
//
//  Created by Константин Маламуж on 28.10.2021.
//

import Foundation


protocol NetworkManagerProtocol {
    
    func fetch<T: Codable> (endpoint: RequestBuilder, completion: @escaping (Result<T, SpaceError>) -> Void)
    
}

class NetworkManager: NetworkManagerProtocol {
    
    let configuration: URLSessionConfiguration
    let session: URLSession
    
    public func fetch<T: Codable> (endpoint: RequestBuilder, completion: @escaping (Result<T, SpaceError>) -> Void) {
        
        do {
            let request = try endpoint.build()
            
            sendRequest(request) { result in
                switch result {
                case .failure(let error):
                    completion(.failure(error))
                case .success(let data):
                    do {
                        let jsonDecoder = JSONDecoder()
                        let rockets = try jsonDecoder.decode(T.self, from: data)
                        completion(.success(rockets))
                    } catch {
                        completion(.failure(.decodeError))
                    }
                }
            }
        } catch {
            completion(.failure(.urlError))
        }
        
    }
    
    private func sendRequest(_ request: URLRequest, completion: @escaping (Result<Data, SpaceError>) -> Void) {

        session.dataTask(with: request) { data, _, _ in
            guard let data = data else {
                DispatchQueue.main.async {
                    completion(.failure(.missingData))
                }
                return
            }
            DispatchQueue.main.async {
                completion(.success(data))
            }
        }
        .resume()

    }

    init() {
        configuration = URLSessionConfiguration()
        session = URLSession.shared
    }

}
