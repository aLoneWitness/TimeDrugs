//
//  Network.swift
//  TimeDrugs
//
//  Created by Sabrina van Dinteren on 18/07/2023.
//
import Foundation
import Apollo

class Network {
    static let shared = Network()
    private(set) lazy var apollo = ApolloClient(url: URL(string: "https://api.psychonautwiki.org")!)
}
