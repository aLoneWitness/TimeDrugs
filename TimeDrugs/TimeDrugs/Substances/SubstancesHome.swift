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
            onsetDelayInHours: 3,
            startTime: Date().addingTimeInterval(-3*60*60),
            horizontalWeight: 0.5,
            verticalWeight: 0.75,
            color: .blue
        )
    ]
        
    @State var showOverlay = false
    @Binding var recordings: [Recording]
    let saveAction: ()->Void

    
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
                
                EffectTimeline(
                    timelineModel: TimelineModel(
                        everythingForEachLine: self.recordings.map({ recording in
                            let roa = recording.substance.roas[0]
                            return
                            EverythingForOneLine(
                                roaDuration: RoaDuration(
                                    onset: DurationRange(min: roa.duration.onset?.min, max: roa.duration.onset?.max, units: DurationRange.Units(rawValue: (roa.duration.onset?.units) ?? "minutes") ?? .minutes),
                                    comeup: DurationRange(min: roa.duration.comeup?.min, max: roa.duration.comeup?.max, units: DurationRange.Units(rawValue: (roa.duration.comeup?.units) ?? "minutes") ?? .minutes),
                                    peak: DurationRange(min: roa.duration.peak?.min, max: roa.duration.peak?.max, units: DurationRange.Units(rawValue: (roa.duration.peak?.units) ?? "minutes") ?? .minutes),
                                    offset: DurationRange(min: roa.duration.offset?.min, max: roa.duration.offset?.max, units: DurationRange.Units(rawValue: (roa.duration.offset?.units) ?? "minutes") ?? .minutes),
                                    total: DurationRange(min: roa.duration.total?.min, max: roa.duration.total?.max, units: DurationRange.Units(rawValue: (roa.duration.total?.units) ?? "minutes") ?? .minutes),
                                    afterglow: DurationRange(min: roa.duration.afterglow?.min, max: roa.duration.afterglow?.max, units: DurationRange.Units(rawValue: (roa.duration.afterglow?.units) ?? "minutes") ?? .minutes)
                                ),
                                onsetDelayInHours: 3,
                                startTime: Date().addingTimeInterval(-3*60*60),
                                horizontalWeight: 0.5,
                                verticalWeight: 0.75,
                                color: recording.color
                            )
                            
                        }),
                        everythingForEachRating: []
                    ),
                    height: 175
                )
                
                
                List{
                    if !recordings.isEmpty {
                        Section("Currently active") {
                            ForEach(recordings, id: \.start) { recording in
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
                                        
                                        
                                    } label: {
                                        Label("Delete", systemImage: "trash.fill")
                                    }
                                }
                            }
                        }
                    }
                    
                }.listStyle(.plain)
                
            }
            .padding(16)
            .sheet(isPresented: $showOverlay) {
                SubstanceList(isDismissed: $showOverlay) { rec in
                    self.recordings.append(rec)
                    self.saveAction()
                    self.showOverlay.toggle()
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


