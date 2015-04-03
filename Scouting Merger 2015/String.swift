//
//  String.swift
//  1510 Scouting Merger 2015
//
//  Created by Stephen Brimhall on 3/28/15.
//  Copyright (c) 2015 Stephen Brimhall. All rights reserved.
//

import Foundation

extension String {
	public func toDouble() -> Double? {
        
        if self == "nan" {
            return 0.0/0.0;
        }
        
		let splitted : [String] = self.componentsSeparatedByCharactersInSet(NSCharacterSet(charactersInString: "."));
		var firstPart = 0;
		var secondPart = 0;
		var result = 0.0;
		
		if splitted.count != 2 {
			return nil;
		}
		
		if let val = splitted[0].toInt() {
			firstPart = val;
		}
		if let val = splitted[1].toInt() {
			secondPart = val;
		}
		
		result = Double(firstPart);
		let decimal = secondPart / pow(10.0,Double(splitted[1].length()));
		result += decimal;
		return result;
	}
	
	public func length() -> Int {
		var i = 0;
		for char in self {
			i++;
		}
		return i;
	}
    
    public func toBool() -> Bool? {
        switch self {
            case "TRUE":
                return true;
            case "FALSE":
                return false;
            default:
                return nil;
        }
    }
}