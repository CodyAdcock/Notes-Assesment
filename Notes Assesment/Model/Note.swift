//
//  Note.swift
//  Notes Assesment
//
//  Created by Cody on 8/24/18.
//  Copyright © 2018 Cody Adcock. All rights reserved.
//

import Foundation

class Note: Equatable, Codable{
    static func == (lhs: Note, rhs: Note) -> Bool{
        if lhs.detail != rhs.detail {return false}
        return true
    }
    
    var detail: String
    
    init(_ detail: String){
        self.detail = detail
    }
    
}
