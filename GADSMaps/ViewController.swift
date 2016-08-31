//
//  ViewController.swift
//  GADSMaps
//
//  Created by Denilson Monteiro on 29/07/16.
//  Copyright © 2016 Infnet. All rights reserved.
//

import UIKit
import MapKit

class ViewController: UIViewController, MKMapViewDelegate, UISearchBarDelegate {
    //Tem que linkar apertando com o direito na mapView historyboard e levando o delegate ate a viewcontroller (botao amarelo)
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var mapView: MKMapView!
    let locationManager = CLLocationManager()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.locationManager.requestWhenInUseAuthorization()
        self.locationManager.startUpdatingLocation()
        self.mapView.showsUserLocation = true
        
        var coordenate = CLLocationCoordinate2D()
        coordenate.latitude = 39.282526
        coordenate.longitude = -76.580806
        
        let region = MKCoordinateRegionMakeWithDistance(coordenate, 1000, 1000)
        self.mapView.setRegion(region, animated: true)
        
        adicionaPins()
    }

//    @IBAction func changeRegion(sender: UISegmentedControl) {
//        
//        var coordenate = CLLocationCoordinate2D()
//        let index = sender.selectedSegmentIndex
//        
//        if (index == 0) {
//            coordenate.latitude = 39.282526
//            coordenate.longitude = -76.580806
//            
//        } else if (index == 1) {
//            coordenate.latitude = -22.9088923
//            coordenate.longitude = -43.1771377
//            
//            meuLocal()
//            
//        } else {
//            coordenate.latitude = 48.859083
//            coordenate.longitude = 2.294694
//        }
//        
//        let region = MKCoordinateRegionMakeWithDistance(coordenate, 1000, 1000)
//        self.mapView.setRegion(region, animated: true)
//    }
    
    func meuLocal() {
        
        let userLocation:MKUserLocation = self.mapView.userLocation
        let coordinate:CLLocationCoordinate2D = userLocation.location!.coordinate
        
        let region:MKCoordinateRegion = MKCoordinateRegionMakeWithDistance(coordinate, 1000, 1000)
        self.mapView.setRegion(region, animated: true)
    }
    
    @IBAction func meuLocal(sender: UIButton) {
        let userLocation:MKUserLocation = self.mapView.userLocation
        let coordinate:CLLocationCoordinate2D = userLocation.location!.coordinate
        
        let region:MKCoordinateRegion = MKCoordinateRegionMakeWithDistance(coordinate, 1000, 1000)
        self.mapView.setRegion(region, animated: true)
    }
    
    @IBAction func vaiParaCentro(sender: UIButton) {
        
        var coordenate = CLLocationCoordinate2D()
        
        coordenate.latitude = -22.900939
        coordenate.longitude = -43.177990
        
        let region = MKCoordinateRegionMakeWithDistance(coordenate, 1000, 1000)
        self.mapView.setRegion(region, animated: true)
        
        adicionaPins()
    }
    
    @IBAction func vaiParaIpanema(sender: UIButton) {
        
        var coordenate = CLLocationCoordinate2D()
        
        coordenate.latitude = -22.986660
        coordenate.longitude = -43.203642
        
        let region = MKCoordinateRegionMakeWithDistance(coordenate, 1000, 1000)
        self.mapView.setRegion(region, animated: true)
        
        adicionaPins()
    }
    
    func adicionaPins() {
        
        let pinCentro = MKPointAnnotation()
        var coord1 = CLLocationCoordinate2D()
        coord1.latitude = -22.900939
        coord1.longitude = -43.177990
        pinCentro.coordinate = coord1
        pinCentro.title = "Centro"
        pinCentro.subtitle = "Cidade do Rio de Janeiro"
        
        
        let pinIpanema = MKPointAnnotation()
        var coord2 = CLLocationCoordinate2D()
        coord2.latitude = -22.986660
        coord2.longitude = -43.203642
        pinIpanema.coordinate = coord2
        pinIpanema.title = "Ipanema"
        pinIpanema.subtitle = "Praia de Ipanema."
        
        self.mapView.addAnnotation(pinCentro)
        self.mapView.addAnnotation(pinIpanema)
    }
    
    @IBAction func estiloDeMapa(sender: UISegmentedControl) {
        
        let index = sender.selectedSegmentIndex
        if (index == 0) {
            
            self.mapView.mapType = .Standard
            
        } else if (index == 1) {
            
            self.mapView.mapType = .Satellite
            
        } else {
            
            self.mapView.mapType = .Hybrid
            
        }
    }
    
    
    func mapView(mapView: MKMapView, viewForAnnotation annotation: MKAnnotation) -> MKAnnotationView? {
        
        if (annotation is MKUserLocation) {
            return nil
        }
        
        let annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: nil)
        annotationView.image = UIImage(named: "icon_pin")
        annotationView.canShowCallout = true
        
        annotationView.rightCalloutAccessoryView = UIButton(type: .DetailDisclosure)
        
        return annotationView
    }
    
    func mapView(mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        print("Tocou no botão!")
        
        let url = NSURL(string: "https://www.google.com.br/maps/place/Rio+de+Janeiro,+RJ/@-22.9103552,-43.7285293,10z/data=!3m1!4b1!4m5!3m4!1s0x9bde559108a05b:0x50dc426c672fd24e!8m2!3d-22.9068467!4d-43.1728965")
        UIApplication.sharedApplication().openURL(url!)
    }
    
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        
        //Faz a busca na área e apresenta no console os resultados
        let request = MKLocalSearchRequest()
        request.naturalLanguageQuery = searchBar.text
        request.region = self.mapView.region
        
        let search = MKLocalSearch(request: request)
        search.startWithCompletionHandler { (response:MKLocalSearchResponse?, error:NSError?) in
            
            if let sucesso = response {
                for item in sucesso.mapItems {
                    print(item.placemark.name)
                    
                    //Faz a marcação dos pins na tela.
                    let pin = MKPointAnnotation()
                    pin.coordinate = item.placemark.coordinate
                    pin.title = item.placemark.name
                    pin.subtitle = item.placemark.title
                    self.mapView.addAnnotation(pin)
                    
                }
            } else {
                print("Deu erro!")
            }
        }
    }
}

