//
//  Match.swift
//  Scouting 1510 Recycle Rush 2k15
//
//  Created by Stephen Brimhall on 3/27/15.
//  Copyright (c) 2015 Stephen Brimhall. All rights reserved.
//

import Foundation

class Match : Comparable {
	
	var matchInfo = [String:String]();
	
	init (_ team : String) {
		self.matchInfo["Team"] = team;
	}
	
	init? (fromString str: String) {
		let characterSet = NSCharacterSet(charactersInString: ",");
		var strs = str.componentsSeparatedByCharactersInSet(characterSet);
		if strs.count != 12 {
			return nil;
		}
		for var i = 0; i < 12; i++ {
			self.matchInfo[Match.csvArray()[i]] = strs[i];
		}
	}
	
	func getInfo (entry: String) -> String! {
		let header = Match.csvArray();
		for var i = 0; i < header.count; i++ {
			if entry == header[i] {
				return self.matchInfo[entry];
			}
		}
		return nil;
	}
	
	class func getTeams(matches: [Match]) -> [String] {
		var result = [String]();
		var currentTeam = "0";
		for match in matches {
			if match.getInfo("Team") != currentTeam {
				result.append(match.getInfo("Team"));
				currentTeam = match.getInfo("Team");
			}
		}
		return result;
	}
	
	class func csvHeader() -> String {
		return "Team,End in Autonomous,Yellow Auto Totes,Auto Bins,Stacks in Teleop,Average Teleop stack size,Totes stacked in Teleop,Bins placed in Teleop,Highest stack height,Litter scored,Uses feeder station,Uses landfill";
	}
	
	class func csvArray() -> [String] {
		return csvHeader().componentsSeparatedByString(",");
	}
	
}

func < (left: Match, right: Match) -> Bool {
	return left.getInfo("Team") < right.getInfo("Team");
}

func == (left: Match, right: Match) -> Bool {
	return left.getInfo("Team") == right.getInfo("Team");
}