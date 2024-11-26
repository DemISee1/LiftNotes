//
//  DateUtils.swift
//  LiftNotes
//
//  Created by Demessie Amede on 2024-10-17.
//

import Foundation
import SwiftUI

struct DateUtils {
    static var farPast: Date {
        Calendar.current.date(byAdding: .year, value: -10, to: .now)!
    }
}
