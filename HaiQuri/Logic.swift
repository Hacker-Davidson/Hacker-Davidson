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
    @Published var convertedCSVtoSacredPlace: [sacredPlace] = []
    @Published var annotations: [MKPointAnnotation] = []
    var csvContents: [String] = []

    func readCSV() {
        guard let path = Bundle.main.path(forResource: "seichi", ofType: "csv") else {
            print("データソースがありませんぴえん")
            return
        }
        do {
            let csvString = try String(contentsOfFile: path, encoding: String.Encoding.utf8)
            csvContents = csvString.components(separatedBy: .newlines)
        } catch {
            print("なにかしらのエラー")
        }
    }


}
