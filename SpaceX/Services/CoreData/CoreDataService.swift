//
//  CoreDataService.swift
//  SpaceX
//
//  Created by Константин Маламуж on 04.12.2021.
//

import Foundation
import SpaceSDK
import CoreData


protocol CoreDataServiceProtocol {
    func getCompanyInfo(completion: @escaping (Result<Company, Error>) -> Void)
    func saveCompanyInfo(_ company: Company)
}


class CoreDataService: CoreDataServiceProtocol {
    
    private let coreDataStack: CoreDataStackProtocol
    
    
    init(coreDataStack: CoreDataStackProtocol) {
        self.coreDataStack = coreDataStack
    }
    
    
    func getCompanyInfo(completion: @escaping (Result<Company, Error>) -> Void) {
        let request = MOCompany.fetchRequest()
        coreDataStack.performRequest(request) { result in
            switch result {
            case .failure(let error):
                print(error)
                completion(.failure(error))
            case .success(let companyData):
                guard let company = companyData.first else {
                    completion(.failure(SpaceError.decodeError))
                    return
                }
                completion(.success(company.getCompany()))
            }
        }
    }
    
    func saveCompanyInfo(_ company: Company) {
        coreDataStack.save { context in
            let dataCompany = MOCompany(context: context)
            dataCompany.ceo = company.ceo
            dataCompany.coo = company.coo
            dataCompany.cto = company.cto
            dataCompany.ctoPropulsion = company.ctoPropulsion
            dataCompany.employees = Int32(company.employees)
            dataCompany.founded = Int16(company.founded)
            dataCompany.founder = company.founder
            dataCompany.name = company.name
            dataCompany.summary = company.summary
        }
    }
    
}
