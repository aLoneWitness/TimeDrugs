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
    
    static let everythingForEachRating: [EverythingForOneRating] = [
        EverythingForOneRating(
            time: Date().addingTimeInterval(-2*60*60),
            option: .fourPlus
        ),
    ]
    
    
    @State var showOverlay = false
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
                        everythingForEachLine: SubstancesHome.everythingForEachLine,
                        everythingForEachRating: SubstancesHome.everythingForEachRating
                    ),
                    height: 175
                )
                
                //                VStack() {
                //                    ZStack {
                //                        RoundedRectangle(cornerRadius: 15)
                //                            .foregroundColor(Color("Secondary"))
                //                        HStack {
                //                            Text("BPM")
                //                            if let latestHeartData = heartHistoryModel.heartData.first {
                //                                Text(String(latestHeartData.heartRate))
                //                            }
                //                            else {
                //                                Text(String("None"))
                //                            }
                //
                //                        }
                //                    }.frame(height: 75)
                //
                //                }
                
                Divider()
                
                //                HStack {
                //                    Text("Active Substances")
                //                        .font(.title2)
                //                        .frame(maxWidth: .infinity, alignment: .leading)
                //                }
                
                ScrollView {
                    
                }
                
                Spacer()
            }
            .padding(16)
            
            
            
            
            .sheet(isPresented: $showOverlay) {
                //                HStack() {
                //
                //
                //                    Button("Dismiss",
                //                           action: { showOverlay.toggle() }).foregroundColor(Color("Primary")).frame(maxWidth: .infinity, alignment: .trailing)
                //
                //
                //                }.padding(16)
                
                
                SubstanceList()
                
                
            }
            
        }
        .onAppear{
            //            self.heartHistoryModel.requestAuthorization() {_ in
            //                return
            //            }
            //
            //            self.heartHistoryModel.setupQuery()
        }
        
        
        
        
        
    }
    
    
    
    
    
}

struct SubstancesHome_Previews: PreviewProvider {
    static var previews: some View {
        SubstancesHome()
    }
}


