//
//  SubstanceTimingGraph.swift
//  TimeDrugs
//
//  Created by Sabrina van Dinteren on 18/07/2023.
//

import Foundation
import SwiftUI
import Charts
import TabularData

struct SimpleBabyChart: View {
    let data: [BabyNamesDataPoint]
    
    @State var datesOfMaximumProportion: [
        (date: Date, name: String, yStart: Float, yEnd: Float)
    ] = []
    
    var body: some View {
        Chart {
            ForEach(data) { point in
                AreaMark(
                    x: .value("Date", point.year),
                    y: .value("Count", point.count),
                    stacking: .center
                ).foregroundStyle(by: .value("Name", point.name))
            }
            ForEach(
                datesOfMaximumProportion,
                id: \.name
            ) { point in
                RuleMark(
                    x: .value(
                        "Date of highest popularity for \(point.name)",
                        point.date
                    )
                )
                .foregroundStyle(
                    LinearGradient(
                        gradient: Gradient (
                            colors: [
                                .indigo.opacity(0.05),
                                .purple.opacity(0.5)
                            ]
                        ),
                        startPoint: .top,
                        endPoint: .bottom
                    ).blendMode(.darken)
                )
            }
            
            ForEach(datesOfMaximumProportion, id: \.name) { point in
                RuleMark(
                    x: .value("Date of highest popularity for \(point.name)", point.date),
                    yStart: .value("", point.yStart),
                    yEnd: .value("", point.yEnd)
                )
                .lineStyle(StrokeStyle(lineWidth: 0))
                    
                .annotation(
                    position: .overlay,
                    alignment: .center,
                    spacing: 4
                ){ context in
                    Text(point.name)
                        .font(.subheadline)
                        .padding(2)
                        .fixedSize()
                        .background(
                            RoundedRectangle(cornerRadius: 2)
                                .fill(.ultraThinMaterial)
                        )
                        .rotationEffect(
                            .degrees(-90),
                            anchor: .center
                        )
                        .fixedSize()
                        .foregroundColor(.secondary)
                }
            }
        }
        .chartForegroundStyleScale(
            range: Gradient (
                colors: [
                    .purple,
                    .blue.opacity(0.3)
                ]
            )
        )
        // Run this task again if we change the number of data points
        .task(id: data.count) {

            self.datesOfMaximumProportion = []

            var namesToMaxProportion: [String: (proportion: Float, date: Date)] = [:]
            for point in self.data {
                if namesToMaxProportion[point.name]?.proportion ?? 0 < point.proportion {
                    namesToMaxProportion[point.name] = (point.proportion, point.year)
                }
            }
            
            self.datesOfMaximumProportion = namesToMaxProportion.map { (key: String, value) in
                let name = key
                var countOnDate = 0
                var countBeforeOnDate = 0
                var countAfterOnDate = 0
                
                // Loop over all the data
                for point in self.data {
                    // We only need to consider data points for this year
                    if point.year != value.date { continue }
                    if point.name == name {
                        countOnDate = point.count
                        continue
                    }
                    
                    if countOnDate != 0 {
                        // We are dealing with sections that come after this name
                        countAfterOnDate += point.count
                    } else {
                        // We are dealing with sections that come before this name
                        countBeforeOnDate += point.count
                    }
                }
                
                let totalHeightOnDate = countOnDate + countAfterOnDate + countBeforeOnDate
                // The height is centred about the axis
                let lowestValue = -1 * Float(totalHeightOnDate) / 2.0
                let yStart = lowestValue + Float(countBeforeOnDate)
                let yEnd = yStart  + Float(countOnDate)
                
                return (value.date, key, yStart, yEnd)
            }
        }
    }
}

struct ContentViewer: View {
    @State
    var data: [BabyNamesDataPoint] = []
    
    @State
    var error: Error? = nil
    
    var body: some View {
        VStack {
            if let error = error {
                Text("error: \(error.localizedDescription)")
            } else if data.isEmpty {
                ProgressView().progressViewStyle(.circular)
            } else {
                SimpleBabyChart(data: data)
            }
        }
        .task(priority: .background) {
            do {
                self.data = try await BabyNamesDataPoint.load()
            } catch {
                self.error = error
            }
        }.frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

struct SubstanceTimingGraph_Previews: PreviewProvider {
    
    static var previews: some View {
        return ContentViewer()
    }
}

struct BabyNamesDataPoint {
    static let url = URL(string: "https://raw.githubusercontent.com/holtzy/data_to_viz/master/Example_dataset/5_OneCatSevNumOrdered.csv")!

    enum Sex: String {
        case male = "M"
        case female = "F"
    }
    
    let year: Date
    let sex: Sex
    let name: String
    let count: Int
    let proportion: Float
    
    static func load() async throws -> [Self] {
        let (data, _) = try await URLSession.shared.data(from: Self.url)
        
        var dataFrame = try DataFrame(
            csvData: data,
            columns: [
                "year",
                "sex",
                "name",
                "n",
                "prop"
            ],
            types: [
                "year": CSVType.integer,
                "sex": CSVType.string,
                "name": CSVType.string,
                "n": CSVType.integer,
                "prop": CSVType.float
            ],
            options: CSVReadingOptions(hasHeaderRow: true)
        )
        dataFrame.sort(on: "name")
        return dataFrame.rows.compactMap { row in
            guard
                let _year = row["year", Int.self],
                let year = Calendar.current.date(from: DateComponents(year: _year)),
                let name = row["name", String.self],
                let count = row["n", Int.self],
                let proportion = row["prop", Float.self],
                let sex_string = row["sex", String.self], let sex = Sex(rawValue: sex_string) else {
                return nil
            }

            return Self.init(year: year, sex: sex, name: name, count: count, proportion: proportion)
        }
    }
}

extension BabyNamesDataPoint: Identifiable {
    struct ObjectIdentifier: Hashable {
        let year: Date
        let name: String
    }
    var id: ObjectIdentifier {
        ObjectIdentifier(year: self.year, name: self.name)
    }
}
