//
//  ViewController.swift
//  Notes
//
//  Created by Bart Jacobs on 05/07/2017.
//  Copyright © 2017 Cocoacasts. All rights reserved.
//

import UIKit

class NotesViewController: UIViewController {

    // MARK: - Segues

    private enum Segue {

        static let AddNote = "AddNote"

    }

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
