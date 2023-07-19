import Foundation
import HealthKit


import Foundation
import HealthKit

struct HeartRateEntry: Hashable, Identifiable {
    var heartRate: Double
    var date: Date
    var id = UUID()
}

class HeartHistoryModel: ObservableObject {
    
    @Published var heartData: [HeartRateEntry] = []
    var healthStore: HKHealthStore
    var queryAnchor: HKQueryAnchor?
    var query: HKAnchoredObjectQuery?
    
    init() {
        if HKHealthStore.isHealthDataAvailable() {
            healthStore = HKHealthStore()
        } else {
            fatalError("Health data not available")
            
        }
        
        self.requestAuthorization { authorised in
            if authorised {
                self.setupQuery()
            }
        }
    }
    
    func requestAuthorization(completion: @escaping (Bool) -> Void){
        let heartBeat = HKQuantityType.quantityType(forIdentifier: HKQuantityTypeIdentifier.heartRate)!
        
        self.healthStore.requestAuthorization(toShare: [], read: [heartBeat]) { (success, error) in completion(success)
        }
        
    }
    
    func setupQuery() {
        guard let sampleType = HKObjectType.quantityType(forIdentifier: .heartRate) else {
            return
        }
        
        let startDate = Calendar.current.date(byAdding: .month, value: -1, to: Date())
        
       let predicate = HKQuery.predicateForSamples(withStart: startDate, end: .distantFuture, options: .strictEndDate)
        
        self.query = HKAnchoredObjectQuery(type: sampleType, predicate: predicate, anchor: queryAnchor, limit: HKObjectQueryNoLimit, resultsHandler: self.updateHandler)
        
        self.query!.updateHandler = self.updateHandler
            
        healthStore.execute(self.query!)
    }
    
    func updateHandler(query: HKAnchoredObjectQuery, newSamples: [HKSample]?, deleteSamples: [HKDeletedObject]?, newAnchor: HKQueryAnchor?, error: Error?) {
        if let error = error {
            print("Health query error \(error)")
        } else {
            let unit = HKUnit(from: "count/min")
            if let newSamples = newSamples as? [HKQuantitySample], !newSamples.isEmpty {
                print("Received \(newSamples.count) new samples")
                DispatchQueue.main.async {
                    
                    var currentData = self.heartData
                    
                    currentData.append(contentsOf: newSamples.map { HeartRateEntry(heartRate: $0.quantity.doubleValue(for: unit), date: $0.startDate)
                    })
                    
                    self.heartData = currentData.sorted(by: { $0.date > $1.date })
                }
            }

            self.queryAnchor = newAnchor
        }
        
        
    }
}

//class HealthKitManager: ObservableObject {
//    private var healthStore = HKHealthStore()
//    let heartRateQuantity = HKUnit(from: "count/min")
//
//    @Published var hr: Int = 0
//
//    func authorizeHealthKit() {
//
//        // Used to define the identifiers that create quantity type objects.
//        let healthKitTypes: Set = [
//            HKObjectType.quantityType(forIdentifier: HKQuantityTypeIdentifier.heartRate)!]
//        // Requests permission to save and read the specified data types.
//        healthStore.requestAuthorization(toShare: healthKitTypes, read: healthKitTypes) { _, _ in }
//    }
//
//
//    func startHeartRateQuery(quantityTypeIdentifier: HKQuantityTypeIdentifier) {
//
//        // We want data points from our current device
//        let devicePredicate = HKQuery.predicateForSamplesWithStartDate(NSDate(), endDate: nil, options: .None)
//
//        // A query that returns changes to the HealthKit store, including a snapshot of new changes and continuous monitoring as a long-running query.
//        let updateHandler: (HKAnchoredObjectQuery, [HKSample]?, [HKDeletedObject]?, HKQueryAnchor?, Error?) -> Void = {
//            query, samples, deletedObjects, queryAnchor, error in
//
//            // A sample that represents a quantity, including the value and the units.
//            guard let samples = samples as? [HKQuantitySample] else {
//                return
//            }
//
//            self.process(samples, type: quantityTypeIdentifier)
//
//        }
//
//        // It provides us with both the ability to receive a snapshot of data, and then on subsequent calls, a snapshot of what has changed.
//        let query = HKAnchoredObjectQuery(type: HKObjectType.quantityType(forIdentifier: quantityTypeIdentifier)!, predicate: devicePredicate, anchor: nil, limit: HKObjectQueryNoLimit, resultsHandler: updateHandler)
//
//        query.updateHandler = updateHandler
//
//        // query execution
//
//        healthStore.execute(query)
//    }
//
//    private func process(_ samples: [HKQuantitySample], type: HKQuantityTypeIdentifier) {
//        var lastHeartRate = 0.0
//
//        for sample in samples {
//
//            if type == .heartRate {
//                lastHeartRate = sample.quantity.doubleValue(for: heartRateQuantity)
//            }
//
//            print(lastHeartRate)
//
//            self.hr = Int(lastHeartRate)
//        }
//    }
//}
