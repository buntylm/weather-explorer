//
//  CoreData.swift
//  Weather
//
//  Created by bunty.madan on 20/8/19.
//  Copyright © 2019 Bunty Madan. All rights reserved.
//

import Foundation
import CoreData

class CoreData {
    static let shared = CoreData()
    
    private init() { }
    private var fetchBatchSize = 10
    
    internal lazy var context = persistentContainer.viewContext
    
    private lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "Weather")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if error == nil {
                print("All good !!! Core data is ready to use.")
            }
        })
        return container
    }()
    
    public func save() {
        if context.hasChanges {
            try? context.save()
        } else {
        }
    }
    
    //MARK: Public functionality
    public func needToSave(_ areaName: String, country: String) -> Bool  {
        let predicate = NSPredicate(format: "areaName == %@ && country == %@", areaName, country)
        guard let count = fetch(CityCoreDataModel.self, predicate: predicate)?.count, count == 0 else {
            return false
        }
        return true
    }
    
    public func fetch<T: NSManagedObject>(_ type: T.Type, predicate: NSPredicate? = nil) -> [T]? {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>.init(entityName: String(describing: type))
        fetchRequest.predicate = predicate
        fetchRequest.fetchLimit = 10
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "createdDate", ascending: false)]
        return try? context.fetch(fetchRequest) as? [T]
    }
    
    public func insert<T: NSManagedObject>(_ type: T.Type, responseModel: PersistenanceProtocol) {
        responseModel.map(T.init(context: context))
        save()
    }
    
    public func obliterate<T: NSManagedObject>(type: T.Type, predicate: NSPredicate? = nil)   {
        let fetchRequest = NSFetchRequest<T>.init(entityName: String(describing: type))
        fetchRequest.predicate = predicate
        for result in try! context.fetch(fetchRequest) {
            context.delete(result)
        }
        save()
    }
    
}
