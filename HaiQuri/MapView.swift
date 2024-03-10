//
//  MapView.swift
//  HaiQuri
//
//  Created by 澤木柊斗 on 2024/03/08.
//

import SwiftUI
import UIKit
import MapKit
import CoreLocation

struct MapView: UIViewRepresentable {
    @ObservedObject var logics: Logic
    @State  var isShowSheet: Bool = false
    func makeUIView(context: Context) -> MKMapView {
        @State var deleteAnnotations = logics.deleteAnnotations
        let mapView = MKMapView()
        let coordinator = context.coordinator
        let topPadding: CGFloat = 0
        let bottomPadding: CGFloat = -50
        let leftPadding: CGFloat = 0
        let rightPadding: CGFloat = 0
        let screenWidth = mapView.frame.size.width
        let screenHeight = mapView.frame.size.height
        let rect = CGRect(x: leftPadding,
                          y: topPadding,
                          width: screenWidth - leftPadding - rightPadding,
                          height: screenHeight - topPadding - bottomPadding)

        mapView.frame = rect
        var region: MKCoordinateRegion = mapView.region
        region.center = mapView.userLocation.coordinate
        region.span.latitudeDelta = 0.02
        region.span.longitudeDelta = 0.02
        mapView.setRegion(region, animated: true)
        mapView.mapType = .hybrid
        mapView.userTrackingMode = .follow
        mapView.delegate = coordinator
        mapView.userTrackingMode = .followWithHeading


        return mapView
    }
    func updateUIView(_ mapView: MKMapView, context: Context) {
        print(logics.annotations)
        mapView.removeAnnotations(mapView.annotations)
        for annotation in logics.annotations {
            mapView.addAnnotation(annotation)
        }
        mapView.setCenter(logics.coodinater, animated: true)
    }
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
}

class CustomMKMapView: MKMapView, MKMapViewDelegate {
    var logics: Logic

    init(frame: CGRect, logics: Logic) {
        self.logics = logics
        super.init(frame: frame)
        self.delegate = self
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


class Coordinator: NSObject, MKMapViewDelegate, CLLocationManagerDelegate {
    var parent: MapView
    var logics: Logic
    var locationManager = CLLocationManager()

    init(_ parent: MapView) {
        self.parent = parent
        self.logics = parent.logics
        super.init()
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
    }

    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .authorizedWhenInUse:
            // 位置情報の更新を開始
            self.locationManager.startUpdatingLocation()
        case .denied:
            // 位置情報サービスが拒否された場合の処理
            print("Location services denied")
        case .restricted:
            // 位置情報サービスが制限された場合の処理
            print("Location services restricted")
        default:
            break
        }
    }
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        if let annotation = view.annotation as? Logic.customMKAnnotation {
            logics.coodinater = CLLocationCoordinate2D(latitude: annotation.coordinate.latitude, longitude: annotation.coordinate.longitude)
            logics.modalInfo = sacredPlace(
                id: annotation.id,
                title: annotation.title ?? "",
                placeName: annotation.subtitle ?? "",
                adress: annotation.adress,
                latitude: annotation.coordinate.latitude,
                longitude: annotation.coordinate.longitude,
                isFavorite: annotation.isFavorite
            )
            logics.isShowSheet.toggle()
        } else {
            print("取得")
        }
    }
}

