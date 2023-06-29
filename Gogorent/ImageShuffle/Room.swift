//
//  Room.swift
//  Gogorent
//
//  Created by ClydeHsieh on 2023/6/29.
//

import Foundation

struct Room {
    let imageName: String
    let title: String
    let description: String
}

let roomTitles = ["Haven", "Paradise", "Oasis", "Eden", "Sanctuary", "Hills", "Valley", "Gardens", "Retreat", "Isle"]
let roomDescriptions = ["Spacious room with a comfortable sofa and a TV.", "Cozy bedroom with a queen-sized bed.", "Fully equipped kitchen with modern appliances.", "Clean and tidy bathroom with a shower.", "Quiet room with a desk for studying.", "Elegant dining room with a large table."]

extension Room {
    static func createRandomRooms() -> [Room] {
        var rooms = [Room]()
        
        for index in 1...10 {
            let randomTitleIndex = Int.random(in: 0..<roomTitles.count)
            let randomDescriptionIndex = Int.random(in: 0..<roomDescriptions.count)
            
            let room = Room(imageName: "room\(index)", title: roomTitles[randomTitleIndex], description: roomDescriptions[randomDescriptionIndex])
            rooms.append(room)
        }
        
        return rooms
    }
}

