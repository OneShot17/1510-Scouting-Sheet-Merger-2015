//
//  TimerEvent.swift
//  Events
//
//  Created by Stephen Brimhall on 3/15/15.
//  Copyright (c) 2015 Brimhall Labs. All rights reserved.
//

import Foundation

/**
 * A simple timer-based event that fires every time interval passed
 * Cannot be subclassed
 * 
 * :param: seconds The number of seconds the timer should wait between fires
 */
public final class ESTimer : ESEvent {
	/// The timer object that runs the event
	private var timer : NSTimer? = nil;
	/// The delay between firings while the timer is running
	private let delay : Double;
	/// Whether or not the timer is currently running
	private var started = false;
	public init (seconds : Double) {
		delay = seconds;
		super.init();
	}
	
	/// Start the timer
	public func start() {
		if !started {	
			timer = NSTimer(timeInterval: delay, target: self, selector: "fire:", userInfo: nil, repeats: true);
			started = true;
			NSRunLoop.currentRunLoop().addTimer(timer!, forMode: NSDefaultRunLoopMode);
		}
	}
	
	/// Stop the timer
	public func stop() {
		if let timer = self.timer {
			timer.invalidate();
			self.timer = nil;
		}
		started = false;
	}
	
	@objc public final func fire(timer : NSTimer) {
		super.fire();
	}
}