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

    override func viewDidLoad() {
        super.viewDidLoad()
        
        var coordenate = CLLocationCoordinate2D()
        coordenate.latitude = 39.282526
        coordenate.longitude = -76.580806
        
        var region = MKCoordinateRegionMakeWithDistance(coordenate, 1000, 1000)
        self.mapView.setRegion(region, animated: true)
        
        adicionaPins()
    }

    @IBAction func changeRegion(sender: UISegmentedControl) {
        
        var coordenate = CLLocationCoordinate2D()
        let index = sender.selectedSegmentIndex
        
        if (index == 0) {
            coordenate.latitude = 39.282526
            coordenate.longitude = -76.580806
            
        } else if (index == 1) {
            coordenate.latitude = -22.9088923
            coordenate.longitude = -43.1771377
        } else {
            coordenate.latitude = 48.859083
            coordenate.longitude = 2.294694
        }
        
        let region = MKCoordinateRegionMakeWithDistance(coordenate, 1000, 1000)
        self.mapView.setRegion(region, animated: true)
    }
    
    func adicionaPins() {
        let pinBaltimore = MKPointAnnotation()
        var coord1 = CLLocationCoordinate2D()
        coord1.latitude = 39.282526
        coord1.longitude = -76.580806
        pinBaltimore.coordinate = coord1
        pinBaltimore.title = "Baltimore"
        pinBaltimore.subtitle = "Um, lugar nos EUA"
        
        
        let pinRio = MKPointAnnotation()
        var coord2 = CLLocationCoordinate2D()
        coord2.latitude = -22.9088923
        coord2.longitude = -43.1771377
        pinRio.coordinate = coord2
        pinRio.title = "Rio"
        pinRio.subtitle = "Tem bala perdida."
        
        let pinParis = MKPointAnnotation()
        var coord3 = CLLocationCoordinate2D()
        coord3.latitude = 48.859083
        coord3.longitude = 2.294694
        pinParis.coordinate = coord3
        pinParis.title = "Paris"
        pinParis.subtitle = "Cidade luz."
        
        self.mapView.addAnnotation(pinBaltimore)
        self.mapView.addAnnotation(pinRio)
        self.mapView.addAnnotation(pinParis)
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
        
        let url = NSURL(string: "http://www.infnet.edu.br")
        UIApplication.sharedApplication().openURL(url!)
    }
    
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        
        let request = MKLocalSearchRequest()
        request.region = self.mapView.region
        
        let search = MKLocalSearch(request: request)
        search.startWithCompletionHandler { (response, error) in
            
            if let sucesso = response {
                for item in sucesso.mapItems {
                    print(item.name)
                    
                }
            } else {
                print("Deu erro!")
            }
        }
    }
}

