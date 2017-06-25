//
//  ViewController.swift
//  CoreDataTemplate
//
//  Created by John marru Llurag on 26/06/2017.
//  Copyright © 2017 John marru Llurag. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var db = DBController()
    var sampleData = DataModel(column1: "1", column2: "Marru", column3: "Llurag")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func pressAddButton(_ sender: UIButton) {
        
        if db.addRow(sampleData) {
            print("success")
        }
        
        db.fetchData()
        
    }

    @IBAction func pressUpdateButton(_ sender: UIButton) {
        let sampleDataToUpdate = DataModel(column1: "1", column2: "John", column3: "Doe")
        
        if db.updateRow(sampleDataToUpdate) {
            print("success")
        }
        
        db.fetchData()
        
    }
    
    @IBAction func pressDeleteButton(_ sender: UIButton) {
        if db.deleteRow(sampleData) {
            print("success")
        }
        
        db.fetchData()
    }
    
    
    

}

