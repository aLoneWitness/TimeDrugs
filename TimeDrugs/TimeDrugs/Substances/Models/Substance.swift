//
//  Substance.swift
//  TimeDrugs
//
//  Created by Sabrina van Dinteren on 18/07/2023.
//

import Foundation

struct Substance: Decodable {
    var name: String
    var url: String
    var commonNames: [String]?
    var `class`: Class?
}

struct Class: Decodable {
    var chemical: [String]?
    var psychoactive: [String]?
}
