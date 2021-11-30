//
//  Album.swift
//  IOSspotifyAne
//
//  Created by Ane Capdevila on 17/11/2021.
//

import Foundation

struct Album: Hashable {
    var id : Int64 = 0
    var name: String = ""
    var image: String = ""
    var songs : [Song] = []
    
}
