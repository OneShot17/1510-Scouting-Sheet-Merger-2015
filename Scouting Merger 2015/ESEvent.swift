//
//  Event.swift
//  Events
//
//  Created by Stephen Brimhall on 3/14/15.
//  Copyright (c) 2015 Brimhall Labs. All rights reserved.
//

/**
 * 
 * The base EventSystem (ES) class which all ES classes inherit from.
 * Do not instantiate unless you REALLY know what you're doing.
 * It's kind of useless on its own, so subclass to add functionality.
 * 
 * For an example of what a functional, useful ESObject looks like, see ESTimer.
 */
public class ESEvent {
	/// The array of target functions
	internal var targets : [Void -> Void] = [];
	
	/// Constructor for objects of class Event
	public init () {}
	
	/// Connect a new function to this Event
	///
	/// :param: target The target function to add
	public final func connect(target : Void -> Void) {
		targets.append(target);
	}
	
	/// Fire the event, calling all connected functions
	public final func fire() {
		for target in targets {
			target();
		}
	}
}