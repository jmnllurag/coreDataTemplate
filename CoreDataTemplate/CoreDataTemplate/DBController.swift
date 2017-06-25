//
//  DBController.swift
//  CoreDataTemplate
//
//  Created by John marru Llurag on 26/06/2017.
//  Copyright © 2017 John marru Llurag. All rights reserved.
//

import Foundation
import CoreData
import UIKit

class DBController {
    
    var dataModels = [DataModel]()
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    var context: NSManagedObjectContext?

    init() {
        
        if #available(iOS 10.0, *) {
            context = appDelegate.persistentContainer.viewContext
        } else {
            // iOS 9.0 and below
            context = appDelegate.managedObjectContext
        }
        
        print("DB initialized.")
    }
    
    func fetchData() -> Bool{
        
        dataModels = [DataModel]()
        
        
        //get the data from coredata
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "CoreDataEntityName")
        
        request.returnsObjectsAsFaults = false
        
        do
        {
            let results = try context?.fetch(request)
            
            if (results?.count)! > 0{
                for result in results as! [NSManagedObject]
                {
                    var fetchedData = DataModel(column1: "", column2: "", column3: "")
                    
                    if let column1 = result.value(forKey: "column1") as? String
                    {
                        fetchedData.column1 = column1
                    }
                    if let column2 = result.value(forKey: "column2") as? String
                    {
                        fetchedData.column2 = column2
                    }
                    
                    if let column3 = result.value(forKey: "column3") as? String
                    {
                        fetchedData.column3 = column3
                    }
                    print("\(fetchedData.column1): \(fetchedData.column2) \(fetchedData.column3)")
                    dataModels.append(fetchedData)
                }
            }
            
            return true
        }
        catch
        {
            print(error)
            return false
        }
        
    }
    
    func addRow(_ data: DataModel) -> Bool {
        
        let newData = NSEntityDescription.insertNewObject(forEntityName: "CoreDataEntityName", into:context!)
        
        newData.setValue(data.column1, forKey: "column1")
        newData.setValue(data.column2, forKey: "column2")
        newData.setValue(data.column3, forKey: "column3")
        
        do
        {
            try context?.save()
            let newData = data
            
            //update the array of model
            self.dataModels.append(newData)
            print("Saved")
            
            return true
        }
        catch
        {
            print(error)
            return false
        }
        
    }
    
    func deleteRow(_ data: DataModel)  -> Bool {
        
        for model in dataModels{
            if model.column1 == data.column1 {
                
                //update the array of model
                dataModels.remove(at: dataModels.index(of: model)!)
                
                let request = NSFetchRequest<NSFetchRequestResult>(entityName: "CoreDataEntityName")
                
                request.returnsObjectsAsFaults = false
                
                //delete the data from context
                do
                {
                    let results = try context?.fetch(request)
                    
                    if (results?.count)! > 0{
                        for result in results as! [NSManagedObject]
                        {
                            var fetchedData = DataModel(column1: "", column2: "", column3: "")

                            if let column1 = result.value(forKey: "column1") as? String
                            {
                                fetchedData.column1 = column1
                            }
                            if let column2 = result.value(forKey: "column2") as? String
                            {
                                fetchedData.column2 = column2
                            }
                            
                            if let column3 = result.value(forKey: "column3") as? String
                            {
                                fetchedData.column3 = column3
                            }
                            //Find the object and delete it
                            if model.column1 == fetchedData.column1 && model.column2 == fetchedData.column2 && model.column3 == fetchedData.column3
                            {
                                context?.delete(result)
                            }
                        }
                    }
                }
                catch
                {
                    return false
                }
                
                do
                {
                    try context?.save()
                    print("Deleted")
                   
                    return true
                }
                catch
                {
                    print(error)
                    return false
                    
                }
                
            }
        }
        
        return false
    }
    
    func updateRow(_ data: DataModel) -> Bool {
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "CoreDataEntityName")
        let predicate = NSPredicate(format: "column1 = '\(data.column1)'")
        request.predicate = predicate
        
        //update the array of model
        for index in 0..<dataModels.count {
            if dataModels[index].column1 ==  data.column1 {
                dataModels[index].column2 = data.column2
                dataModels[index].column3 = data.column3
            }
        }
        
        //update the coredata DB
        do
        {
            let test = try context?.fetch(request)
            if test?.count == 1
            {
                let objectUpdate = test![0] as! NSManagedObject
                objectUpdate.setValue(data.column1, forKey: "column1")
                objectUpdate.setValue(data.column2, forKey: "column2")
                objectUpdate.setValue(data.column3, forKey: "column3")
                do{
                    try context?.save()
                    print("Updated")
                    
                    return true
                }
                catch
                {
                    print(error)
                    return false
                }
            }
        }
        catch
        {
            print(error)
            return false
        }

        return false
    }

}


