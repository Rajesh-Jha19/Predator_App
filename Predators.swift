//
//  Predators.swift
//  JPApexPredator17
//
//  Created by Rajesh Kumar on 31/07/24.
//

import Foundation


class Predators {
    var allApexPredators: [ApexPredator] = []
    var apexPredators: [ApexPredator] = []
    
    init() {
        decodeApexPredatorData()  // init hook k jesa kam krta      h,,khud function call hoga
    }
    
    func decodeApexPredatorData() {
        if let url = Bundle.main.url(forResource: "jpapexpredators", withExtension: "json") {
            do {
                let data = try Data(contentsOf: url)
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase // becouse file name in json not match with Models file so need to write
                allApexPredators = try decoder.decode([ApexPredator].self, from: data)
                apexPredators = allApexPredators
            } catch {
                print("Error decoding JSON data: \(error)")
            }
        }
    }
    
    func search(for searchTerm: String) -> [ApexPredator] {
        if searchTerm.isEmpty {
            return apexPredators
        } else {
           return apexPredators.filter { predator in
                  predator.name.localizedCaseInsensitiveContains(searchTerm)
            }
        }
    }
    func sort(by alphabetical: Bool) {
        apexPredators.sort { predator1, predator2 in
            if alphabetical {
                predator1.name < predator2.name
            } else {
                predator1.id < predator2.id
            }
            
        }
    }
    
    func filter(by type: predatorType) {
        if type == .all {
            apexPredators = allApexPredators
        } else {
            
            apexPredators =  allApexPredators.filter { predator in
                predator.type == type
            }
        }
        
    }
}


