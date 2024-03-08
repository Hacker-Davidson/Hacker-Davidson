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


struct MapView: UIViewControllerRepresentable {

    func updateUIViewController(_ uiViewController: MapViewController, context: Context) {
    }

    func makeUIViewController(context: Context) -> MapViewController {
        let vm = MapViewController()
        return vm
    }

}
class MapViewController: UIViewController {
    @ObservedObject var Logics = Logic()
    var locationManager = CLLocationManager()
    var mainMapView: MKMapView?

    override func viewDidLoad() {
        super.viewDidLoad()
        Logics.startCreatePin()
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
    }
}
extension MapViewController: CLLocationManagerDelegate {

    private func setupMapView() {
        let topPadding: CGFloat = 0
        let bottomPadding: CGFloat = -50
        let leftPadding: CGFloat = 0
        let rightPadding: CGFloat = 0
        
        let mapView = MKMapView()
        mapView.delegate = self
        self.mainMapView = mapView
        
        let screenWidth = view.frame.size.width
        let screenHeight = view.frame.size.height
        
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
        self.view.addSubview(mapView)
        mapView.mapType = .hybrid
        mapView.userTrackingMode = .follow
        mapView.userTrackingMode = .followWithHeading
        DispatchQueue.main.async {
            self.Logics.startCreatePin()
        }
        DispatchQueue.main.async {
            self.Logics.createAnnotations(convertedCSVtoSacredPlaces: self.Logics.convertedCSVtoSacredPlaces)
        }
        DispatchQueue.main.async {
            for annotation in self.Logics.annotations {
                mapView.addAnnotation(annotation)
            }
        }
    }
        func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
            switch status {
            case .authorizedWhenInUse:
                // 位置情報の更新を開始
                self.locationManager.startUpdatingLocation()
                setupMapView()
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
    }
extension MapViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        // タップされたアノテーションの情報を取得する
        if let annotation = view.annotation {
            // アノテーションから情報を取得する処理
            Logics.animeTitle = annotation.title as? String ?? ""
            Logics.animeSubTitle = annotation.subtitle as? String ?? ""
        }
    }


}

#Preview {
    MapView()
}
