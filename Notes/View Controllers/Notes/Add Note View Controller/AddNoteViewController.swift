//
//  AddNoteViewController.swift
//  Notes
//
//  Created by Bart Jacobs on 06/07/2017.
//  Copyright © 2017 Cocoacasts. All rights reserved.
//

import UIKit

class AddNoteViewController: UIViewController {

    // MARK: - Properties

    @IBOutlet var titleTextField: UITextField!
    @IBOutlet var contentsTextView: UITextView!

    // MARK: - View Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Add Note"
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        // Show Keyboard
        titleTextField.becomeFirstResponder()
    }

    // MARK: - Actions

    @IBAction func save(sender: UIBarButtonItem) {

    }

}
