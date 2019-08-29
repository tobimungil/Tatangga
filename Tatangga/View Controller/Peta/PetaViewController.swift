//
//  PetaViewController.swift
//  Tatangga
//
//  Created by Mirza Fachreza 2 on 23/08/19.
//  Copyright © 2019 Mirza Fachreza. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit

class PetaViewController: UIViewController {

    // MARK: - Properties
    
    var locationManager: CLLocationManager!
    var mapView: MKMapView!
    
    let centerMapButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(#imageLiteral(resourceName: "add-button").withRenderingMode(.alwaysOriginal), for: .normal)
        button.addTarget(self, action: #selector(handleCenterLocation), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let addAnnotationButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(#imageLiteral(resourceName: "add-button").withRenderingMode(.alwaysOriginal), for: .normal)
        button.addTarget(self, action: #selector(handleAnnotationButton), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let centerPinButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(#imageLiteral(resourceName: "blue").withRenderingMode(.alwaysOriginal), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    // MARK: - Init
    
    var initLocations = [
        ["title": "New York, NY", "subtitle": "infrastruktur", "latitude": 40.713054, "longitude": -74.007228],
        ["title": "Los Angeles, CA", "subtitle": "keamanan",  "latitude": 34.052238, "longitude": -118.243344],
        ["title": "Chicago, IL", "subtitle": "keamanan",      "latitude": 41.883229, "longitude": -87.632398],
        ["title": "Somewhere", "subtitle": "keamanan",  "latitude": 6.1754, "longitude": 106.8272]
        
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureLocationManager()
        configureMapView()
        enableLocationServices()
        createInitAnnotation(locations: initLocations)
    }
    
    func createAnnotation() {
        let annotation = MKPointAnnotation()
        annotation.title = "ketertiban"
        annotation.subtitle = "ketertiban"
        annotation.coordinate = CLLocationCoordinate2D(latitude: mapView.centerCoordinate.latitude, longitude: mapView.centerCoordinate.longitude)
        initLocations.append(["title": annotation.title!, "subtitle": annotation.subtitle!, "latitude": annotation.coordinate.latitude, "longitude": annotation.coordinate.longitude])
        mapView.addAnnotation(annotation)
    }
    
    func createAnnotation(annotationName: String) {
        let annotation = MKPointAnnotation()
        annotation.title = "personal"
        annotation.subtitle = "personal"
        annotation.coordinate = CLLocationCoordinate2D(latitude: mapView.centerCoordinate.latitude, longitude: mapView.centerCoordinate.longitude)
        initLocations.append(["title": annotation.title!, "subtitle": annotation.subtitle!, "latitude": annotation.coordinate.latitude, "longitude": annotation.coordinate.longitude])
        mapView.addAnnotation(annotation)
        //        dump(initLocations)
    }
    
    func createInitAnnotation(locations: [[String: Any]]) {
        for location in locations {
            let annotation = MKPointAnnotation()
            annotation.title = location["title"] as? String
            annotation.subtitle = location["subtitle"] as? String
            annotation.coordinate = CLLocationCoordinate2D(latitude: location["latitude"] as! Double, longitude: location["longitude"] as! Double)
            mapView.addAnnotation(annotation)
        }
    }
    
    
    // MARK: - Selectors
    
    @objc func handleCenterLocation() {
        centerMapOnUserLocation()
        createAnnotation()
        //        centerMapButton.alpha = 0
        centerPinButton.alpha = 0
    }
    
    @objc func handleAnnotationButton() {
        createAnnotation(annotationName: "profile")
        centerMapOnUserLocation()
        //        centerMapButton.alpha = 0
        centerPinButton.alpha = 0
    }
    
    // MARK: - Helper Functions
    
    func configureLocationManager() {
        locationManager = CLLocationManager()
        locationManager.delegate = self
    }
    
    func configureMapView() {
        mapView = MKMapView()
        mapView.showsUserLocation = true
        mapView.delegate = self
        mapView.userTrackingMode = .follow
        
        view.addSubview(mapView)
        mapView.frame = view.frame
        
        view.addSubview(centerMapButton)
        centerMapButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -100).isActive = true
        centerMapButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20).isActive = true
        centerMapButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        centerMapButton.widthAnchor.constraint(equalToConstant: 50).isActive = true
        centerMapButton.layer.cornerRadius = 50 / 2
        centerMapButton.alpha = 0
        
        view.addSubview(addAnnotationButton)
        addAnnotationButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -150).isActive = true
        addAnnotationButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20).isActive = true
        addAnnotationButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        addAnnotationButton.widthAnchor.constraint(equalToConstant: 50).isActive = true
        addAnnotationButton.alpha = 1
        
        view.addSubview(centerPinButton)
        centerPinButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        centerPinButton.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        centerPinButton.alpha = 0
        centerPinButton.isHidden = true
    }
    
    func centerMapOnUserLocation() {
        guard let coordinate = locationManager.location?.coordinate else { return }
        let region = MKCoordinateRegion(center: coordinate, latitudinalMeters: 500, longitudinalMeters: 500)
        mapView.setRegion(region, animated: true)
    }

}

// MARK: - MKMapViewDelegate

extension PetaViewController: MKMapViewDelegate {
    
    func mapView(_ mapView: MKMapView, regionWillChangeAnimated animated: Bool) {
        UIView.animate(withDuration: 0.5) {
            self.centerMapButton.alpha = 1
            self.centerPinButton.alpha = 1
            self.centerPinButton.isHidden = false
        }
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if annotation is MKUserLocation {
            return nil
        } else {
            let annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: "annotationView") ?? MKAnnotationView()
            annotationView.canShowCallout = true
            if var annotationCategory = annotation.subtitle {
                annotationCategory?.append(contentsOf: "Buble")
                annotationView.image = UIImage(named: annotationCategory ?? "")
            }
            return annotationView
        }
    }
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView)
    {
        //Segue
        //        if let annotationTitle = view.annotation?.title
        //        {
        //            print("User tapped on annotation with title: \(annotationTitle!)")
        //            var temp:String = ""
        //            temp.append(annotationTitle!)
        //            temp.append("Segue")
        //            performSegue(withIdentifier: temp, sender: self)
        //        }
    }
    
}

// MARK: - CLLocationManagerDelegate

extension PetaViewController: CLLocationManagerDelegate {
    
    func enableLocationServices() {
        switch CLLocationManager.authorizationStatus() {
        case .notDetermined:
            print("Location auth status is NOT DETERMINED")
            locationManager.requestWhenInUseAuthorization()
        case .restricted:
            print("Location auth status is RESTRICTED")
        case .denied:
            print("Location auth status is DENIED")
        case .authorizedAlways:
            print("Location auth status is AUTHORIZED ALWAYS")
        case .authorizedWhenInUse:
            print("Location auth status is AUTHORIZED WHEN IN USE")
            locationManager.startUpdatingLocation()
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        guard locationManager.location != nil else { return }
        centerMapOnUserLocation()
    }
}
