//
//  Album.swift
//  musicPlayer
//
//  Created by AbdulKadir Akkaş on 8.03.2021.
//

import Foundation
struct Album {
    var name : String
    var image : String
    var songs : [Song]
}

//Müzikleri Adlandırmak İçin
extension Album {
    static func get() -> [Album] {
        return [
            Album(name: "acoustic", image: "acoustic", songs: [
                Song(name: "Müzik 1", image: "acoustic", artist: "Kadir", fileName: "bensound-highoctane"),
                Song(name: "Müzik 2", image: "acoustic", artist: "Kadir", fileName: "bensound-memories"),
                Song(name: "Müzik 3", image: "acoustic", artist: "Kadir", fileName: "bensound-moose"),
                Song(name: "Müzik 4", image: "acoustic", artist: "Kadir", fileName: "bensound-punky"),
                Song(name: "Müzik 5", image: "acoustic", artist: "Kadir", fileName: "bensound-romantic"),
                Song(name: "Müzik 6", image: "acoustic", artist: "Kadir", fileName: "bensound-ukulele")
            ]),
            
            Album(name: "jazz", image: "jazz", songs: [
                Song(name: "Müzik 1", image: "jazz", artist: "Kadir", fileName: "bensound-acousticbreeze"),
                Song(name: "Müzik 2", image: "jazz", artist: "Kadir", fileName: "bensound-actionable"),
                Song(name: "Müzik 3", image: "jazz", artist: "Kadir", fileName: "bensound-betterdays")
            ]),
            
            Album(name: "cinematic", image: "cinematic", songs: [
                Song(name: "Müzik 1", image: "acoustic", artist: "Kadir", fileName: "bensound-beyondtheline"),
                Song(name: "Müzik 2", image: "cinematic", artist: "Kadir", fileName: "bensound-buddy"),
                Song(name: "Müzik 3", image: "cinematic", artist: "Kadir", fileName: "bensound-dreams"),
                Song(name: "Müzik 4", image: "cinematic", artist: "Kadir", fileName: "bensound-dubstep"),
                Song(name: "Müzik 5", image: "cinematic", artist: "Kadir", fileName: "bensound-goinghigher"),
                Song(name: "Müzik 6", image: "cinematic", artist: "Kadir", fileName: "bensound-hey")
            ])
        ]
    }
}
