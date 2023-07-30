//
//  SubstanceInfo.swift
//  TimeDrugs
//
//  Created by Sabrina van Dinteren on 19/07/2023.
//

import SwiftUI
import Apollo

struct SubstanceInfo: View {
    @State var substance: Substance
    
    @State private var isLoading: Bool = true
    
    @State private var oneLine: EverythingForOneLine?
    
    @State private var combinedNames: String?
    
    func updateData() {
        self.isLoading = true
        
        var concatString = "Also known as "

        var tempCommonNames = self.substance.aliases
        if(!tempCommonNames.isEmpty) {
            concatString += tempCommonNames[0]
            tempCommonNames.removeFirst()
            tempCommonNames.forEach{ cn in
                if cn != nil {
                    concatString += ", " + cn
                }
            }
        } else {
            concatString = ""
        }
        
        self.combinedNames = concatString
        
        if substance.roas != nil {
            let roa = substance.roas[0]
            var oneLine = EverythingForOneLine(
                roaDuration: RoaDuration(
                    onset: DurationRange(min: roa.duration.onset?.min, max: roa.duration.onset?.max, units: DurationRange.Units(rawValue: (roa.duration.onset?.units) ?? "minutes") ?? .minutes),
                    comeup: DurationRange(min: roa.duration.comeup?.min, max: roa.duration.comeup?.max, units: DurationRange.Units(rawValue: (roa.duration.comeup?.units) ?? "minutes") ?? .minutes),
                    peak: DurationRange(min: roa.duration.peak?.min, max: roa.duration.peak?.max, units: DurationRange.Units(rawValue: (roa.duration.peak?.units) ?? "minutes") ?? .minutes),
                    offset: DurationRange(min: roa.duration.offset?.min, max: roa.duration.offset?.max, units: DurationRange.Units(rawValue: (roa.duration.offset?.units) ?? "minutes") ?? .minutes),
                    total: DurationRange(min: roa.duration.total?.min, max: roa.duration.total?.max, units: DurationRange.Units(rawValue: (roa.duration.total?.units) ?? "minutes") ?? .minutes),
                    afterglow: DurationRange(min: roa.duration.afterglow?.min, max: roa.duration.afterglow?.max, units: DurationRange.Units(rawValue: (roa.duration.afterglow?.units) ?? "minutes") ?? .minutes)
                ),
                onsetDelayInHours: 0,
                startTime: Date(),
                horizontalWeight: 0.5,
                verticalWeight: 0.75,
                color: .red
            )
            
            self.oneLine = oneLine
        }

        
        
        
        
        self.isLoading = false
    }
    
    var body: some View {
        if self.isLoading {
            ProgressView("Retrieving")
                .progressViewStyle(CircularProgressViewStyle())
                .onAppear{
                    self.updateData()
                }
        }
        else {
            VStack {
                HStack {
                    self.combinedNames.map { Text($0) }
                    Spacer()
                }
                
                Divider()
                
                EffectTimeline(
                    timelineModel: TimelineModel(
                        everythingForEachLine: [
                            oneLine!
                        ],
                        everythingForEachRating: []
                    ),
                    height: 175
                )
                
            
                Spacer()
            }
            .padding(16)
        }
        }
        
        
}

struct SubstanceInfo_Previews: PreviewProvider {
    static var previews: some View {
        SubstanceList()
    }
}
