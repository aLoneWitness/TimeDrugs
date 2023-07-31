//
//  TimeDrugsApp.swift
//  TimeDrugs
//
//  Created by Sabrina van Dinteren on 17/07/2023.
//

import SwiftUI

@main
struct TimeDrugsApp: App {
    @StateObject private var store = RecordingStore()
    
    var body: some Scene {
        WindowGroup {
            SubstancesHome(recordings: $store.recordings) {
                Task {
                    do {
                        try await store.save(recordings: store.recordings)
                    } catch {
                        fatalError(error.localizedDescription)
                    }
                }
            }
                .task {
                    do {
                        try await store.load()
                    } catch {
                        fatalError(error.localizedDescription)
                    }
                }
        }
    }
}
