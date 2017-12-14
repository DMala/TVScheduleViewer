//
//  TVListingDetailViewController.swift
//  TVScheduleViewer
//
//  Created by David Malaguti on 12/12/17.
//  Copyright © 2017 Watch City Software. All rights reserved.
//

import UIKit

class TVListingDetailViewController: UIViewController {
    // MARK: - Properties
    @IBOutlet weak var airtime: UILabel!
    @IBOutlet weak var network: UILabel!
    @IBOutlet weak var showName: UILabel!
    @IBOutlet weak var episodeName: UILabel!
    @IBOutlet weak var summary: UILabel!
    @IBOutlet weak var episodeInfo: UILabel!
    @IBOutlet weak var runtime: UILabel!
    
    var listing: TVShow?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let listing = listing {
            airtime.text = listing.airtime
            network.text = listing.network
            showName.text = listing.showName
            episodeName.text = listing.episodeName
            summary.text = listing.episodeSummary
            
            let info = "S: " + String(listing.season) + " Ep: " + String(listing.episodeNum)
            episodeInfo.text = info
            
            let time = String(listing.runtime) + " mins"
            runtime.text = time
        }
        
        summary.lineBreakMode = .byWordWrapping
        summary.numberOfLines = 0
    }

    override func viewDidLayoutSubviews() {
        // Size the summary label so the text appears at the top left
        summary.sizeToFit()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

