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
    func getRockets(completion: @escaping (Result<[Rocket], Error>) -> Void)
    func saveRockets(_ rockets: [Rocket])
    func getCompanyInfo(completion: @escaping (Result<Company, Error>) -> Void)
    func saveCompanyInfo(_ company: Company)
    func getDragons(completion: @escaping (Result<[Dragon], Error>) -> Void)
    func saveDragons(_ dragons: [Dragon])
}


class CoreDataService: CoreDataServiceProtocol {
    
    private let coreDataStack: CoreDataStackProtocol
    
    
    init(coreDataStack: CoreDataStackProtocol) {
        self.coreDataStack = coreDataStack
    }
    
    
    //MARK: - Dragons
    func getDragons(completion: @escaping (Result<[Dragon], Error>) -> Void) {
        let request = MODragon.fetchRequest()
        coreDataStack.performRequest(request) { result in
            switch result {
            case .failure(let error):
                print(error.localizedDescription)
                completion(.failure(error))
            case .success(let dragons):
                guard dragons.count > 0 else {
                    completion(.failure(SpaceError.missingData))
                    return
                }
                let resultDragons = dragons.map { $0.getDragon() }
                completion(.success(resultDragons))
            }
        }
    }
    
    func saveDragons(_ dragons: [Dragon]) {
        coreDataStack.save { context in
            for dragon in dragons {
                let dragonMO = MODragon(context: context)
                dragonMO.id = dragon.id
                dragonMO.name = dragon.name
                dragonMO.dragonDescription = dragon.dragonDescription
                dragonMO.firstFight = dragon.firstFlight
                dragonMO.images = dragon.images
                dragonMO.active = dragon.active
            }
        }
    }
    
    //MARK: - Rockets
    func getRockets(completion: @escaping (Result<[Rocket], Error>) -> Void) {
        let request = MORocket.fetchRequest()
        coreDataStack.performRequest(request) { result in
            switch result {
            case .failure(let error):
                print(error.localizedDescription)
                completion(.failure(error))
            case .success(let rockets):
                guard rockets.count > 0 else {
                    completion(.failure(SpaceError.missingData))
                    return
                }
                let resultRocket = rockets.map { $0.getRocket() }
                completion(.success(resultRocket))
            }
        }
    }
    
    func saveRockets(_ rockets: [Rocket]) {
        coreDataStack.save { context in
            for rocket in rockets {
                let newRocket = MORocket(context: context)
                newRocket.active = rocket.active
                newRocket.firstFlight = rocket.firstFlight
                newRocket.id = rocket.id
                newRocket.images = rocket.images
                newRocket.name = rocket.name
                newRocket.rocketDescription = rocket.rocketDescription
                newRocket.stages = Int16(rocket.stages)
                newRocket.firstStage = tryToGetStageMO(rocket.firstStage, context: context)
                newRocket.secondStage = tryToGetStageMO(rocket.secondStage, context: context)
            }
        }
        
        func tryToGetStageMO(_ stage: Stage?, context: NSManagedObjectContext) -> MOStage? {
            guard let stage = stage else { return nil }
            let stageMO = MOStage(context: context)
            stageMO.reusable = stage.reusable ?? false
            stageMO.engines = Int32(stage.engines ?? 0)
            stageMO.fuelAmountTons = stage.fuelAmountTons ?? 0
            stageMO.burnTimeSec = Int64(stage.burnTimeSec ?? 0)
            stageMO.thrust = tryToGetThrustMO(stage.thrust, context: context)
            stageMO.thrustVacuum = tryToGetThrustMO(stage.thrustVacuum, context: context)
            stageMO.thrustSeaLevel = tryToGetThrustMO(stage.thrustSeaLevel, context: context)
            return stageMO
        }
        
        func tryToGetThrustMO(_ thrust: Thrust?, context: NSManagedObjectContext) -> MOThrust? {
            guard let thrust = thrust else { return nil }
            let thrustMO = MOThrust(context: context)
            thrustMO.kN = Int64(thrust.kN)
            thrustMO.lbf = Int64(thrust.lbf)
            return thrustMO
        }
    }
    
    func tryToGetThrustMO(_ thrust: Thrust?, context: NSManagedObjectContext) -> MOThrust? {
        guard let thrust = thrust else { return nil }
        let thrustMO = MOThrust(context: context)
        thrustMO.kN = Int64(thrust.kN)
        thrustMO.lbf = Int64(thrust.lbf)
        return thrustMO
    }
    
    
    //MARK: - Company Info
    func getCompanyInfo(completion: @escaping (Result<Company, Error>) -> Void) {
        let request = MOCompany.fetchRequest()
        coreDataStack.performRequest(request) { result in
            switch result {
            case .failure(let error):
                print(error.localizedDescription)
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
