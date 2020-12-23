//
//  DateComponents+Ext.swift
//  yearrace3
//
//  Created by David Ruvinskiy on 12/23/20.
//

import Foundation

extension DateComponents: Comparable {
    public static func < (lhs: DateComponents, rhs: DateComponents) -> Bool {
        return lhs.month! < rhs.month! ||
            (lhs.month == rhs.month && lhs.day! < rhs.day!)
    }
}
