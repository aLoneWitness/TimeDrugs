//
//  SubstanceAdd.swift
//  TimeDrugs
//
//  Created by Sabrina van Dinteren on 18/07/2023.
//

import SwiftUI
import Apollo
import Combine

struct SubstanceList: View {
    @State private var searchText: String = ""
    
    @State private var substances: [Substance] = []
        
    @Binding var isDismissed: Bool
    
    var startRecording: (Recording) -> Void

    let searchTextPublisher = PassthroughSubject<String, Never>()
    
    private func updateData(searchString: String?) {
//        Network.shared.apollo.fetch(query: SubstanceSchema.SubstanceListQuery(search: searchString ?? .none)) { result in
//            switch result {
//            case .success(let graphQLResult):
//                self.list = (graphQLResult.data?.substances?.map{ substance -> String in
//                    return (substance?.name)!
//                })!
//            case .failure(let error):
//                print("Failed to fetch weather data: \(error)")
//            }
//        }
    }
    
    private func fillList() {
        let data: Data
        do {
            guard let file = Bundle.main.url(forResource: "output.json", withExtension: nil)
            else {
                fatalError("Cant parse JSON")
            }

            data = try Data(contentsOf: file)

            let decoder = JSONDecoder()
            
            self.substances = try decoder.decode([Substance].self, from: data)
        }
        catch {
            fatalError("Cant parse JSON, \(error)")
        }
        
    }
    
    var searchResults: [Substance] {
        if searchText.isEmpty {
            return substances
        } else {
            return substances.filter {
                
                if($0.name.lowercased().contains(searchText.lowercased())){
                    return true
                }
                else {
                    return $0.aliases.contains(where: { $0.lowercased().contains(searchText.lowercased()) })
                }
            }
        }
    }
    
    var body: some View {

            NavigationStack {
                List(searchResults, id: \.name) { substance in
                    NavigationLink {
                        SubstanceInfo(substance: substance, dismissView: $isDismissed, startRecording: { sub in
                            self.startRecording(sub)
                        })
                            .navigationTitle(substance.name)
                        
                    } label: {
                        Text(substance.name)
                    }
                    
                    
                    //                    VStack{
                    //                        if let cns = substance.commonNames {
                    //                            let cnsf = Array(cns.prefix(1))
                    //                            ForEach(cnsf, id: \.self) { cn in
                    //                                Text(cn)
                    //                                    .font(Font.caption)
                    //                                    .fixedSize(horizontal: true, vertical: true)
                    //                                    .frame(width: .infinity, alignment: .leading)
                    //
//                            }
//                        }
//                    }
                    
                    
                }
                
                .toolbar {
                  ToolbarItem(placement: .primaryAction) {
                      Button("Close") {
                          self.isDismissed.toggle()
                      }
                  }
                }

                .navigationTitle("Substances")
                
            }
            
            .searchable(text: $searchText, prompt: "Find substance")
            .onChange(of: searchText) { value in
                searchTextPublisher.send(value)
            }
            .onReceive(searchTextPublisher.debounce(for: .milliseconds(500), scheduler: DispatchQueue.main)) {
                debounceSearchText in
                self.updateData(searchString: debounceSearchText)
            }
            .onAppear {
                self.fillList()
            }
        }
}

struct SubstancesAdd_Previews: PreviewProvider {
    @State private static var isDismissed = false
    
    static var previews: some View {
        SubstanceList(isDismissed: $isDismissed) { sub in
            
        }
    }
}

