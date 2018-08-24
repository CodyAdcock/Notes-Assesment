//
//  NoteTableViewController.swift
//  Notes Assesment
//
//  Created by Cody on 8/24/18.
//  Copyright © 2018 Cody Adcock. All rights reserved.
//

import UIKit

class NoteTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return NoteController.shared.notes.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //reuse cells
        let cell = tableView.dequeueReusableCell(withIdentifier: "noteCell", for: indexPath)
        //set the cell to the corresponding note
        let note = NoteController.shared.notes[indexPath.row]
        //have the cell's text be the note Detail
        cell.textLabel?.text = note.detail
        //COME BACK TO MAKE THAT LOOK GOOD IN THE CELL!
        return cell
    }
    

    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            //remove the proper note according to index path of the cell
            let note = NoteController.shared.notes[indexPath.row]
            NoteController.shared.deleteNote(note)
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toDetailVC"{
            let destinationVC = segue.destination as? DetailViewController
            guard let indexPath = tableView.indexPathForSelectedRow else {return}
            let note = NoteController.shared.notes[indexPath.row]
            destinationVC?.note = note
        }
        else{}
    }
    

}
