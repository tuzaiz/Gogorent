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

extension Room {
    static func createRandomRooms() -> [Room] {
        let roomTitles = ["高級豪宅三大房含車位管理優質中山北路", "台北車站【五星飯店式】獨棟電梯~獨立套房", "時尚裝潢，屋況佳，近捷運，優質社區", "別墅電梯大套房大陽台有傢俱家電可報稅", "MRT象山信義路松仁2房2衛露台可寵", "💎象山北醫松仁💎全新2房精裝庭院", "🏅MRT南京松江中山善導寺🏅漂亮時尚", "專約忠孝新生站1+1書房.收納空間大", "台北大學旁！捷運中山站", "近台電大樓站電梯正四房溫馨美宅貓可議"]
        let roomDescriptions = ["1.3房2廳2衛2陽台\n2.屋況典雅裝潢優質", "～台北車站特區～五星飯店式管理～享受安靜、安全、乾淨的套房～\n～到台北～住台北車站特區～五鐵捷運便利交通網～", "附近有便利商店、傳統市場、百貨公司、公園綠地、學校、醫療機構、夜市。本房屋近象山捷運站。", "近三總,近公園全新電梯大樓,安靜環境好!全新電梯大樓.全新完工屋況美美,提供傢俱電有大陽台遠眺綠蔭美景無價~~", "專業合法租賃 快速優質篩選 租賃法務諮詢 修繕清潔團隊屋齡新大樓👍 警衛保全👍", "專業合法租賃 快速優質篩選 租賃法務諮詢 修繕清潔團隊屋齡新"]
        
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

