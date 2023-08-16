//
//  TripStore.swift
//  TimeDrugs
//
//  Created by Sabrina van Dinteren on 31/07/2023.
//

import Foundation

class RecordingStore: ObservableObject {
    @Published var recordings: [Recording] = []
    
    private static func fileURL() throws -> URL {
        try FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
        .appendingPathComponent("recordings.data")
    }
    
    func load() async throws {
        let task = Task<[Recording], Error> {
            let fileURL = try Self.fileURL()
            guard let data = try? Data(contentsOf: fileURL) else {
                return []
            }
            guard let recordings = try? JSONDecoder().decode([Recording].self, from: data) else {
                return []
            }
            return recordings
        }
        let recordings = try await task.value
        self.recordings = recordings
    }
    
    func save(recordings: [Recording]) async throws {
        let task = Task {
            let data = try JSONEncoder().encode(recordings)
            let outfile = try Self.fileURL()
            try data.write(to: outfile)
        }
        _ = try await task.value
    }
}
