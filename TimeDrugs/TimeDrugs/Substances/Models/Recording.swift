//
//  Trip.swift
//  TimeDrugs
//
//  Created by Sabrina van Dinteren on 31/07/2023.
//

import Foundation

struct Recording: Codable {
    var uniqueId: String
    var color: SubstanceColor
    var roaIndex: Int
    var substance: Substance
    var start: Date
    var notificationsIds: [String]
}
