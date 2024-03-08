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
    @Published var convertedCSVtoSacredPlace: [sacredPlace] = []
    @Published var annotations: [MKPointAnnotation] = []
    @Published var filteredAnnotations: [MKPointAnnotation] = []
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

extension NumberFormatter {
    static var csvNumberFormatter: NumberFormatter {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        return formatter
    }
}

extension String {
    func doubleValue(with formatter: NumberFormatter = .csvNumberFormatter) -> Double? {
        return formatter.number(from: self)?.doubleValue
    }
}
