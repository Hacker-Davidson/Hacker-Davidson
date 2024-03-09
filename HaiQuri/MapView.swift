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
        self.view.addSubview(mapView)
        mapView.mapType = .hybrid
        mapView.userTrackingMode = .follow
        mapView.userTrackingMode = .followWithHeading
        }
    }

        }
    }
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        if let annotation = view.annotation {
        }
    }
}

