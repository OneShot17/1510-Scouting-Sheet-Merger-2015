//
//  Functions.swift
//  FileIO
//
//  Created by Stephen Brimhall on 3/30/15.
//  Copyright (c) 2015 Brimhall Labs. All rights reserved.
//

import Foundation

/// Replace any "~" in path with direct path to user's home folder
func expandPath(str : String) -> String? {
	if str.hasPrefix("~") {
		return str.stringByExpandingTildeInPath;
	}
	return nil;
}