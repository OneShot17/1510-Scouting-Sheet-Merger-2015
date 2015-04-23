//
//  AppDelegate.swift
//  Scouting Merger 2015
//
//  Created by Stephen Brimhall on 3/30/15.
//  Copyright (c) 2015 Stephen Brimhall. All rights reserved.
//

import Cocoa
import AppKit

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {



	func applicationDidFinishLaunching(aNotification: NSNotification) {
        Globals.save.connect(AppDelegate.openTest);
	}

	func applicationWillTerminate(aNotification: NSNotification) {
		// Insert code here to tear down your application
	}
    
    class func openTest () {
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
	
	@IBAction func importFile(sender: AnyObject) {
		let openPanel = NSOpenPanel();
		openPanel.canChooseDirectories = false;
		openPanel.canChooseFiles = true;
		openPanel.allowsMultipleSelection = true;
		openPanel.allowedFileTypes = ["csv","match"];
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
						if let match = Match(fromString: possiblyAMatch) {
							Globals.matches.append(match);
							Globals.incrementMatches.fire();
						}
					}
				}
			}
		}
	}
    
    @IBAction func open(sender: AnyObject) {
        let openPanel = NSOpenPanel();
        openPanel.allowsMultipleSelection = false;
        openPanel.allowedFileTypes = ["csv"];
        openPanel.beginWithCompletionHandler({ (result: Int) -> Void in
            if result == NSFileHandlingPanelOKButton {
                if let url = openPanel.URL, path = url.path {
                    Globals.URL = url;
                }
            }
        })
    }

    @IBAction func save(sender: AnyObject) {
        if let url = Globals.URL {
            let file = FileOut(filename: url.path!, mode: IOFlags.append);
            for team in Globals.teams {
                file.write(team.toCSV());
            }
        } else {
            let savePanel = NSSavePanel();
            savePanel.allowedFileTypes = ["csv"];
            savePanel.beginWithCompletionHandler() { (result: Int) -> Void in
                if result == NSFileHandlingPanelOKButton {
                    NSFileManager.defaultManager().createFileAtPath(savePanel.URL!.path!, contents: nil, attributes: nil);
                    Globals.URL = savePanel.URL!;
                    let file = FileOut(filename: Globals.URL!.path!, mode: IOFlags.append);
                    file.write(Team.csvHeader());
                    for team in Globals.teams {
                        file.write(team.toCSV());
                    }
                }
            }
        }
    }
}

