//
//  SubstanceInfo.swift
//  TimeDrugs
//
//  Created by Sabrina van Dinteren on 19/07/2023.
//

import SwiftUI
import Apollo

struct SubstanceInfo: View {
    private var substanceName: String
    
    @State private var substance: SubstanceSchema.SingleSubstanceQuery.Data.Substance?

    @State private var combinedNames: String?
    
    @State private var isLoading: Bool = true
    
    @State private var oneLine: EverythingForOneLine?
    
    func updateData() {
        self.isLoading = true
        let query = SubstanceSchema.SingleSubstanceQuery(search: self.substanceName ?? .none)
        
        Network.shared.apollo.fetch(query: query) { result in
            print(result)
            switch result {
            case .success(let graphQLResult):
                guard let tempSub = graphQLResult.data?.substances?[0] else {
                    print("Data retrieval failure")
                    substance = nil
                    return
                }
            
                let substance = tempSub
                
                var concatString = "Known as "
                                
                if substance.commonNames != nil {
                    var tempCommonNames = substance.commonNames!
                    
                    concatString += tempCommonNames[0]!
                    tempCommonNames.removeFirst()
                    tempCommonNames.forEach{ cn in
                        if cn != nil {
                            concatString += ", " + cn!
                        }
                    }
                }
                else {
                    concatString = ""
                }
                
                if substance.roas != nil {
                    let roa = substance.roas?[0]
                    var oneLine = EverythingForOneLine(
                        roaDuration: RoaDuration(
                            onset: DurationRange(min: roa?.duration?.onset?.min, max: roa?.duration?.onset?.max, units: DurationRange.Units(rawValue: (roa?.duration?.onset?.units) ?? "minutes") ?? .minutes),
                            comeup: DurationRange(min: roa?.duration?.comeup?.min, max: roa?.duration?.comeup?.max, units: DurationRange.Units(rawValue: (roa?.duration?.comeup?.units) ?? "minutes") ?? .minutes),
                            peak: DurationRange(min: roa?.duration?.peak?.min, max: roa?.duration?.peak?.max, units: DurationRange.Units(rawValue: (roa?.duration?.peak?.units) ?? "minutes") ?? .minutes),
                            offset: DurationRange(min: roa?.duration?.offset?.min, max: roa?.duration?.offset?.max, units: DurationRange.Units(rawValue: (roa?.duration?.offset?.units) ?? "minutes") ?? .minutes),
                            total: DurationRange(min: roa?.duration?.total?.min, max: roa?.duration?.total?.max, units: DurationRange.Units(rawValue: (roa?.duration?.total?.units) ?? "minutes") ?? .minutes),
                            afterglow: DurationRange(min: roa?.duration?.afterglow?.min, max: roa?.duration?.afterglow?.max, units: DurationRange.Units(rawValue: (roa?.duration?.afterglow?.units) ?? "minutes") ?? .minutes)
                        ),
                        onsetDelayInHours: 0,
                        startTime: Date(),
                        horizontalWeight: 0.5,
                        verticalWeight: 0.75,
                        color: .red
                    )
                    
                    self.oneLine = oneLine
                }
                
                self.substance = substance
                self.combinedNames = concatString
                self.isLoading = false
                
                
            case .failure(let error):
                print("Failed to fetch weather data: \(error)")
                substance = nil
            }
        }
        
        
    }
    
    init(substanceName: String) {
        self.substanceName = substanceName
        self.oneLine = nil
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
