//
//  AppDelegate.swift
//  Scouting Merger 2015
//
//  Created by Stephen Brimhall on 3/30/15.
//  Copyright (c) 2015 Stephen Brimhall. All rights reserved.
//

import Cocoa
import AppKit
import FileIO

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {



	func applicationDidFinishLaunching(aNotification: NSNotification) {
        Globals.testSave.connect(AppDelegate.openTest);
	}

	func applicationWillTerminate(aNotification: NSNotification) {
		// Insert code here to tear down your application
	}
    
    static let openTest = { () -> Void in
        let openPanel = NSOpenPanel();
        openPanel.canChooseDirectories = false;
        openPanel.canChooseFiles = true;
        openPanel.allowsMultipleSelection = true;
        openPanel.allowedFileTypes = ["match"];
        openPanel.treatsFilePackagesAsDirectories = true;
        openPanel.message = "The match files you are looking for are located inside a .pkg file. Double-click\non it and select all the team files you want to import from that package. Then hit ⌘I again to import the next package.";
        openPanel.beginWithCompletionHandler() { (result : Int) -> () in
            if result == NSFileHandlingPanelOKButton {
                for url in openPanel.URLs as! [NSURL] {
                    Globals.incrementFiles.fire();
                    let file = FileIn(filename: url.path!);
                    while file.isGood() {
                        let possiblyAMatch = file.nextLine();
                        if possiblyAMatch == Match.csvHeader() {
                            continue;
                        }
                        Globals.matches.append(Match(possiblyAMatch));
                    }
                }
            }
        }
    }
	
	@IBAction func open(sender: AnyObject) {
		let openPanel = NSOpenPanel();
		openPanel.canChooseDirectories = false;
		openPanel.canChooseFiles = true;
		openPanel.allowsMultipleSelection = true;
		openPanel.allowedFileTypes = ["match"];
		openPanel.treatsFilePackagesAsDirectories = true;
		openPanel.message = "The match files you are looking for are located inside a .pkg file. Double-click\non it and select all the team files you want to import from that package. Then hit ⌘I again to import the next package.";
		openPanel.beginWithCompletionHandler() { (result : Int) -> () in
			if result == NSFileHandlingPanelOKButton {
				for url in openPanel.URLs as! [NSURL] {
					Globals.incrementFiles.fire();
					let file = FileIn(filename: url.path!);
					while file.isGood() {
						let possiblyAMatch = file.nextLine();
						if possiblyAMatch == Match.csvHeader() {
							continue;
						}
						Globals.matches.append(Match(possiblyAMatch));
					}
				}
			}
		}
	}


}

