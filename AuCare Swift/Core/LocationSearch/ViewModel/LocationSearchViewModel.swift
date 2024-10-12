//
//  LocationSearchViewModel.swift
//  AuCare Swift
//
//  Created by Zitao Guan on 9/9/23.
//

import Foundation
import MapKit

class LocationSearchViewModel: NSObject, ObservableObject {
    
    // Mark: - Properties
    
    @Published var results = [MKLocalSearchCompletion]()
    @Published var selectedLocationCoordinate: CLLocationCoordinate2D?
    
    private let searchCompleter = MKLocalSearchCompleter()
    var queryFragment: String = "" {
        didSet{
            searchCompleter.queryFragment = queryFragment
        }
    }

    override init() {
        super.init()
        searchCompleter.delegate = self
        searchCompleter.queryFragment = queryFragment
    }
    
    // Mark: - Helpers
    
    func selectLocation(_ localSearch: MKLocalSearchCompletion){
        locationSearch(forLocalSearchCompletion: localSearch) { response, error in
            guard let item = response?.mapItems.first else {return}
            let coordinate = item.placemark.coordinate
            self.selectedLocationCoordinate = coordinate
        }
        
    }
    
    func locationSearch(forLocalSearchCompletion localSerch: MKLocalSearchCompletion, completion: @escaping MKLocalSearch.CompletionHandler){
        let searchRequest = MKLocalSearch.Request()
        searchRequest.naturalLanguageQuery = localSerch.title.appending(localSerch.subtitle)
        let search = MKLocalSearch(request: searchRequest)
        
        search.start(completionHandler: completion)
    }
    
    
}

    //Mark: - MKLocalSearchCompleterDelegate

extension LocationSearchViewModel: MKLocalSearchCompleterDelegate {
    func completerDidUpdateResults(_ completer: MKLocalSearchCompleter) {
        self.results = completer.results
    }
}
