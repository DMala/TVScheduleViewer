//
//  TVListingTableViewCell.swift
//  TVScheduleViewer
//
//  Created by Wendy-Anne Malaguti on 12/12/17.
//  Copyright © 2017 Watch City Software. All rights reserved.
//

import UIKit

class TVListingTableViewCell: UITableViewCell {

    // MARK: - Properties
    @IBOutlet weak var airTime: UILabel!
    @IBOutlet weak var network: UILabel!
    @IBOutlet weak var showName: UILabel!
    @IBOutlet weak var summary: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
