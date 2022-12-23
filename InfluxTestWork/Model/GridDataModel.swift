//
//  GridDataModel.swift
//  InfluxTestWork
//
//  Created by santhosh t on 21/12/22.
//

import Foundation

struct GridSelectionModel : Codable {
    var selactionFlag: Bool?
    var messageBoxFlag:Bool?
    var selactedItemIndex: Int?
    var arrow_index: Int?
}

struct GridModel: Codable {
    var photos:Photos?
    var stat: String?
}

struct Photos: Codable {
    var page, pages, perpage, total: Int
    var photo: [Photo]
}
    
struct Photo: Codable {
    var id, owner, secret, server: String
    var farm: Int
    var title: String
    var ispublic, isfriend, isfamily: Int
}
