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

struct MapView: View {
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
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
    }
}

#Preview {
    MapView()
}
