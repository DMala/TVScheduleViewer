//
//  TVListingTableViewController.swift
//  TVScheduleViewer
//
//  Created by David Malaguti on 12/12/17.
//  Copyright © 2017 Watch City Software. All rights reserved.
//

import UIKit

class TVListingTableViewController: UITableViewController, TVListingDelegate {
    
    // MARK: - Properties
    private let tvListing = TVListing()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        
        tvListing.delegate = self
        
        // Init with today's listing
        tvListing.requestTVListings()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tvListing.tvListings.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Table view cells are reused and should be dequeued using a cell identifier.
        let cellIdentifier = "TVListingTableViewCell"
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
            as? TVListingTableViewCell else {
                fatalError("The dequeued cell is not an instance of TVListingTableViewCell")
        }
        
        if let show = tvListing.getShow(index: indexPath.row) {
        
            cell.showName.text = show.showName
            cell.airTime.text = show.airtime
            
            cell.network.text = show.network
            cell.network.lineBreakMode = .byWordWrapping
            cell.network.numberOfLines = 2
            
            cell.summary.text = show.episodeSummary
            cell.summary.lineBreakMode = .byWordWrapping
            cell.summary.numberOfLines = 2
        }
        
        return cell
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

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

    // MARK: - TVListingDelegate methods
    func didReceiveListingUpdate() {
        self.tableView.reloadData()
        
        // Update the title string here with the new date
        let formatter = DateFormatter()
        formatter.dateFormat = "MM/dd/yyyy"
        self.title = "Listings for " + formatter.string(from: tvListing.date)
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        switch(segue.identifier ?? "") {
        case "ShowDetail":
            guard let detailViewController = segue.destination as? TVListingDetailViewController else {
                    fatalError("Unexpected destination: \(segue.destination)")
            }
            
            guard let selectedListingCell = sender as? TVListingTableViewCell else {
                    fatalError("Unexpected sender: \(String(describing: sender))")
            }
            
            guard let indexPath = tableView.indexPath(for: selectedListingCell) else {
                fatalError("The selected listing is not being displayed by the table.")
            }
            
            let selectedListing = tvListing.getShow(index: indexPath.row)
            detailViewController.listing = selectedListing
            
        case "SetDate":
            guard let navController = segue.destination as? UINavigationController,
                let datePickerController = navController.topViewController as? DatePickerViewController
                else {
                    fatalError("Unexpected destination: \(segue.destination)")
            }
            
            datePickerController.date = tvListing.date
            
        default:
            fatalError("Unexpected segue identfier: \(String(describing: segue.identifier))")
        }
    }

    // MARK: Actions
    @IBAction func unwindToTVListings(sender: UIStoryboardSegue) {
        if let sourceViewController = sender.source as? DatePickerViewController {
            
            // Get the date from the date picker and update the TV listings
            tvListing.date = sourceViewController.date
            tvListing.requestTVListings()
        }
    }
}
