//
//  TVShow.swift
//  TVScheduleViewer
//
//  Created by David Malaguti on 12/12/17.
//  Copyright © 2017 Watch City Software. All rights reserved.
//

import Foundation

class TVShow {
    // MARK: Properties
    var showID: Int
    var episodeID: Int
    var showName: String
    var episodeName: String
    var episodeSummary: String
    var airdate: String
    var airtime: String
    var network: String
    var season: Int
    var episodeNum: Int
    var runtime: Int
    
    // MARK: Initializer
    init?(showID: Int, episodeID: Int, showName: String, episodeName: String, airDate: String,
          airTime: String, season: Int, episodeNum: Int, episodeSummary: String, network:String, runtime: Int) {
        
        // Need a valid showID and espisodeID
        if (showID <= 0 || episodeID <= 0) {
            return nil
        }
        
        // Need valid names, summaries, and airdate/time
        if (showName.isEmpty || episodeName.isEmpty || episodeSummary.isEmpty
            || airDate.isEmpty || airTime.isEmpty || network.isEmpty) {
            
            return nil
        }
        
        self.showID = showID
        self.episodeID = episodeID
        self.showName = showName
        self.episodeName = episodeName
        self.episodeSummary = episodeSummary
        self.airdate = airDate
        self.airtime = airTime
        self.network = network
        self.season = season
        self.episodeNum = episodeNum
        self.runtime = runtime
    }
    
    init?(json: [String: Any]) {
        
        // We need at least an episode ID and name, otherwise fail
        guard let episodeID = json["id"] as? Int,
            let episodeName = json["name"] as? String else {
                return nil
        }
        
        var episodeSummary = json["summary"] as? String
        let airdate = json["airdate"] as? String
        let season = json["season"] as? Int
        let episodeNum = json["number"] as? Int
        let runtime = json["runtime"] as? Int
        
        // We also need a show ID and name
        guard let show = json["show"] as? [String: Any],
            let showID = show["id"] as? Int,
            let showName = show["name"] as? String else {
                return nil
        }
        
        // If we didn't get an episode summary, try to get a show summary
        if episodeSummary == nil {
            episodeSummary = show["summary"] as? String
        }
        
        // Get the network name if we can
        var networkName: String? = nil
        if let network = show["network"] as? [String: Any] {
            networkName = network["name"] as? String
        }
        
        // Convert the airtime to 12 hour time
        var airtime = json["airtime"] as? String
        if (airtime != nil)
        {
            let formatterIn = DateFormatter()
            formatterIn.dateFormat = "HH:mm"
            formatterIn.locale = Locale(identifier: "en_US")
            
            let formatterOut = DateFormatter()
            formatterOut.dateFormat = "hh:mma"
            formatterOut.amSymbol = "a"
            formatterOut.pmSymbol = "p"
            formatterOut.locale = Locale(identifier: "en_US")
            
            if let formattedTime = formatterIn.date(from: airtime!) {
                airtime = formatterOut.string(from: formattedTime)
            }
        }
        
        // For now, just strip HTML out of the summary.  If we couldn't get any
        // summary info, just stick a placeholder in there
        if var cleanSummary = episodeSummary {
            cleanSummary = cleanSummary.replacingOccurrences(of: "<[^>]+>", with: "", options: .regularExpression, range: nil)
            
            self.episodeSummary = cleanSummary
        } else {
            self.episodeSummary = "Not available"
        }
        
        self.showID = showID
        self.episodeID = episodeID
        self.showName = showName
        self.episodeName = episodeName
        self.network = networkName ?? ""
        self.season = season ?? 1
        self.episodeNum = episodeNum ?? 1
        self.airdate = airdate ?? ""
        self.airtime = airtime ?? ""
        self.runtime = runtime ?? 0
    }
}
