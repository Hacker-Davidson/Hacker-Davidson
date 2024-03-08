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
            print("なにかしらエラー")
        }
    }
    func convertCSVtoSacredPlace() {
        for index in 0..<csvContents.count {
            let csvContentConponent: [String] = csvContents[index].components(separatedBy: ",")
            let id = csvContentConponent[0]
            let title = csvContentConponent[1]
            let placeName = csvContentConponent[3]
            let adress = csvContentConponent[4]
            let latitude = csvContentConponent[6].doubleValue() ?? 0.00
            let longitude = csvContentConponent[7].doubleValue() ?? 0.00
            let sacredPlaceDetail = sacredPlace(
                id: id,
                title: title,
                placeName: placeName,
                adress: adress,
                latitude: latitude,
                longitude: longitude
            )
            convertedCSVtoSacredPlace.append(sacredPlaceDetail)
        }
    }
        func serchForAnimeTitle(title: String) {
            let filteredConvertedCSVSacredPlace: [sacredPlace] = convertedCSVtoSacredPlace.filter({$0.title.contains(title)})
            createAnnotations(convertedCSVtoSacredPlaces: filteredConvertedCSVSacredPlace)
        }
    func createAnnotations(convertedCSVtoSacredPlaces: [sacredPlace]) {
        for annotationOrigin in convertedCSVtoSacredPlaces {
            let annotation = MKPointAnnotation()
            annotation.coordinate = CLLocationCoordinate2D(latitude: annotationOrigin.latitude, longitude: annotationOrigin.longitude)
            annotation.title = annotationOrigin.title
            annotation.subtitle = annotationOrigin.placeName
            annotations.append(annotation)
        }
    }
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
