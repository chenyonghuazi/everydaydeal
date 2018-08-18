//
//  MapViewController.swift
//  EveryDayDeal
//
//  Created by Edwin on 2018/1/6.
//  Copyright © 2018年 Edwin. All rights reserved.
//

import UIKit
import MapKit


class MapViewController: UIViewController,MKMapViewDelegate,CLLocationManagerDelegate {

    @IBOutlet weak var navigationBar: UINavigationBar!
    
    
    @IBOutlet weak var mapView: MKMapView!
    var locationManager = CLLocationManager()
    var receivingBrand:String?
    var redPink = [MKPointAnnotation]()
    var center:CLLocationCoordinate2D?
    var selectedAnnotation:MKPointAnnotation?
    override func viewDidLoad() {
        super.viewDidLoad()

        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        mapView.delegate = self
        mapView.showsUserLocation = true
        mapView.showsTraffic = true
        
        
        navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationBar.shadowImage = UIImage()
        navigationBar.isTranslucent = true
        navigationBar.backgroundColor = UIColor.clear
        
        
        
        // Do any additional setup after loading the view.
    }

    @IBAction func direction(_ sender: UIBarButtonItem) {
        //destination
        let latitude = self.selectedAnnotation?.coordinate.latitude
        let longitude = self.selectedAnnotation?.coordinate.longitude
//        let location = CLLocation(latitude: latitude!, longitude: longitude!)
        let regionDistance:CLLocationDistance = 1000
        
//        let regionDistance2:CLLocationDistance = location.distance(from: locationManager.location!)
        if self.selectedAnnotation != nil{
            let coordinate = CLLocationCoordinate2D(latitude: latitude!, longitude: longitude!)
            let regionSpan = MKCoordinateRegionMakeWithDistance(coordinate, regionDistance, regionDistance)
            let option = [MKLaunchOptionsMapCenterKey:NSValue(mkCoordinate: regionSpan.center),MKLaunchOptionsMapSpanKey:NSValue(mkCoordinateSpan: regionSpan.span)]
            
            let placemark = MKPlacemark(coordinate: coordinate)
            let item = MKMapItem(placemark: placemark)
            item.name = self.selectedAnnotation?.title
            item.openInMaps(launchOptions: option)
        }
        
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locations.last!
        center = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
        let region = MKCoordinateRegion(center: center!, span: MKCoordinateSpan(latitudeDelta: 0.07, longitudeDelta: 0.07))
        mapView.setRegion(region, animated: true)
        mapView.showsUserLocation = true
        manager.stopUpdatingLocation()
    }
    
    @IBAction func cancelControl(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func searchRequest(){
        UIApplication.shared.beginIgnoringInteractionEvents()
        let activityindicator = UIActivityIndicatorView()
        activityindicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.gray
        activityindicator.center = self.view.center
        activityindicator.hidesWhenStopped = true
        activityindicator.startAnimating()
        self.view.addSubview(activityindicator)
        
        let searchRequest = MKLocalSearchRequest()
        searchRequest.naturalLanguageQuery = receivingBrand?.capitalized
        searchRequest.region = self.mapView.region
        let actSearch = MKLocalSearch(request: searchRequest)
        actSearch.start { (response, error) in
            //stop the disenable interacting stuff
            activityindicator.stopAnimating()
            UIApplication.shared.endIgnoringInteractionEvents()
            
            if error != nil{
                self.alertSystem()
                
            }else{
                if response == nil{
                    self.alertSystem()
                    
                }else{
                    let annotations = self.mapView.annotations
                    self.mapView.removeAnnotations(annotations)
                    
                    for item in (response?.mapItems)!{
                        let annotation = MKPointAnnotation()
                        annotation.coordinate = item.placemark.coordinate
                        
                        annotation.title = item.name
//                        annotation.subtitle = item.placemark.subtitle //giving me crash!!!
                        self.mapView.addAnnotation(annotation)
                    }
                    
                    
//                    let latitude = response?.boundingRegion.center.latitude
//                    let longtitude = response?.boundingRegion.center.longitude
//
//                    let annotation = MKPointAnnotation()
//                    annotation.title = self.receivingBrand?.capitalized
//                    let coordinate = CLLocationCoordinate2D(latitude: latitude!, longitude: longtitude!)
//                    annotation.coordinate = coordinate
//                    self.redPink.append(annotation)
//                    self.mapView.addAnnotations(self.redPink)
//
//                    //zoom in
//                    let span = MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
//
//                    self.mapView.setRegion(MKCoordinateRegion(center: coordinate, span: span), animated: true)
                    self.mapView.showsUserLocation = true
                }
            }
        }
    }
    

    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        self.selectedAnnotation = view.annotation as? MKPointAnnotation
    }
    
    
    
    func alertSystem(){
        let alert = UIAlertController(title: "Searching crash", message: "something wrong with search request", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }


}
