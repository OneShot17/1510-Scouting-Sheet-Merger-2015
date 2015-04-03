//
//  Team.swift
//  1510 Scouting Merger 2015
//
//  Created by Stephen Brimhall on 3/28/15.
//  Copyright (c) 2015 Stephen Brimhall. All rights reserved.
//

import Foundation

/// Team
///
/// Stores scouting information on
/// a team. Has two initializers.
/// The first takes the team number
/// and creates a new team. The second
/// takes a team number and an array of matches
/// and finds all matches (if any) relating to that team
class Team {
    let team: String;
    var matches = 0;
    var autoZonePct = 0.0;
    var autoToteAvg = 0.0;
    var autoBinAvg = 0.0;
    var teleStackAvg = 0.0;
    var teleTotesPerStackAvg = 0.0;
    var teleTotesAvg = 0.0;
    var teleBinsAvg = 0.0;
    var teleLitterAvg = 0.0;
    var maxBinHeight = 0;
    var usesFeeder = false;
    var usesLandfill = false;
    
    init (_ name: String) {
        self.team = name;
    }
    
    convenience init (_ team: String, matches: [Match]) {
        self.init(team);
        
        var autoZoneEnds = 0;
        var autoTotes = 0.0;
        var autoBins = 0.0;
        var teleStacks = 0.0;
        var teleTotesPerStack = 0.0;
        var teleTotes = 0.0;
        var teleBins = 0.0;
        var teleLitter = 0.0;
        
        for match in matches {
            if match.getInfo("Team") == team {
                self.matches++;
                if match.getInfo("End in Autonomous").toBool()! {
                    autoZoneEnds++;
                }
                autoTotes += match.getInfo("Yellow Auto Totes").toInt()!;
                autoBins += match.getInfo("Auto Bins").toInt()!;
                teleStacks += match.getInfo("Stacks in Teleop").toInt()!;
                teleTotesPerStack += match.getInfo("Average Teleop stack size").toDouble()!;
                teleTotes += match.getInfo("Totes stacked in Teleop").toInt()!;
                teleBins += match.getInfo("Bins placed in Teleop").toInt()!;
                teleLitter += match.getInfo("Litter scored").toInt()!;
                usesFeeder = usesFeeder || match.getInfo("Uses feeder station").toBool()!;
                usesLandfill = usesLandfill || match.getInfo("Uses landfill").toBool()!;
                if match.getInfo("Highest stack height").toInt()! > maxBinHeight {
                    maxBinHeight = match.getInfo("Highest stack height").toInt()!;
                }
            }
            autoZonePct = Double(autoZoneEnds)/Double(self.matches);
            autoToteAvg = autoTotes/self.matches;
            autoBinAvg = autoBins/self.matches;
            teleStackAvg = teleStacks/self.matches;
            teleTotesPerStackAvg = teleTotesPerStack/self.matches;
            teleTotesAvg = teleTotes/self.matches;
            teleBinsAvg = teleBins/self.matches;
            teleLitterAvg = teleLitter/self.matches;
        }
    }
    
    func toCSV () -> String {
        var result = "";
        
        result += "\(team),";
        result += "\(matches),";
        result += "\(autoZonePct),";
        result += "\(autoToteAvg),";
        result += "\(autoBinAvg),";
        result += "\(teleStackAvg),";
        result += "\(teleTotesPerStackAvg),";
        result += "\(teleTotesAvg),";
        result += "\(teleBinsAvg),";
        result += "\(teleLitterAvg),";
        result += "\(maxBinHeight),";
        result += "\(usesFeeder.toString()),";
        result += "\(usesLandfill.toString()),";
        
        return result;
    }
    
    class func csvHeader() -> String {
        var result = "";
        
        result += "Team,";
        result += "Matches,";
        result += "% Auto-zone ends,"
        result += "Average yellow totes in Auto";
        result += "Average bins in Auto";
        result += "Average Teleop stacks";
        result += "Average totes per stack";
        result += "Average totes in Teleop";
        result += "Average bins scored in Teleop";
        result += "Average noodles scored";
        result += "Max bin-stacking height";
        result += "Uses human feeder";
        result += "Can use landfill";
        
        return result;
    }
    
    class func csvArray() -> [String] {
        return csvHeader().componentsSeparatedByString(",");
    }
}