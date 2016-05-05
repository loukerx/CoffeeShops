//
//  CoffeeShopsTableViewController.swift
//  CoffeeShops
//
//  Created by Yin Hua on 3/05/2016.
//  Copyright © 2016 Yin Hua. All rights reserved.
//

import UIKit
import Alamofire
import MBProgressHUD
import CoreLocation

class CoffeeShopsTableViewController: UITableViewController {

    // MARK: - Variables
    private let clientID = "ACAO2JPKM1MXHQJCK45IIFKRFR2ZVL0QASMCBCG5NPJQWF2G"
    private let clientSecret = "YZCKUYJ1WHUV2QICBXUBEILZI1DMPUIDP5SHV043O04FKBHL"
    private let version = "20130815"
    private let section = "coffee"
    private let sortByDistance = 1
    private let limit = 50
    private let HUDLoadingMessage = "loading"
    private let cellReuseIdentifier = "Cell"
    
    private var appDelegate = AppDelegate()
    private var HUD_: MBProgressHUD = MBProgressHUD()
    internal var tableData = NSMutableArray()
    private var timer: NSTimer?
    private let updatingTime: NSTimeInterval = 300.0
    
    // MARK: - Views
    override func viewDidLoad() {
        super.viewDidLoad()

        appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        
        //locationManager 开启地理位置
        if CLLocationManager.locationServicesEnabled() {
            //Get User Current Locaiton
            if let location = appDelegate.locationManager.location {
                
                //Loading
                HUD_ = MBProgressHUD.showHUDAddedTo(self.view, animated: true)
                HUD_.mode = MBProgressHUDMode.Indeterminate
                HUD_.labelText = HUDLoadingMessage
                self.view.userInteractionEnabled = false
                
                self.prepareCoffeeShopsInfo(location)
                self.startTimer()
            
            }else{
                
                //alert error
                self.alertMessage("Alert Error:", message:"Please set your location service on")
                
            }
        }else{
            
            //alert error
            self.alertMessage("Alert Error:", message:"Please set your location service on")
            
        }
        
        
        
    }

    //MARK: Prepare Shops Details
    private func prepareCoffeeShopsInfo(location:CLLocation){


        
        let URL = NSURL(string: "https://api.foursquare.com/v2/venues/explore")!
        
        let ll = "\(location.coordinate.latitude),\(location.coordinate.longitude)"
        
        let parameters = [
            "client_id": clientID,
            "client_secret": clientSecret,
            "v" : version,
            "ll": ll,
            "section": section,
            "sortByDistance": sortByDistance,
            "limit": limit
            
        ]
        
        
        Alamofire.request(.GET, URL, parameters: parameters as? [String : AnyObject])
            .responseJSON { response in

                self.view.userInteractionEnabled = true
                MBProgressHUD.hideAllHUDsForView(self.view, animated: true)
                
                

                
                if response.result.isSuccess{
                    if  let JSONDictionary = response.result.value as? Dictionary<String, NSObject>{
                        if let res = JSONDictionary["response"] as? Dictionary<String, NSObject>{
                          
//                            print(res["totalResults"]!)
                            if let groups = res["groups"] as?[Dictionary<String, NSObject>]{

                                if let items = groups[0]["items"] as? [Dictionary<String, NSObject>]{
                                    
                                    self.tableData.removeAllObjects()//clear tableViewData
                                    
                                    for item in items{
                                        self.tableData.addObject(item["venue"]!)
                                    }
                                }

                            }
                        }
                      
                    }
                    print(self.tableData.count)

                    self.tableView.reloadData()
                    
                }else{
                    
                    self.alertMessage("servers connection fail", message: nil)
                }
        }
        
    }
    
    private func alertMessage(title:String, message:String?){
        //alert error
        let alertController = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.Alert)
        let okAction = UIAlertAction(title: "OK", style: .Default, handler: nil)
        alertController.addAction(okAction)
        
        self.presentViewController(alertController, animated: true, completion: nil)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return tableData.count
    }


    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(cellReuseIdentifier, forIndexPath: indexPath) as! CoffeeShopsTableViewCell

        // Configure the cell...
        if tableData.count>0{
            //prepare values
            
            let cellDictionary = tableData[indexPath.row] as! Dictionary <String, NSObject>
            let itemLocation = cellDictionary["location"] as! Dictionary <String, NSObject>
            
            //populate cells
            cell.nameLabel.text = cellDictionary["name"] as? String
            
            var fullAddress = ""
            if let formattedAddress = itemLocation["formattedAddress"] as? [String]{
                for address in formattedAddress{
                    fullAddress += address + " "
                }
            }
            cell.addressLabel.text = fullAddress
            
            //        print (itemLocation)
            if let distance = itemLocation["distance"] as? Int{
                
                cell.distanceLabel.text = "\(distance)m"
            }
        }

        return cell
    }
 
    // MARK: - Table view delegate
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {

        self.performSegueWithIdentifier("To MapView", sender: self)

        self.tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
   

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
 
        if segue.identifier == "To MapView" {
            
            if let destinationVC = segue.destinationViewController as? MapViewController{
                if let indexPath = self.tableView.indexPathForSelectedRow{
                    
                    if let itemDic =  self.tableData.objectAtIndex(indexPath.row) as? Dictionary<String,NSObject>{
                        
                        let itemLocation = itemDic["location"] as! Dictionary <String, NSObject>
                        
                        var fullAddress = ""
                        if let formattedAddress = itemLocation["formattedAddress"] as? [String]{
                            for address in formattedAddress{
                                fullAddress += address + " "
                            }
                        }
                        
                        destinationVC.lat = itemLocation["lat"] as! CLLocationDegrees
                        destinationVC.lng = itemLocation["lng"] as! CLLocationDegrees
                        destinationVC.addressString = fullAddress
                    }
                }
            }
        }

    }
    
    //MARK: - Update Data
    private func startTimer() {
        
        if timer == nil{
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)) {
                self.timer = NSTimer.scheduledTimerWithTimeInterval(self.updatingTime, target: self, selector: #selector(CoffeeShopsTableViewController.updateLocation), userInfo: nil, repeats: true)

                    NSRunLoop.currentRunLoop().run()

            }
        }
    }
    
    func updateLocation() {
    
        if let location = appDelegate.locationManager.location {
            self.prepareCoffeeShopsInfo(location)
            
        }
    }
}

