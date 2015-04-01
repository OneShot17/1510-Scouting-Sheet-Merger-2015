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
/// takes a team number and a SORTED array of matches
/// and finds all matches (if any) relating to that team
class Team {
	let team: String;
	var data = [String,Double]();
	var usesFeeder = false;
	var usesLandfill = false;
	
	init (_ name: String) {
		self.team = name;
	}
	
	convenience init (_ team: String, matches: [Match]) {
		self.init(team);
		
	}
	
	let toCSV = { () -> String in
		var result = "";
		
		// Implement this by April 1
		
		return result;
	}
	
	class func csvHeader() -> String {
		var result = "";
		
		result += "Name,";
		result += "Matches,";
		result += "% Auto-zone ends,"
		result += "Average yellow totes in Auto";
		result += "Average bins in Auto";
		result += "Average Teleop stacks";
		result += "Average totes per stack";
		result += "Average totes in Teleop";
		result += "Average bins scored in Teleop";
		result += "Average noodles scored";
		result += "Uses human feeder";
		result += "Can use landfill";
		
		return result;
	}
}