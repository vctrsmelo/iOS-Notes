//
//  ViewController.swift
//  Notes
//
//  Created by Bart Jacobs on 05/07/2017.
//  Copyright © 2017 Cocoacasts. All rights reserved.
//

import UIKit
import CoreData

class NotesViewController: UIViewController {

    // MARK: - Segues

    private enum Segue {

        static let AddNote = "AddNote"
        static let Note = "Note"

    }

    // MARK: - Properties

    @IBOutlet weak var notesView: UIView!
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    private lazy var fetchedResultsController: NSFetchedResultsController<Note> = {
        let fetchRequest: NSFetchRequest<Note> = Note.fetchRequest()
        
        fetchRequest.sortDescriptors = [ NSSortDescriptor(key: #keyPath(Note.updatedAt), ascending: false)]
        
        let fetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: self.coreDataManager.managedObjectContext, sectionNameKeyPath: nil, cacheName: nil)
        
        fetchedResultsController.delegate = self
        
        return fetchedResultsController
    }()

    // MARK: -
    
    private var hasNotes: Bool {
        guard let fetchedObjects = fetchedResultsController.fetchedObjects else { return false}
        return fetchedObjects.count > 0
    }
    
    // MARK: -

    
    private var coreDataManager = CoreDataManager(modelName: "Notes")

    // MARK: -
    
    private let estimatedRowHeight = CGFloat(44.0)
    
    // MARK: -
    
    private lazy var updatedAtDateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM d, HH:mm"
        return dateFormatter
    }()
    
    // MARK: - View Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
    
        title = "Notes"
        
        setupView()
    
        fetchNotes()
        
        updateView()
    }

    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let identifier = segue.identifier else {
            return
        }
        
        switch identifier {
        case Segue.AddNote:
            guard let destination = segue.destination as? AddNoteViewController else {
                return
            }
            
            destination.managedObjectContext = coreDataManager.managedObjectContext
        case Segue.Note:
            guard let destination = segue.destination as? NoteViewController else {
                return
            }
            
            guard let indexPath = tableView.indexPathForSelectedRow else {
                return
            }
            
            let note = fetchedResultsController.object(at: indexPath)
            
            //Configure Destination
            destination.note = note
            
        default:
            break
        }
    }
    
    // MARK: - View Methods
    
    private func setupView() {
        setupMessageLabel()
        setupTableView()
    }
    
    private func updateView() {
        tableView.isHidden = !hasNotes
        messageLabel.isHidden = hasNotes
    }
    
    // MARK: -
    
    private func setupMessageLabel() {
        messageLabel.text = "You don't have any notes yet."
    }
    
    // MARK: -
    
    private func setupTableView() {
        tableView.isHidden = true
        tableView.estimatedRowHeight = estimatedRowHeight
        tableView.rowHeight = UITableViewAutomaticDimension
    }
    
    private func fetchNotes() {
        do {
            try fetchedResultsController.performFetch()
        } catch {
            print("Unable to Perform Fetch Request")
            print("\(error), \(error.localizedDescription)")
        }
    }

}

extension NotesViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        guard let sections = fetchedResultsController.sections else { return 0 }
        return sections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let section = fetchedResultsController.sections?[section] else { return 0 }
        return section.numberOfObjects
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Dequeue Reusable Cell
        guard let cell = tableView.dequeueReusableCell(withIdentifier: NoteTableViewCell.reuseIdentifier, for: indexPath) as? NoteTableViewCell else {
            fatalError("Unexpected Index Path")
        }
        
        configure(cell, at: indexPath)
        
        return cell
    }
    
    private func configure(_ cell: NoteTableViewCell, at indexPath: IndexPath) {
        // Fetch Note
        let note = fetchedResultsController.object(at: indexPath)

        cell.titleLabel.text = note.title
        cell.contentsLabel.text = note.contents
        cell.updatedAtLabel.text = updatedAtDateFormatter.string(from: note.updatedAtAsDate)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        guard editingStyle == .delete else { return }
        
        let note = fetchedResultsController.object(at: indexPath)
        
        coreDataManager.managedObjectContext.delete(note)
        
    }

}

extension NotesViewController: NSFetchedResultsControllerDelegate {
    
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.beginUpdates()
    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.endUpdates()

        updateView()
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        switch type {
        case .insert:
            if let indexPath = newIndexPath {
                tableView.insertRows(at: [ indexPath ], with: .fade)
            }
        case .delete:
            if let indexPath = indexPath {
                tableView.deleteRows(at: [ indexPath ], with: .fade)
            }
        case .update:
            if let indexPath = indexPath, let cell = tableView.cellForRow(at: indexPath) as?  NoteTableViewCell {
                configure(cell, at: indexPath)
            }
        case .move:
            if let indexPath = indexPath {
                tableView.deleteRows(at: [ indexPath ], with: .fade)
            }
            
            if let newIndexPath = newIndexPath {
                tableView.insertRows(at: [ newIndexPath ], with: .fade)
            }
        }
    }
    
}
