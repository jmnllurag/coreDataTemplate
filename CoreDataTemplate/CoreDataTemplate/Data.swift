//
//  Data.swift
//  CoreDataTemplate
//
//  Created by John marru Llurag on 26/06/2017.
//  Copyright © 2017 John marru Llurag. All rights reserved.
//

import Foundation

struct DataModel : Equatable { //added Equatable protocol to use .index(of: Data)
    
    /// Returns a Boolean value indicating whether two values are equal.
    ///
    /// Equality is the inverse of inequality. For any values `a` and `b`,
    /// `a == b` implies that `a != b` is `false`.
    ///
    /// - Parameters:
    ///   - lhs: A value to compare.
    ///   - rhs: Another value to compare.
    static func ==(lhs: DataModel, rhs: DataModel) -> Bool {
        return lhs.column1 == rhs.column1 && lhs.column2 == rhs.column2 && lhs.column3 == rhs.column3
    }
    var column1: String
    var column2: String
    var column3: String
    
}
