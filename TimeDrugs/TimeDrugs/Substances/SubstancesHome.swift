//
//  SubstancesHome.swift
//  TimeDrugs
//
//  Created by Sabrina van Dinteren on 17/07/2023.
//

import SwiftUI
import SwiftUICharts
import SlideOverCard

struct SubstancesHome: View {
    static var mock: [DataPoint] {
        let onset = Legend(color: .orange, label: "Onset", order: 1)
        let comeup = Legend(color: .yellow, label: "Come up", order: 2)
        let peak = Legend(color: .green, label: "Peak", order: 3)
        let offset = Legend(color: .blue, label: "Offset", order: 4)
        
        
        
        
        
        return [
            .init(value: 32, label: "Now", legend: onset),
            .init(value: 91, label: "in 5 minutes", legend: onset),
            .init(value: 92, label: "3", legend: onset),
            .init(value: 130, label: "4", legend: comeup),
            .init(value: 124, label: "5", legend: comeup),
            .init(value: 135, label: "19:30", legend: comeup),
            .init(value: 133, label: "7", legend: comeup),
            .init(value: 136, label: "8", legend: comeup),
            .init(value: 138, label: "9", legend: peak),
            .init(value: 150, label: "10", legend: peak),
            .init(value: 150, label: "19:45", legend: peak),
            .init(value: 150, label: "12", legend: peak),
            .init(value: 136, label: "13", legend: peak),
            .init(value: 135, label: "14", legend: peak),
            .init(value: 130, label: "15", legend: peak),
            .init(value: 130, label: "20:00", legend: peak),
            .init(value: 130, label: "17", legend: offset),
            .init(value: 101, label: "18", legend: offset),
            .init(value: 50, label: "19", legend: offset),
            .init(value: 30, label: "20", legend: offset),
        ]
    }
    
    
    @State var showOverlay = false
    
    var body: some View {
        NavigationView {
            VStack{
                HStack() {
                    Text("Dashboard")
                        .font(.largeTitle.bold())
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
                
                VStack() {
                    ZStack {
                        
                        VStack() {
                            Text("").font(.title2)
                            
                            let dp = DataPoint(value: SubstancesHome.mock[0].endValue, label: "Come up", legend: Legend(color: .orange, label: "Come up", order: 2))
                            BarChartView(dataPoints: SubstancesHome.mock, limit: dp)
                                .chartStyle(
                                    BarChartStyle(
                                        showAxis: false,
                                        showLabels: true,
                                        labelCount: 5,
                                        showLegends: false
                                    )
                                )
                            
                            
                        }
                        .padding(16).foregroundColor(Color("Primary")).cornerRadius(20)
                        
                        
                        
                    }
                    .frame(height: 150)
                    
                    ZStack {
                        RoundedRectangle(cornerRadius: 15)
                            .foregroundColor(Color("Secondary"))
                        HStack {
                            Text("BPM")
                            Text("BPM")
                        }
                    }.frame(height: 75)
                    
                }
                
                

                
                Divider()
                
                
                
                
                HStack {
                    Text("Active Substances")
                        .font(.title2)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    Button() {
                        showOverlay.toggle()
                    } label: {
                        Image(systemName: "plus")
                            
                    } .foregroundColor(.accentColor)
                }
                
                ScrollView {
                    
                }
                
                Spacer()
            
            }
            .padding(16)
            
            
            
            
            .sheet(isPresented: $showOverlay) {
                HStack() {
                    Button("Dismiss",
                           action: { showOverlay.toggle() }).foregroundColor(Color("Primary")).frame(maxWidth: .infinity, alignment: .trailing)


                }.padding(16)
                
                SubstancesAdd()
            }
            
        }
        
        
        
        
        
    }
    
    
    
    
    
}

struct SubstancesHome_Previews: PreviewProvider {
    static var previews: some View {
        SubstancesHome()
    }
}


