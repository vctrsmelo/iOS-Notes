//
//  NoteViewController.swift
//  Notes
//
//  Created by Victor S Melo on 26/01/18.
//  Copyright © 2018 Victor S Melo. All rights reserved.
//

import UIKit

class NoteViewController: UIViewController {
    
    // MARK: - Properties
    
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var contentsTextView: UITextView!
    
    var note: Note?
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Edit Note"
        
        setupView()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        guard let note = note else { return }
        
        if let title = titleTextField.text, !title.isEmpty && note.title != title {
            note.title = title
        }
        
        if note.contents != contentsTextView.text {
            note.contents = contentsTextView.text
        }
        
        if note.isUpdated {
            note.updatedAt = Date()
        }
        
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
    }
    
    private func setupView() {
        setupTitleTextField()
        setupContentsTextView()
    }
    
    private func setupTitleTextField() {
        titleTextField.text = note?.title
    }
    
    private func setupContentsTextView() {
        contentsTextView.text = note?.contents
    }
    
}
