//
//  File.swift
//  
//
//  Created by Константин Маламуж on 28.10.2021.
//

import Foundation

enum RequestBuilder {

    case rockets
    case rocket(String)
    case dragons
    case launches
    case launch(String)
    case companyInfo
    
    func build() throws -> URLRequest {
        
        let apiVersion = "v4"
        
        var urlComponent = URLComponents()
        urlComponent.scheme = "https"
        urlComponent.host = "api.spacexdata.com"
        
        switch self {
        case .rockets:
            urlComponent.path = "/\(apiVersion)/rockets"
            
        case .rocket(let id):
            urlComponent.path = "/\(apiVersion)/rockets/\(id)"
            
        case .dragons:
            urlComponent.path = "/\(apiVersion)/dragons"
            
        case .launches:
            urlComponent.path = "/\(apiVersion)/launches/"
            
        case .launch(let id):
            urlComponent.path = "/\(apiVersion)/launches/\(id)"

        case .companyInfo:
            urlComponent.path = "/\(apiVersion)/company/"
            
        }
        
        guard let url = urlComponent.url else { throw SpaceError.urlError }
        
        return URLRequest(url: url)
        
    }
    
}
