//
//  Note.swift
//  Notes
//
//  Created by Victor S Melo on 25/01/18.
//  Copyright © 2018 Victor S Melo. All rights reserved.
//

import Foundation

extension Note {
    var updatedAtAsDate: Date {
        return updatedAt ?? Date()
    }
    
    var createdAtAsDate: Date {
        return createdAt ?? Date()
    }
}
