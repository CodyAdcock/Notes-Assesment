//
//  DetailViewController.swift
//  Notes Assesment
//
//  Created by Cody on 8/24/18.
//  Copyright © 2018 Cody Adcock. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    //landing pad
    var note: Note?
    
    //IBOutlets
    @IBOutlet weak var detailTextView: UITextView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    //view will appear
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateViews()
    }
    
    //update views
    func updateViews() {
        // unwrap a entry
        guard let note = note else {return}
        // set the outlets properties to your object properties
        detailTextView.text = note.detail
        
    }
    
    //save button tap
    @IBAction func saveButtonTapped(_ sender: Any) {
        //unwrap the text view
        guard let newDetail = detailTextView.text else {return}
        
        // check to see if we need to update or create new based on if the note exists or not
        if let note = note{
            NoteController.shared.updateNote(note, newDetail)
        }else{
            NoteController.shared.createNote(newDetail)
        }
        navigationController?.popViewController(animated: true)
    }
    
    
    

}
