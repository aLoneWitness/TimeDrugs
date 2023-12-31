//
//  Substance.swift
//  TimeDrugs
//
//  Created by Sabrina van Dinteren on 18/07/2023.
//


import Foundation

struct Substance: Codable {
    var url: String
    var experiencesUrl: String?
    var name: String
    var aliases: [String]
    var aliasesStr: String
    var summary: String?
    var reagents: String?
    var classes: Classes?
    var toxicity: [String]?
    var addictionPotential: String?
    var tolerance: Tolerance?
    var crossTolerances: [String]?
    var roas: [Roa]
    var interactions: [Interaction]?
}

struct Classes: Codable {
    var chemical: [String]?
    var psychoactive: [String]?
}

enum Psychoactive: String, Codable {
    case Antidepressants = "Antidepressants"
    case Antipsychotic = "Antipsychotic"
    case Cannabinoid = "Cannabinoid"
    case Deliriant = "Deliriant"
    case Depressant = "Depressant"
    case Dissociatives = "Dissociatives"
    case Entactogens = "Entactogens"
    case Eugeroics = "Eugeroics"
    case Hallucinogens = "Hallucinogens"
    case Nootropic = "Nootropic"
    case Oneirogen = "Oneirogen"
    case Opioids = "Opioids"
    case Psychedelics = "Psychedelics"
    case Sedative = "Sedative"
    case Stimulants = "Stimulants"
}

struct Interaction: Codable {
    var status: String
    var note: String?
}

enum Status: String, Codable {
    case Caution = "Caution"
    case Dangerous = "Dangerous"
    case LowRiskDecrease = "Low Risk & Decrease"
    case LowRiskNoSynergy = "Low Risk & No Synergy"
    case LowRiskSynergy = "Low Risk & Synergy"
    case Unsafe = "Unsafe"
}

struct Roa: Codable {
    var name: String
    var dose: Dosage?
    var duration: Duration
}



struct Duration: Codable {
    var afterglow: DurationRange?
    var comeup: DurationRange?
    var duration: DurationRange?
    var offset: DurationRange?
    var onset: DurationRange?
    var peak: DurationRange?
    var total: DurationRange?
}

//struct DRange: Codable {
//    var min: Double?
//    var max: Double?
//    var units: String
//}

struct Dosage: Codable {
    var units: String?
    var threshold: Float?
    var heavy: Float?
    var common: Range?
    var light: Range?
    var strong: Range?
}

struct Range: Codable {
    var min: Double?
    var max: Double?
}

enum Name: String, Codable {
    case AfterEffects = "After effects"
    case ComeUp = "Come up"
    case Common = "Common"
    case Duration = "Duration"
    case Heavy = "Heavy"
    case Light = "Light"
    case Offset = "Offset"
    case Onset = "Onset"
    case Peak = "Peak"
    case Strong = "Strong"
    case Threshold = "Threshold"
    case Total = "Total"
}

struct Tolerance: Codable {
    var full: String
    var half: String?
    var zero: String?
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
