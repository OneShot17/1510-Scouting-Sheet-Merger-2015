//
//  ImplicitCastingOperators.swift
//  1510 Scouting Merger 2015
//
//  Created by Stephen Brimhall on 3/28/15.
//  Copyright (c) 2015 Stephen Brimhall. All rights reserved.
//

import Foundation

func += (inout left: Double, right: Int) {
	left += Double(right);
}

func -= (inout left: Double, right: Int) {
	left -= Double(right);
}

func + (left: Double, right: Int) -> Double {
	return left + Int(right);
}

func + (left: Int, right: Double) -> Double {
	return right + left;
}

func - (left: Double, right: Int) -> Double {
	return left - Double(right);
}

func - (left: Int, right: Double) -> Double {
	return Double(left) - right;
}

func * (left: Double, right: Int) -> Double {
	return left * Double(right);
}

func * (left: Int, right: Double) -> Double {
	return right * left;
}

func / (left: Int, right: Double) -> Double {
	return Double(left) / right;
}

func / (left: Double, right: Int) -> Double {
	return left / Double(right);
}