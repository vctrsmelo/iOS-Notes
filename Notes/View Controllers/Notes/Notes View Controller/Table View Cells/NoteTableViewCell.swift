//
//  NoteTableViewCell.swift
//  Notes
//
//  Created by Victor S Melo on 25/01/18.
//  Copyright © 2018 Victor S Melo. All rights reserved.
//

import UIKit

class NoteTableViewCell: UITableViewCell {
    
    // MARK: - Static Properties
    
    static let reuseIdentifier = "NoteTableViewCell"
    
    // MARK: - Properties
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var contentsLabel: UILabel!
    @IBOutlet var updatedAtLabel: UILabel!
    
    // MARK: - Initialization
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
}
