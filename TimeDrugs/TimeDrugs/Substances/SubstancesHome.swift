//
//  SubstancesHome.swift
//  TimeDrugs
//
//  Created by Sabrina van Dinteren on 17/07/2023.
//

import SwiftUI
import SwiftUICharts
import SlideOverCard
import Combine
import UserNotifications

struct SubstancesHome: View {
    static let everythingForEachLine: [EverythingForOneLine] = [
        // full
        EverythingForOneLine(
            roaDuration: RoaDuration(
                onset: DurationRange(min: 30, max: 60, units: .minutes),
                comeup: DurationRange(min: 30, max: 60, units: .minutes),
                peak: DurationRange(min: 2, max: 3, units: .hours),
                offset: DurationRange(min: 1, max: 2, units: .hours),
                total: nil,
                afterglow: nil
            ),
            onsetDelayInHours: 0,
            startTime: Date(),
            horizontalWeight: 0.5,
            verticalWeight: 0.75,
            color: .blue
        )
    ]
        
    @State var showOverlay = false
    @Binding var recordings: [Recording]
    let saveAction: ()->Void
    
    
    var everythingForEachLines: [EverythingForOneLine] {
        return self.recordings.enumerated().map({ (index, recording) in
                let roa = recording.substance.roas[recording.roaIndex]
                return EverythingForOneLine(
                    roaDuration: RoaDuration(
                        onset: roa.duration.onset,
                        comeup: roa.duration.comeup,
                        peak: roa.duration.peak,
                        offset: roa.duration.offset,
                        total: roa.duration.total,
                        afterglow: roa.duration.afterglow
                    ),
                    onsetDelayInHours: 0,
                    startTime: recording.start,
                    horizontalWeight: 0.5,
                    verticalWeight: 0.75 - ( Double(index) * 0.05),
                    color: recording.color
                )
            }
                
        )
    }
    
    private func startRecording(rec: Recording) {
//        let roaDuration = rec.substance.roas[rec.roaIndex].duration
//
//        var notifications: [String] = []
//
//        
//        if let minOnset = roaDuration.onset?.min {
//            addRoaNotification(interval: roaDuration.onset?., substanceName: rec.substance.name, stage: "Peak")
//        }
//
//        if let minPeak = roaDuration.peak?.min {
//            if (minOns)
//            addRoaNotification(interval: minPeak, substanceName: rec.substance.name, stage: "Peak")
//        }
//
//        if let minComeup = roaDuration. {
//            addRoaNotification(interval: comeup, substanceName: rec.substance.name, stage: "Comeup")
//        }
//
//        if let minComeup = roaDuration.comeup?.min {
//            addRoaNotification(interval: comeup, substanceName: rec.substance.name, stage: "Comeup")
//        }
//
//        if let minComeup = roaDuration.comeup?.min {
//            addRoaNotification(interval: comeup, substanceName: rec.substance.name, stage: "Comeup")
//        }
        
        self.recordings.append(rec)
        self.saveAction()
        
        
        
        self.showOverlay.toggle()
    }
    
    private func addRoaNotification(interval: Double, substanceName: String, stage: String) -> String {
        let uuid = UUID().uuidString
        let content = UNMutableNotificationContent()
        content.title = "Drug Timing"
        content.body = stage + " stage started for " + substanceName + "."
        content.sound = UNNotificationSound.default

        // show this notification five seconds from now
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: interval, repeats: false)

        // choose a random identifier
        let request = UNNotificationRequest(identifier: uuid, content: content, trigger: trigger)

        // add our notification request
        UNUserNotificationCenter.current().add(request)
        
        return uuid
    }
    
//    let saveAction: ()->Void
    //    @StateObject var heartHistoryModel: HeartHistoryModel = HeartHistoryModel()
    
    var body: some View {
        NavigationView {
            VStack{
                HStack() {
                    Text("Dashboard")
                        .font(.largeTitle.bold())
                        .frame(maxWidth: .infinity, alignment: .leading)
                    Button() {
                        showOverlay.toggle()
                    } label: {
                        Image(systemName: "plus.circle")
                            .font(.largeTitle)
                            .foregroundColor(.accentColor)
                        
                    } .foregroundColor(.accentColor)
                }
                
                ZStack {
                    if self.everythingForEachLines.count == 0 {
                        Text("No active substances")
                    }
                    
                    EffectTimeline(
                        timelineModel: TimelineModel(
                            everythingForEachLine: self.everythingForEachLines,
                            everythingForEachRating: []
                        ),
                        height: 175
                        
                    )
                }
                
                
                
                List{
                    if !recordings.isEmpty {
                        Section("Currently active") {
                            ForEach(Array(recordings.enumerated()), id: \.offset) { index, recording in
                                VStack {
                                    HStack {
                                        
                                        RoundedRectangle(cornerRadius: 20)
                                            .fill(recording.color.swiftUIColor)
                                            .frame(idealWidth: 10, maxWidth: 10, minHeight: 40, idealHeight: 40, maxHeight: .infinity, alignment: .leading)
                                        Text(recording.substance.name)
                                            .font(.title)
                                            .fontWeight(.semibold)
                                        Spacer()
                                        Text(recording.start.formatted())
                                            .frame(width: 200, alignment: .leading)
                                            .lineLimit(3)
                                    }
                                }
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .listRowInsets(EdgeInsets(top: 5, leading: 0, bottom: 5, trailing: 0))
                                .swipeActions(allowsFullSwipe: false) {
                                    Button(role: .destructive) {
                                        Task {
                                            self.recordings.remove(at: index)
                                            self.saveAction()
                                        }
                                        
                                    } label: {
                                        Label("Delete", systemImage: "trash.fill")
                                    }
                                }
                            }
                        }
                    }
                    
                }.listStyle(.plain)
                
            }
            .onAppear{
                UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { success, error in
                    if success {
                        print("All set!")
                    } else if let error = error {
                        print(error.localizedDescription)
                    }
                }
            }
            .padding(16)
            .sheet(isPresented: $showOverlay) {
                SubstanceList(isDismissed: $showOverlay) { rec in
                    self.startRecording(rec: rec)
                }
            }

        }
    }
}

struct SubstancesHome_Previews: PreviewProvider {
    @StateObject private static var store = RecordingStore()

    
    static var previews: some View {
        
        
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


