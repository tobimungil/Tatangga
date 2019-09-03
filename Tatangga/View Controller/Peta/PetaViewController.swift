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
import CloudKit

class PetaViewController: UIViewController {

    // MARK: - Properties
    
    var locationManager: CLLocationManager!
    var mapView: MKMapView!
    //    let islogin: Bool = UserDefaults.standard.bool(forKey: "isLogin")
    let islogin = true
    
    var userData: CKRecord!
    var userPostData = [CKRecord]()
    var postRecordData = [CKRecord]()
    let recordName = UserDefaults.standard.string(forKey: "recordNameUser")
    var key: String?
    
//    let centerMapButton: UIButton = {
//        let button = UIButton(type: .system)
//        button.setImage(#imageLiteral(resourceName: "add-button").withRenderingMode(.alwaysOriginal), for: .normal)
//        button.addTarget(self, action: #selector(handleCenterLocation), for: .touchUpInside)
//        button.translatesAutoresizingMaskIntoConstraints = false
//        return button
//    }()
    
//    let addAnnotationButton: UIButton = {
//        let button = UIButton(type: .system)
//        button.setImage(#imageLiteral(resourceName: "add-button").withRenderingMode(.alwaysOriginal), for: .normal)
//        button.addTarget(self, action: #selector(handleAnnotationButton), for: .touchUpInside)
//        button.translatesAutoresizingMaskIntoConstraints = false
//        return button
//    }()
    
//    let centerPinButton: UIButton = {
//        let button = UIButton(type: .system)
//        button.setImage(#imageLiteral(resourceName: "blue").withRenderingMode(.alwaysOriginal), for: .normal)
//        button.translatesAutoresizingMaskIntoConstraints = false
//        return button
//    }()
    // MARK: - Init
    
//    var initLocations = [
////        ["title": "New York, NY", "subtitle": "infrastruktur", "latitude": 40.713054, "longitude": -74.007228],
////        ["title": "Los Angeles, CA", "subtitle": "keamanan",  "latitude": 34.052238, "longitude": -118.243344],
////        ["title": "Chicago, IL", "subtitle": "keamanan",      "latitude": 41.883229, "longitude": -87.632398],
////        ["title": "Somewhere", "subtitle": "keamanan",  "latitude": 6.1754, "longitude": 106.8272]
//    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getData()
        configureLocationManager()
        configureMapView()
        enableLocationServices()
//        createInitAnnotation(locations: initLocations)
    }
    
    func getData() {
        if islogin {
            // GET POST DATA
            let predicate = NSPredicate(value: true)
            let queryPost = CKQuery(recordType: RemoteRecords.post, predicate: predicate)
            if islogin {
                CKContainer.init(identifier: "iCloud.com.team8.Tatangga").publicCloudDatabase.perform(queryPost, inZoneWith: nil) {
                    records, error in
                    if error != nil {
                        print(error!.localizedDescription)
                    } else {
                        guard let records = records else { return }
                        for record in records {
                            self.postRecordData.append(record)
//                            print(record)
                            
                            self.getLocationData()
//                            print(record)
//                            DispatchQueue.main.async {
//                            }
//                            let user = record.object(forKey: "User") as! CKRecord.Reference
//                            self.key = user.recordID.recordName
//                            OperationQueue.main.addOperation {
//                                self.getDataUser(self.key!)
//                                print(self.key)
//                            }
                        }
                    }
                }
            }
            
            // CHECK GROUP USER
            
            guard recordName != nil else { return }
            let predicateLogin = NSPredicate(format: "recordID = %@", CKRecord.ID(recordName: recordName!))
            let queryUser = CKQuery(recordType: RemoteRecords.user, predicate: predicateLogin)
            print(islogin)
            if islogin {
                if (recordName != nil) {
                    CKContainer.init(identifier: "iCloud.com.team8.Tatangga").publicCloudDatabase.perform(queryUser, inZoneWith: nil) {
                        record, error in
                        if error != nil {
                            print(error!.localizedDescription)
                        } else {
                            guard let record = record else { return }
                            let data = record[0]
                            self.userData = record[0]
                            let dataGroup = data["Group"]
                            if dataGroup != nil {
                                //                            print(data["Group"])
                            } else {
                                print("Not OK")
                            }
                        }
                    }
                }
            }
        }
    }
    
    func getLocationData() {
        for data in postRecordData {
//            print("Ini index \(index)")
//            print("Ini Count : \(postRecordData.count)")
            let initLocations = [
                ["title": data[RemotePost.titlePost]! as! String, "subtitle": data[RemotePost.category]! as! String, "latitude": data[RemotePost.latitude]! as! Double, "longitude": data[RemotePost.longitude]! as! Double],
            ]
//            print(data[RemotePost.latitude]!)
            createInitAnnotation(locations: initLocations)
        }
    }
    
    func getDataUser(_ recordName: String) {
        let predicateLogin = NSPredicate(format: "recordID = %@", CKRecord.ID(recordName: recordName))
        let queryUser = CKQuery(recordType: RemoteRecords.user, predicate: predicateLogin)
        print(islogin)
        if islogin {
            //            if (recordName != nil) {
            CKContainer.init(identifier: "iCloud.com.team8.Tatangga").publicCloudDatabase.perform(queryUser, inZoneWith: nil) {
                record, error in
                if error != nil {
                    print(error!.localizedDescription)
                } else {
                    guard let record = record else { return }
                    self.userPostData.append(record.first!)
                    DispatchQueue.main.async {
                        // SET TO MAP
                        // For Post use self.postRecordData["key"] = object to String
                        // For UserPost use self.userRecordData
                    }
//                    print(record)
                }
            }
            //            }
        }
    }
    
//    func createAnnotation() {
//        let annotation = MKPointAnnotation()
//        annotation.title = "ketertiban"
//        annotation.subtitle = "ketertiban"
//        annotation.coordinate = CLLocationCoordinate2D(latitude: mapView.centerCoordinate.latitude, longitude: mapView.centerCoordinate.longitude)
////        initLocations.append(["title": annotation.title!, "subtitle": annotation.subtitle!, "latitude": annotation.coordinate.latitude, "longitude": annotation.coordinate.longitude])
//        mapView.addAnnotation(annotation)
//    }
//
//    func createAnnotation(annotationName: String) {
//        let annotation = MKPointAnnotation()
//        annotation.title = "personal"
//        annotation.subtitle = "personal"
//        annotation.coordinate = CLLocationCoordinate2D(latitude: mapView.centerCoordinate.latitude, longitude: mapView.centerCoordinate.longitude)
////        initLocations.append(["title": annotation.title!, "subtitle": annotation.subtitle!, "latitude": annotation.coordinate.latitude, "longitude": annotation.coordinate.longitude])
//        mapView.addAnnotation(annotation)
//        //        dump(initLocations)
//    }
    
    func createInitAnnotation(locations: [[String: Any]]) {
        for location in locations {
            let annotation = MKPointAnnotation()
            annotation.title = location["title"] as? String
            annotation.subtitle = location["subtitle"] as? String
            annotation.coordinate = CLLocationCoordinate2D(latitude: location["latitude"] as! Double, longitude: location["longitude"] as! Double)
//            DispatchQueue.main.async {
//            }
            DispatchQueue.main.async {
                self.mapView.addAnnotation(annotation)
            }
        }
    }
    
    
    // MARK: - Selectors
    
//    @objc func handleCenterLocation() {
//        centerMapOnUserLocation()
////        createAnnotation()
//        //        centerMapButton.alpha = 0
//        centerPinButton.alpha = 0
//    }
    
//    @objc func handleAnnotationButton() {
////        createAnnotation(annotationName: "profile")
//        centerMapOnUserLocation()
//        //        centerMapButton.alpha = 0
//        centerPinButton.alpha = 0
//    }
    
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
        
//        view.addSubview(centerMapButton)
//        centerMapButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -100).isActive = true
//        centerMapButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20).isActive = true
//        centerMapButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
//        centerMapButton.widthAnchor.constraint(equalToConstant: 50).isActive = true
//        centerMapButton.layer.cornerRadius = 50 / 2
//        centerMapButton.alpha = 0
//
//        view.addSubview(addAnnotationButton)
//        addAnnotationButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -150).isActive = true
//        addAnnotationButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20).isActive = true
//        addAnnotationButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
//        addAnnotationButton.widthAnchor.constraint(equalToConstant: 50).isActive = true
//        addAnnotationButton.alpha = 1
//
//        view.addSubview(centerPinButton)
//        centerPinButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
//        centerPinButton.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
//        centerPinButton.alpha = 0
//        centerPinButton.isHidden = true
    }
    
    func centerMapOnUserLocation() {
        guard let coordinate = locationManager.location?.coordinate else { return }
        let region = MKCoordinateRegion(center: coordinate, latitudinalMeters: 500, longitudinalMeters: 500)
        mapView.setRegion(region, animated: true)
    }

}

// MARK: - MKMapViewDelegate

extension PetaViewController: MKMapViewDelegate {
    
//    func mapView(_ mapView: MKMapView, regionWillChangeAnimated animated: Bool) {
//        UIView.animate(withDuration: 0.5) {
//            self.centerMapButton.alpha = 1
//            self.centerPinButton.alpha = 1
//            self.centerPinButton.isHidden = false
//        }
//    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if annotation is MKUserLocation {
            return nil
        } else {
            let annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: "annotationView") ?? MKAnnotationView()
            annotationView.canShowCallout = true
            if var annotationCategory = annotation.subtitle {
                annotationCategory?.append(contentsOf: "Buble")
                annotationView.image = UIImage(named: annotationCategory ?? "Lain-lainBuble")
            }
//            let subtitle = annotation.subtitle!
//            print("Ini Annotation \(annotation.subtitle!)")
//            if let imgTitle = UIImage(named: "\(annotation.subtitle!)Buble") {
//                annotationView.image = imgTitle
//            } else {
//                annotationView.image = UIImage(named: "Lain-lainBuble")
//            }
            return annotationView
        }
    }
    
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView)
    {
        let nav = self.storyboard?.instantiateViewController(withIdentifier: "popupVC") as! PopupViewController
        nav.modalTransitionStyle = .crossDissolve
        nav.modalPresentationStyle = .overCurrentContext
//        for data in postRecordData {
        nav.latitude = view.annotation?.coordinate.latitude
//        }
        
        self.present(nav, animated: true, completion: nil)
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if segue.identifier == "setPhoto" {
//            let formView = nav.topViewController as! SubmitViewController
//            formView.photoPreview = self.image
//            formView.imageEncoded64 = encoded64Photo
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
