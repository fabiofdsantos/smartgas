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

    override func awakeFromNib() {
        super.awakeFromNib()
        fuelStationMapView.delegate = self
        // Initialization code
        setMapView()
    }
    
    private func setMapView() {
        let latDelta:CLLocationDegrees = 0.002
        let lonDelta:CLLocationDegrees = 0.002
        
        let span:MKCoordinateSpan = MKCoordinateSpanMake(latDelta, lonDelta)
        
        let currentLocation = CLLocationCoordinate2DMake(latitude, longitude)
        let region:MKCoordinateRegion = MKCoordinateRegionMake(currentLocation, span)
        fuelStationMapView.setRegion(region, animated: true)
        
        let annotation = MKPointAnnotation()
        annotation.coordinate = currentLocation
        annotation.title = "Teste"
        annotation.subtitle = "Whe?"
        
        fuelStationMapView.addAnnotation(annotation)
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
