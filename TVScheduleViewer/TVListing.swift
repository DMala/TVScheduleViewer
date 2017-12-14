//
//  TVListing.swift
//  TVScheduleViewer
//
//  Created by David Malaguti on 12/14/17.
//  Copyright © 2017 Watch City Software. All rights reserved.
//

import Foundation

class TVListing {
    // MARK: Properties
    var tvListings = [TVShow]()
    var date = Date()
    weak var delegate: TVListingDelegate?
    
    func getShow(index: Int) -> TVShow? {
        if index < tvListings.count {
            return tvListings[index]
        }
        
        return nil
    }
    
    func requestTVListings() {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        
        let str = "http://api.tvmaze.com/schedule?country=US&date=" + formatter.string(from: date)
        let urlString = URL(string: str)
        
        if let url = urlString {
            let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    print(error!)
                } else {
                    if let usableData = data {
                        DispatchQueue.main.async {
                            self.updateListings(data: usableData)
                        }
                    }
                }
            }
            task.resume()
        }
    }
    
    private func updateListings (data: Data)
    {
        let json = try! JSONSerialization.jsonObject(with: data, options: []) as? [[String: Any]]
        
        if let parseJSON = json {
            // Clear the existing list of shows
            tvListings.removeAll()
            
            // Walk through the JSON, adding all of the shows
            for episodeData in parseJSON {
                if let listing = TVShow( json: episodeData ) {
                    tvListings.append(listing)
                } else {
                    print("Failed to add \(episodeData)")
                }
            }
            
            // Notify the delegate
            delegate?.didReceiveListingUpdate()
        }
    }
}

protocol TVListingDelegate: class {
    func didReceiveListingUpdate()
}
