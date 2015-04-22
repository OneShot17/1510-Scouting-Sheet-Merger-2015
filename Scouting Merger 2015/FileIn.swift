//
//  FileIn.swift
//  FileIO
//
//  Created by Stephen Brimhall on 3/9/15.
//  Copyright (c) 2015 Brimhall Labs. All rights reserved.
//

import Foundation

public class FileIn {
	private var data : NSData;
	private let file : NSFileHandle;
	private var fileAsString = [String]();
	private var line = 0;
	
	public init(filename : String) {
		let manager = NSFileManager();
		if let test = NSFileHandle(forReadingAtPath: filename) {
			file = test;
		} else {
			manager.createFileAtPath(filename, contents: nil, attributes: nil);
			file = NSFileHandle(forReadingAtPath: filename)!;
		}
		data = file.readDataToEndOfFile();
		if let bigString : String = NSString(data: data, encoding: NSUTF8StringEncoding)! as? String {
			fileAsString.append("");
			for character in bigString {
				if (character == "\n") {
					fileAsString.append("");
					line++;
				} else {
					fileAsString[line] += String(character);
				}
			}
			line = 0;
		}
	}
	
	public func refresh() {
		let templine = line;
		file.seekToFileOffset(0);
		line = 0;
		data = file.readDataToEndOfFile();
		if let bigString : String = NSString(data: data, encoding: NSUTF8StringEncoding)! as? String {
			fileAsString.append("");
			for character in bigString {
				if (character == "\n") {
					fileAsString.append("");
					line++;
				} else {
					fileAsString[line] += String(character);
				}
			}
			line = templine;
		}
	}
	
	public func nextLine() -> String {
		if line + 1 < fileAsString.count {
			let result = fileAsString[line];
			line++;
			return result;
		}
		return "";
	}
	
	public func isGood() -> Bool {
		return line + 1 < fileAsString.count
	}
	
}