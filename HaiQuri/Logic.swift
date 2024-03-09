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
    @Published var convertedCSVtoSacredPlaces: [sacredPlace] = []
    @Published var annotations: [MKPointAnnotation] = []
    @Published var filteredContents: [sacredPlace] = []
    @Published var deleteAnnotations: [MKPointAnnotation] = []

    var csvContents: [String] = []
    // csvからデータを読み込んで配列に追加するメソッド
    func readCSV() {
        guard let path = Bundle.main.path(forResource: "seichi", ofType: "csv") else {
            print("データソースがありませんぴえん")
            return
        }
        do {
            let csvString = try String(contentsOfFile: path, encoding: String.Encoding.utf8)
            csvContents = csvString.components(separatedBy: .newlines)
            print(csvContents)
        } catch {
            print("なにかしらエラー")
        }
    }
    // readCSVをした後文字列の配列だったものをsacredPlace構造体に適応させ、それをconvertedCSVtoSacredPlacesに格納するメソッド
    func convertCSVtoSacredPlace() {
        for index in 0..<csvContents.count {
            if csvContents[index] == "" {
                print("空によりスキップ")
            } else {
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
                convertedCSVtoSacredPlaces.append(sacredPlaceDetail)
            }
        }
    }
    // 検索バーを使ってconvertedCSVtoSacredPlaceをフィルタリングして好きなアニメ
    func serchPlacesUsingAnimeTitle(title: String) {
        annotations.removeAll()
        convertedCSVtoSacredPlaces.removeAll()
        filteredContents.removeAll()

        readCSV()
        convertCSVtoSacredPlace()

        for content in convertedCSVtoSacredPlaces {
            if  content.title == title {
                filteredContents.append(content)
                print("格納なり")
            } else {
                print("タイトルと違うのでスキップ")
            }
        }
        createAnnotations(filterInfo: filteredContents)
    }

    //  SacredPlacesからannotationを作成する
    func createAnnotations(filterInfo: [sacredPlace]) {
        annotations.removeAll()
        for annotationOrigin in filterInfo {
            let annotation = MKPointAnnotation()
            annotation.coordinate = CLLocationCoordinate2D(latitude: annotationOrigin.latitude, longitude: annotationOrigin.longitude)
            annotation.title = annotationOrigin.title
            annotation.subtitle = annotationOrigin.placeName
            annotations.append(annotation)
        }
    }
    func startCreatePin() {
        DispatchQueue.main.async {
            self.readCSV()
        }
        DispatchQueue.main.async {
            self.convertCSVtoSacredPlace()
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

