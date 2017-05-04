//
//  NSData+Int8.swift
//  UniversalRemote
//
//  Created by Brian Crosser on 4/17/17.
//  Copyright © 2017 CCB. All rights reserved.
//

import Foundation

extension Data {
    static func dataWithValue(value: UInt32) -> Data {
        var variableValue = value
        return Data(buffer: UnsafeBufferPointer(start: &variableValue, count: 1))
    }
    
    func uInt32Value() -> UInt32 {
        return UInt32(bitPattern: Int32(self[0]))
        //return UInt32(bitPattern: Int32(self[0]))
    }

}
