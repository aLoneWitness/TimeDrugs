//
//  SubstanceInfo.swift
//  TimeDrugs
//
//  Created by Sabrina van Dinteren on 19/07/2023.
//

import SwiftUI
import Apollo

struct SubstanceInfo: View {
    private let subColor = SubstanceColor.allCases.randomElement()!
    
    @State var substance: Substance
    
    @State private var isLoading: Bool = true
    
    @State private var oneLine: EverythingForOneLine?
    
    @State private var combinedNames: String?
    
    @State private var selectedRoa: Int = 0
    
    @Binding var dismissView: Bool
        
    var startRecording: (Recording) -> Void
    
    func updateData() {
        self.isLoading = true
        
        var concatString = "Also known as "

        var tempCommonNames = self.substance.aliases.prefix(3)
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
            let roa = substance.roas[self.selectedRoa]
            var oneLine = EverythingForOneLine(
                roaDuration: RoaDuration(
                    onset: roa.duration.onset,
                    comeup: roa.duration.comeup,
                    peak: roa.duration.peak,
                    offset: roa.duration.offset,
                    total: roa.duration.total,
                    afterglow: roa.duration.afterglow
                ),
                onsetDelayInHours: 0,
                startTime: Date(),
                horizontalWeight: 0.5,
                verticalWeight: 0.75,
                color: subColor
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
                
                VStack {
                    Picker("Roa", selection: $selectedRoa) {
                        ForEach(Array(self.substance.roas.enumerated()), id: \.offset) { index, element in
                            Text(element.name.capitalized).tag(index)
                        }
                    }
                    .onChange(of: selectedRoa) { _ in
                        updateData()
                    }
                }
                .pickerStyle(.segmented)
                
                
                EffectTimeline(
                    timelineModel: TimelineModel(
                        everythingForEachLine: [
                            oneLine!
                        ],
                        everythingForEachRating: []
                    ),
                    height: 175
                )
                
                Button {
                    print(self.selectedRoa)
                    let rec = Recording(
                        uniqueId: UUID().uuidString,
                        color: self.subColor,
                        roaIndex: self.selectedRoa,
                        substance: self.substance,
                        start: Date(),
                        notificationsIds: []
                    )
                    startRecording(rec)
                } label: {
                    HStack {
                        Image(systemName: "record.circle")
                        Text("Start recording")
                        
                    }
                    
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(.secondary)
                        .foregroundColor(self.subColor.swiftUIColor)
                        .cornerRadius(10)
                    
                }
                
                Divider()

                
                if let summary = self.substance.summary {
                    Text("Summary").font(.title).frame(maxWidth: .infinity, alignment: .leading).bold()
                    Text(summary).frame(maxWidth: .infinity, alignment: .leading)
                }
                
                Spacer()
            }
            .padding(16)
        }
    }
}

struct SubstanceInfo_Previews: PreviewProvider {
    @State private static var isDismissed = false
    
    static var previews: some View {
        SubstanceList(isDismissed: $isDismissed) { sub in
            
        }
    }
}
