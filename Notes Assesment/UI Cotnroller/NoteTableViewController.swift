//
//  NoteTableViewController.swift
//  Notes Assesment
//
//  Created by Cody on 8/24/18.
//  Copyright © 2018 Cody Adcock. All rights reserved.
//

import UIKit

class NoteTableViewController: UITableViewController, UISearchResultsUpdating {
    
    //SearchBar stuff
    //make instance of Search Controller
    
    let searchController = UISearchController(searchResultsController: nil)

    override func viewDidLoad() {
        super.viewDidLoad()
        //have the serch controller have it's own searchResultsUpdating
        searchController.searchResultsUpdater = self as UISearchResultsUpdating
        //aesthetic stuff
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.dimsBackgroundDuringPresentation = false
        //put a searchbar at the top of the tableView
        tableView.tableHeaderView = searchController.searchBar
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        tableView.reloadData()
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return NoteController.shared.filteredNotes.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //reuse cells
        let cell = tableView.dequeueReusableCell(withIdentifier: "noteCell", for: indexPath)
        //set the cell to the corresponding note
        let note = NoteController.shared.filteredNotes[indexPath.row]
        //have the cell's text be the note Detail
        cell.textLabel?.text = note.detail
        return cell
    }
    

    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            //remove the proper note according to index path of the cell
            NoteController.shared.notes.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }


    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */
    
    //MARK: - SearchBar
    //updateSearchResults Fuction
    func updateSearchResults(for searchController: UISearchController){
        ///it the search bar is not empty, fill a new filteredNotes arrat with array members from notes that match
        if let searchText = searchController.searchBar.text, !searchText.isEmpty{
            NoteController.shared.filteredNotes = NoteController.shared.notes.filter {detail in return detail.detail.lowercased().contains(searchText.lowercased())}
        }else{
            //if it's empty the arrays are the same
            NoteController.shared.filteredNotes = NoteController.shared.notes
        }
        //update the tableView UI as we filter
        tableView.reloadData()
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
//send to karl
