//
//  ViewController.swift
//  Scouting Merger 2015
//
//  Created by Stephen Brimhall on 3/30/15.
//  Copyright (c) 2015 Stephen Brimhall. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {

	override func viewDidLoad() {
		super.viewDidLoad()
		Globals.incrementFiles.connect(incrementFiles);
		Globals.incrementMatches.connect(incrementMatches);
		// Do any additional setup after loading the view.
	}

	override var representedObject: AnyObject? {
		didSet {
		// Update the view, if already loaded.
		}
	}
	@IBOutlet weak var fileCount: NSTextFieldCell!
	@IBOutlet weak var matchCount: NSTextFieldCell!
	
	func incrementMatches() {
		matchCount.integerValue++;
	}
	
	func incrementFiles() {
		fileCount.integerValue++;
	}
    
    @IBAction func compileData(sender: AnyObject) {
        for team in Match.getTeams(Globals.matches) {
            Globals.teams.append(Team(team, matches: Globals.matches));
        }
    }
}

