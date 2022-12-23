//
//  GridViewModel.swift
//  InfluxTestWork
//
//  Created by santhosh t on 23/12/22.
//

import Foundation

class GridViewModel {
    
    var gridData:GridModel?
    
    let flickrKey = "e620531a70d0bb5f1c5069c4a37ae533"
    let secret = "24baf0407c45f185"
    
    private let sourcesURL = URL(string: "https://api.flickr.com/services/rest/?method=flickr.photos.search&api_key=e620531a70d0bb5f1c5069c4a37ae533&format=json&nojsoncallback=1&safe_search=\(1)&text=india")!
    
    func apiToGetQuestionData(completion : @escaping () -> ()) {
        
        URLSession.shared.dataTask(with: sourcesURL) { [weak self] (data, urlResponse, error) in
            if let data = data {
                
                let jsonDecoder = JSONDecoder()
                
                let empData = try! jsonDecoder.decode(GridModel.self, from: data)
                self?.gridData = empData
                completion()
            }
        }.resume()
    }
}
