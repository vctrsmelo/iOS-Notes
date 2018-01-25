//
//  ViewController.swift
//  Notes
//
//  Created by Victor S Melo on 25/01/18.
//  Copyright © 2018 Victor S Melo. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    // MARK: - Properties

    private var coreDataManager = CoreDataManager(modelName: "Notes")
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
    }


}

