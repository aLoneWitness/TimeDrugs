//
//  SubstanceAdd.swift
//  TimeDrugs
//
//  Created by Sabrina van Dinteren on 18/07/2023.
//

import SwiftUI
import Apollo
import Combine

struct SubstancesAdd: View {
    @State private var searchText: String = ""
    
    @State private var substances: [Substance] = []
    
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
            guard let file = Bundle.main.url(forResource: "substances.json", withExtension: nil)
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
            return substances.filter{
                if($0.class == nil || $0.class?.psychoactive == nil) {
                    return false
                }
                return true
            }
        } else {
            return substances.filter {
                if($0.class == nil || $0.class?.psychoactive == nil) {
                    return false
                }
                
                if($0.name.lowercased().contains(searchText.lowercased())){
                    return true
                }
                else {
                    if $0.commonNames == nil {
                        return false
                    }
                    else {
                        return $0.commonNames!.contains(where: { $0.lowercased().contains(searchText.lowercased()) })
                    }
                    
                }
            }
        }
    }
    
    var body: some View {
        VStack() {
            NavigationStack {
                List(searchResults, id: \.name) { substance in
                    NavigationLink {
                        Text(substance.name)
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
            .padding(-16.0)
            
        
        }
        .padding().foregroundColor(Color("Primary"))
        .onAppear {
            self.fillList()
        }
        
        
        
    }
}

struct SubstancesAdd_Previews: PreviewProvider {
    static var previews: some View {
        SubstancesAdd()
    }
}

