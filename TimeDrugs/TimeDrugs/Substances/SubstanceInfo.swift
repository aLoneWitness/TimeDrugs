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
    
    @State private var isLoading: Bool
    
    func updateData() {
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
                
                guard var tempCommonNames = substance.commonNames else {
                    print("Commonames not present")
                    self.substance = substance
                    self.combinedNames = ""
                    return
                }
                
                concatString += tempCommonNames[0]!
                tempCommonNames.removeFirst()
                tempCommonNames.forEach{ cn in
                    if cn != nil {
                        concatString += ", " + cn!
                    }
                }
                
                self.substance = substance
                self.combinedNames = concatString
            case .failure(let error):
                print("Failed to fetch weather data: \(error)")
                substance = nil
            }
        }
        
        
    }
    
    init(substanceName: String) {
        self.substanceName = substanceName
        self.isLoading = false;
    }
    
    var body: some View {
        VStack {
            HStack {
                self.combinedNames.map { Text($0) }
                Spacer()
            }
            
            Divider()
            
            EffectTimeline(
                timelineModel: TimelineModel(
                    everythingForEachLine: [
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
                    ],
                    everythingForEachRating: []
                ),
                height: 175
            )
            
            Spacer()
        }
        .padding(16)
        .onAppear{
            self.updateData()
        }
    }
}

struct SubstanceInfo_Previews: PreviewProvider {
    static var previews: some View {
        SubstanceList()
    }
}
