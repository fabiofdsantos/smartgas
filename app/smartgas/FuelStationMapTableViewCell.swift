//
// This file is part of SmartGas, an iOS app to find the best gas station nearby.
//
// (c) Fábio Santos <ffsantos92@gmail.com>
// (c) Mateus Silva <mateusgsilva_@hotmail.com>
// (c) Fábio Marques <fabio1956.epo@gmail.com>
//
// For the full copyright and license information, please view the LICENSE
// file that was distributed with this source code.
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
