//
//  CoreDataStack.swift
//  SpaceX
//
//  Created by Константин Маламуж on 02.12.2021.
//

import Foundation
import CoreData


protocol CoreDataStackProtocol {
    func save(completion: @escaping (NSManagedObjectContext) -> Void)
    func performRequest<T: NSFetchRequestResult>(_ request: NSFetchRequest<T>,
                        completion: @escaping (Result<[T], Error>) -> Void)
}


class CoreDataStack: CoreDataStackProtocol {
    
    let container: NSPersistentContainer
    let coordinator: NSPersistentStoreCoordinator
    let viewContext: NSManagedObjectContext
    let backgroundContext: NSManagedObjectContext
    
    init(storageName: String) {
        container = NSPersistentContainer(name: storageName)
        container.loadPersistentStores { description, error in
            print(description)
        }
        
        coordinator = container.persistentStoreCoordinator
    
        viewContext = container.viewContext
        backgroundContext = container.newBackgroundContext()
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(contextDidChange(notification:)),
                                               name: Notification.Name.NSManagedObjectContextDidSave,
                                               object: self.backgroundContext)
    }
    
    @objc func contextDidChange(notification: Notification) {
        coordinator.performAndWait {
            viewContext.performAndWait {
                viewContext.mergeChanges(fromContextDidSave: notification)
            }
        }
    }

    
    func save(completion: @escaping (NSManagedObjectContext) -> Void) {
        backgroundContext.performAndWait {
            completion(backgroundContext)
            if backgroundContext.hasChanges {
                do {
                    try backgroundContext.save()
                } catch {
                    print(error.localizedDescription)
                }
            }
        }
    }
    
    
    func performRequest<T: NSFetchRequestResult>(_ request: NSFetchRequest<T>,
                        completion: @escaping (Result<[T], Error>) -> Void) {
        do {
            let fetchedData = try viewContext.fetch(request)
            
            completion(.success(fetchedData))
        } catch {
            completion(.failure(error))
        }
    }
    
}
