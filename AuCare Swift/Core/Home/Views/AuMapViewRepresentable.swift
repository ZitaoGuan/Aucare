//
//  AuMapViewRepresentable.swift
//  AuCare Swift
//
//  Created by Zitao Guan on 8/31/23.
//
import SwiftUI
import Foundation
import MapKit

struct AuMapViewRepresentable: UIViewRepresentable {

    let mapView = MKMapView()
    let locationManager = LocationManager()
    @EnvironmentObject var locationViewModel: LocationSearchViewModel

    typealias UIViewType = MKMapView;

    func makeUIView(context: Context) -> MKMapView {
        mapView.delegate = context.coordinator
        mapView.isRotateEnabled = false
        mapView.showsUserLocation = true
        mapView.userTrackingMode = .follow

        return mapView
    }


    func updateUIView(_ uiView: UIViewType, context: Context){
        if let Coordinate = locationViewModel.selectedLocationCoordinate {
            context.coordinator.addAndSelectAnnotation(withCoordinate: Coordinate)
            context.coordinator.configurePolyline(withDestinationCoordinate: Coordinate)
        }
    }
    
    func makeCoordinator() -> MapCoordinator {
        return MapCoordinator(parent: self)
    }
}

extension AuMapViewRepresentable{
    
    class MapCoordinator: NSObject, MKMapViewDelegate{
        
        //Mark: - Properties
        let parent: AuMapViewRepresentable
        var userLocationCoordinate: CLLocationCoordinate2D?
        
        //Mark: - Lifecycle
        
        init(parent: AuMapViewRepresentable) {
            self.parent = parent
            super.init()
        }
        
        //Mark: - MKMapViewDelegate
        
        func mapView(_ mapView: MKMapView, didUpdate userLocation: MKUserLocation) {
            self.userLocationCoordinate = userLocation.coordinate
            let region = MKCoordinateRegion(
                center: CLLocationCoordinate2D(latitude: userLocation.coordinate.latitude, longitude: userLocation.coordinate.longitude),
                span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05))
            
            parent.mapView.setRegion(region, animated: true)
        }
        
        func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) ->
            MKOverlayRenderer {
            let polyline = MKPolylineRenderer(overlay: overlay)
            polyline.strokeColor = .systemBlue
            polyline.lineWidth = 6
            return polyline
        }
        
        //Mark: - Helper
        
        func addAndSelectAnnotation(withCoordinate coordinate: CLLocationCoordinate2D) {
            parent.mapView.removeAnnotations(parent.mapView.annotations)
            
            let anno = MKPointAnnotation()
            anno.coordinate = coordinate
            parent.mapView.addAnnotation(anno)

            parent.mapView.showAnnotations(parent.mapView.annotations, animated: true)
        }
        
        func configurePolyline(withDestinationCoordinate coordinate: CLLocationCoordinate2D){
            guard let userLocationCoordinate = self.userLocationCoordinate else {return}
            getDestinationRoute(from: userLocationCoordinate,
                                to: coordinate) { route in
                self.parent.mapView.addOverlay(route.polyline)
            }
        }
        
        func getDestinationRoute(from userLocation: CLLocationCoordinate2D, to destination: CLLocationCoordinate2D, completion: @escaping(MKRoute) -> Void){
            let userPlacemark = MKPlacemark(coordinate: userLocation)
            let destPlacemark = MKPlacemark(coordinate: destination)
            let request = MKDirections.Request()
            request.source = MKMapItem(placemark: userPlacemark)
            request.destination = MKMapItem(placemark: destPlacemark)
            let directions = MKDirections(request: request)
            
            directions.calculate { response, error in
                if error != nil {
                    return
                }
                guard let route = response?.routes.first else {return}
                completion(route)
            }
        }
        
    }
    
    
}
