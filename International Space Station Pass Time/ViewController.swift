//
//  ViewController.swift
//  International Space Station Pass Time
//
//  Created by Yugandhara Lad More on 1/11/18.
//  Copyright © 2018 Yugandhara Lad. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class ViewController: UIViewController, CLLocationManagerDelegate {
    
    let locationManager = CLLocationManager()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        manager.stopUpdatingLocation()
        let locationValue: CLLocationCoordinate2D = manager.location!.coordinate
        print ("locations = \(locationValue.latitude) longitude = \(locationValue.longitude)")
        fetchData(lat: locationValue.latitude, lon: locationValue.longitude)
        
    }

    @IBAction func curentPositionButtonPressed(_ sender: UIButton) {
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        //For use in foreground
        //self.locationManager.requestAlwaysAuthorization()
        //Ask for Authorization from user
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        //locationManager.stopUpdatingLocation()
        
        
        
    }
    
    func fetchData(lat: Double, lon: Double)  {
        // Create a Network Request
        let session = URLSession.shared
        let url = URL(string: "http://api.open-notify.org/iss-pass.json?lat=\(lat)&lon=\(lon)")
        let task = URLSession.shared.dataTask(with: url!) {
            (data, response, error) in
            //if an error occurs, print it and re-enable the UI
            func displayError(_ error: String)  {
                print(error)
                print("URL at time of error: \(String(describing: url))")
                
            
                
            }
            //Guard: was there an error?
            
            guard (error == nil) else {
                displayError("There was an error with your request: \(error!)")
                return
            }
            
            //Guard: Did we get a successful 2XX response?
            guard let statusCode = (response as? HTTPURLResponse)?.statusCode, statusCode >= 200 && statusCode <= 299 else {
                displayError("Your request returned a status code other than 2xx!")
                return
            }
            
            //Guard: Was there any data returned?
            guard data != nil else {
                displayError("No data was returned by the request")
                return
            }
            
            //parse the data
            let parsedResult: [String: AnyObject]
            do{
                parsedResult = try JSONSerialization.jsonObject(with: data!, options: .allowFragments) as! [String: AnyObject]
                print("yugi result = \(parsedResult)")
                
                let resultCount = parsedResult.count
                    print(resultCount)
                
                let allPasses = parsedResult["response"] as! Array<[String:Double]>
                print("yugi allPasses = \(allPasses)")
                
                var PassTimes: Array<PassTime> = []
                //PassTimes = nil
                
                for pass in allPasses{
                    
                    print("Pass  = \(pass)")
                    PassTimes.append(PassTime(PassTimeDict: pass));
                }
                
                let tableViewController:
                    MyTableViewController = UIStoryboard(
                        name: "Main", bundle: nil
                        ).instantiateViewController(withIdentifier: "TableViewController") as! MyTableViewController
                // .instantiatViewControllerWithIdentifier() returns AnyObject!
                // this must be downcast to utilize it
                
                tableViewController.PassTimes = PassTimes
                
                self.present(tableViewController, animated: true, completion: nil)
                
                
               
                
                
                
                
                
                
                
                
                
            } catch {
                displayError("Could not parse the data as JSON: '\(String(describing: data))'")
                return
            }
            
            
        }
        task.resume()
    }
}

