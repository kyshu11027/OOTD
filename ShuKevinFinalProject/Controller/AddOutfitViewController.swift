//
//  AddOutfitViewController.swift
//  ShuKevinFinalProject
//
//  Created by Kevin Shu on 11/25/22.
//

import UIKit
import CoreLocation
import simd

class AddOutfitViewController: UIViewController, CLLocationManagerDelegate{
    
    let locationManager = CLLocationManager()
    
    let API_KEY: String = "e9acedd132c257e6dcc8651a35eacb9d"
    
    var weather: Weather = Weather()
    
    typealias AddCompletionHandler = (Garment?, Garment?, Garment?, Garment?) -> Void
    
    var completionHandler: AddCompletionHandler?
    
    
    //store the selected cells from the table views in these variables and return them in the completionHandler
    var top: Garment?
    
    var bottom: Garment?
    
    var shoe: Garment?
    
    var outerwear: Garment?
    

    
    @IBOutlet var weatherLabel: UILabel!
    
    @IBOutlet weak var topNameLabel: UILabel!
    
    @IBOutlet weak var bottomNameLabel: UILabel!
    
    @IBOutlet weak var shoeNameLabel: UILabel!
    
    @IBOutlet weak var outerwearNameLabel: UILabel!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        //we need to get the weather at the user's location when the view loads
        
        
        locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters// in meters
                  
        // Notify us every 100th meters since last location update
        locationManager.distanceFilter = 100
            
        locationManager.delegate = self

        // Asking for permissions to access location
        locationManager.requestWhenInUseAuthorization()
                
        locationManager.startUpdatingLocation()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //we need to get the weather at the user's location when the view loads
        
        
//        locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters// in meters
//
//        // Notify us every 100th meters since last location update
//        locationManager.distanceFilter = 100
//
//
//        locationManager.distanceFilter = 100
//        locationManager.delegate = self
//
//        // Asking for permissions to access location
//        locationManager.requestWhenInUseAuthorization()
//
//        locationManager.startUpdatingLocation()
        
        
        
        
        
    }
    
    override func viewDidDisappear(_ animated: Bool) {
            super.viewDidDisappear(animated)
            locationManager.stopUpdatingLocation()
        }
    
    @IBAction func cancelDidPressed(_ sender: UIBarButtonItem) {
        
        if let completionHandler = completionHandler {
            completionHandler(nil, nil, nil, nil)
        }
    }
    
    @IBAction func saveDidPressed(_ sender: Any) {
        //send back all of the garments
        if let completionHandler = completionHandler {
            completionHandler(top, bottom, shoe, outerwear)
        }
    }
    //helper method for api call and decoding
    
    func decoder(lat: String, lon: String, OnSuccess: @escaping (Weather) -> Void){
        
        let BASE_URL: String =  "https://api.openweathermap.org/data/2.5/weather?lat=\(lat)&lon=\(lon)&appid=\(API_KEY)"
        
        print("lat: \(lat), lon: \(lon)")
        
        let url = URL(string: BASE_URL)!
        
        let request = URLRequest(url: url)
        
        let task = URLSession.shared.dataTask(with: request) {(data, response, error) in
            
            do{
                let decoder = JSONDecoder()
                self.weather = try decoder.decode(Weather.self, from: data!)
                OnSuccess(self.weather)
            }
            catch{
                
                print(error)
                exit(1)
            }
            
            
            
        }
            

        
        task.resume()
        

        
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
            
        //print("running")
        var weatherC: Double = 0
        if let location = locations.first {
            let lat = "\(location.coordinate.latitude)\u{00B0}"
            let lng = "\(location.coordinate.longitude)\u{00B0}"
            print("The location is \(lat),\(lng)")
            
            let index1 = lat.firstIndex(of: "°") ?? lat.endIndex
            let newLat = String(lat[..<index1])
            // welcome now equals "hello"
            let index2 = lng.firstIndex(of: "°") ?? lng.endIndex
            let newLng = String(lng[..<index2])
            
            decoder(lat: newLat, lon: newLng){weather in
                
               
                if let weatherK = weather.main["temp"]{
                    weatherC = (weatherK - 273) * 1.8 + 32
                }
//                else{
//                    self.weatherLabel.text = "Could not get weather information"
//
//                }
                
                DispatchQueue.main.async{
                    //String(format: "%.2f", value)
                    self.weatherLabel.text = "\(round(weatherC)) °F"
                    
                }
                
                
                
            }
            
            

        }
        //self.weatherLabel.text = "\(round(weatherC)) °F"
        
        
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        
        weatherLabel.text = "Could not get weather information"
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?){
        
        if let addTopVC = segue.destination as? TopsTableViewController{
            
            addTopVC.completionHandler = {(top: Garment?) in
                
                //the completion handler for this view should just send back the garment
                if let top = top{
                    self.top = top
                    self.topNameLabel.text = top.name
                }
                
                self.dismiss(animated: true, completion: nil)
                
            }
            
        }
        
        if let addBottomVC = segue.destination as? BottomsTableViewController{
            
            addBottomVC.completionHandler = {(bottom: Garment?) in
                
                //the completion handler for this view should just send back the garment
                if let bottom = bottom{
                    self.bottom = bottom
                    self.bottomNameLabel.text = bottom.name
                }
                
                self.dismiss(animated: true, completion: nil)
                
            }
            
        }
        
        if let addShoeVC = segue.destination as? ShoesTableViewController{
            
            addShoeVC.completionHandler = {(shoe: Garment?) in
                
                //the completion handler for this view should just send back the garment
                if let shoe = shoe{
                    self.shoe = shoe
                    self.shoeNameLabel.text = shoe.name
                }
                
                self.dismiss(animated: true, completion: nil)
                
            }
            
        }
        
        if let addOuterwearVC = segue.destination as? OuterwearTableViewController{
            
            addOuterwearVC.completionHandler = {(outerwear: Garment?) in
                
                //the completion handler for this view should just send back the garment
                if let outerwear = outerwear{
                    self.outerwear = outerwear
                    self.outerwearNameLabel.text = outerwear.name
                }
                
                self.dismiss(animated: true, completion: nil)
                
            }
            
        }
        
        
        //send back all of the garments
//        if let completionHandler = completionHandler {
//            completionHandler(top, bottom, shoe, outerwear)
//        }
        
    }
    
    
}
