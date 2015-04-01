//
//  Bool.swift
//  1510 Scouting System 2015
//
//  Created by Stephen Brimhall on 3/31/15.
//  Copyright (c) 2015 Stephen Brimhall. All rights reserved.
//

import Foundation

extension Bool {
	func toString() -> String {
		switch self {
		case true:
			return "TRUE";
		case false:
			return "FALSE";
		default:
			return "MIXED";
		}
	}
}