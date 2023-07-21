//
//  Substance.swift
//  TimeDrugs
//
//  Created by Sabrina van Dinteren on 18/07/2023.
//


import Foundation

struct JsonSubstance: Decodable {
    var name: String
    var url: String
    var commonNames: [String]?
    var `class`: JsonSubstanceClass?
}

struct JsonSubstanceClass: Decodable {
    var chemical: [String]?
    var psychoactive: [String]?
}

//struct SubstanceRoa: Decodable {
//    var name: String
//    var dose: SubstanceRoaDose
//    var duration: SubstanceRoaDuration
//    var bioavailability: SubstanceRoaRange
//}
//
//struct SubstanceRoaDose: Decodable {
//    var units: String
//    var threshold: Float
//    var heavy: Float
//    var common: SubstanceRoaRange
//    var light: SubstanceRoaRange
//    var strong: SubstanceRoaRange
//}
//
//struct SubstanceRoaRange: Decodable {
//    var min: Float
//    var max: Float
//}
//
//struct SubstanceRoaDuration: Decodable {
//    var afterglow: DurationRange
//    var comeup: DurationRange
//    var duration: DurationRange
//    var offset: DurationRange
//    var onset: DurationRange
//    var peak: DurationRange
//    var total: DurationRange
//}
//
//struct SubstanceRoaDurationRange {
//    var min: Float
//    var max: Float
//    var units: String
//}
