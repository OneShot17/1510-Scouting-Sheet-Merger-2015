//
//  FileOut.swift
//  FileIO
//
//  Created by Stephen Brimhall on 3/9/15.
//  Copyright (c) 2015 Brimhall Labs. All rights reserved.
//

import Foundation

public class FileOut {
	var file : NSFileHandle;
	
	public init (filename : String, mode : IOFlags) {
		let manager = NSFileManager();
		switch mode {
		case IOFlags.append:
			file = NSFileHandle(forWritingAtPath: filename)!;
			file.seekToEndOfFile();
		case IOFlags.clear:
			manager.createFileAtPath(filename, contents: nil, attributes: nil);
			file = NSFileHandle(forWritingAtPath: filename)!;
		case IOFlags.replace:
			file = NSFileHandle(forWritingAtPath: filename)!;
			file.seekToFileOffset(0);
			
		}
	}
	
	public convenience init (filename : String) {
		self.init(filename: filename, mode: IOFlags.clear);
	}
	
	public func write (string : String) {
		if let data = (string as NSString).dataUsingEncoding(NSUTF8StringEncoding) {
			file.writeData(data);
		}
	}
}