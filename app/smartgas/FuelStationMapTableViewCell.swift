//
//  FuelStationMapTableViewCell.swift
//  smartgas
//
//  Created by Mateus Silva on 09/01/16.
//  Copyright © 2016 Mateus Silva. All rights reserved.
//

import UIKit
import MapKit

class FuelStationMapTableViewCell: UITableViewCell, MKMapViewDelegate {
    @IBOutlet weak var fuelStationMapView: MKMapView!
    var latitude: Double!
    var longitude: Double!
    var brandName: String!
    var stationName: String!

    override func awakeFromNib() {
        super.awakeFromNib()
        fuelStationMapView.delegate = self
    }
    
    func setMapView() {
        let latDelta:CLLocationDegrees = 0.002
        let lonDelta:CLLocationDegrees = 0.002
        
        let span:MKCoordinateSpan = MKCoordinateSpanMake(latDelta, lonDelta)
        
        print(latitude)
        print(longitude)
        let currentLocation = CLLocationCoordinate2DMake(latitude, longitude)
        let region:MKCoordinateRegion = MKCoordinateRegionMake(currentLocation, span)
        fuelStationMapView.setRegion(region, animated: true)
        
        let annotation = MKPointAnnotation()
        annotation.coordinate = currentLocation
        annotation.title = brandName
        annotation.subtitle = stationName
        
        fuelStationMapView.addAnnotation(annotation)
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
