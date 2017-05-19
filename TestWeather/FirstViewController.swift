//
//  FirstViewController.swift
//  TestWeather
//
//  Created by Ospite on 12/05/17.
//  Copyright © 2017 Ospite. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController {
    @IBOutlet weak var tfTemp: UITextField!
    @IBOutlet weak var tfMax: UITextField!
    @IBOutlet weak var tfMin: UITextField!
    @IBOutlet weak var tfName: UITextField!
    @IBOutlet weak var aiIndicator: UIActivityIndicatorView!
    var apiKey:String = "0a572e0065bd59f1b15f7e8ca0f2fdb3"
    var latitude:Int = 35
    var longitude:Int = 139
    var defaults = UserDefaults.standard

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

        defaults.set(latitude, forKey: "Latitude")
        defaults.set(longitude, forKey: "Longitude")

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(_ animated: Bool) {
            loadWeatherData()
    }

    func loadWeatherData()
    {
       
        latitude = defaults.value(forKey: "Latitude") as! Int
        longitude = defaults.value(forKey: "Longitude") as! Int
 
        
        print("\(latitude) , \(longitude)")

        let myURL = URL(string: "http://api.openweathermap.org/data/2.5/weather?lat=\(latitude)&lon=\(longitude)&APPID=\(apiKey)")!
        
        //per customizzare la richiesta
        var myRequest = URLRequest(url: myURL)
        
        myRequest.httpMethod = "POST"

        self.aiIndicator.startAnimating()
        let session = URLSession.shared.dataTask(with: myURL){(data,response,error)in
            
            if let myError = error
            {
                print ("Errore in chiamata WS : \(error?.localizedDescription)")
                self.tfName.text = "No city at these coordinates"
            }
            else
            {
                let myResponse = (response as! HTTPURLResponse)
                
                if myResponse.statusCode == 200
                {
                    var jsonData = self.json_parseData(data!)
                    self.tfName.text = jsonData?.value(forKey: "name")! as! String?
                    var tempData:NSDictionary = jsonData?.value(forKey: "main")! as! NSDictionary
                    //print(jsonData!)
                    //print(tempData.value(forKey: "temp")!)
                    self.tfTemp.text = String(describing: tempData.value(forKey: "temp")!)
                    self.tfMax.text = String(describing: tempData.value(forKey: "temp_max")!)
                    self.tfMin.text = String(describing: tempData.value(forKey: "temp_min")!)
                    
                    
                /*
                if let mainweather = jsonData?.value(forKey:"weather") as? [Any]
                {
                    if let weather =  mainweather[0] as? [String:Any]
                    {
                        self.cityWatcher = currentWeather
                    }
                    if let currentIcon = weather["icon"] as? String
                    {
                        self.iconID = currentIcon
                    }
                    self.lblWeather_Status.text = "Today in \(self.cityName) is \(self.cityWeather)"
                     
                     let urlIcon = URL(string:"http://openweathermap.org/img/w/\(self.iconID).png")
                     let data = try?Data(contentsOf:urlIcon!)
                     self.imgIcon.image = UIImage(data:data!)!
                }*/
 
                }
                else
                {
                    print("Errore in Response: \(myResponse.description)")
                }
                
                self.aiIndicator.stopAnimating()
            }
            print("Chiamata WS") }
        session.resume()
        
        print("Fine Chiamata")
    }
    
    func json_parseData( _ data: Data) -> NSDictionary?
    {
        do
        {
            let json: Any = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.mutableContainers)
            
            return (json as? NSDictionary)
        }
        catch
        {
            print ("Errore: Json data not correct")
            return nil
        }
    }
}

