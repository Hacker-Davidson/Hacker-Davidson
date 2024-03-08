//
//  Logic.swift
//  HaiQuri
//
//  Created by 澤木柊斗 on 2024/03/08.
//

import Foundation
import MapKit


struct sacredPlace: Identifiable {
    let id: String
    let title: String
    let placeName: String
    let adress: String
    let latitude: Double
    let longitude: Double
}

class Logic: ObservableObject {
    @Published var animeTitle: String = ""
    @Published var animeSubTitle: String = ""
    let csvContents: [String] = []
    let 



}
