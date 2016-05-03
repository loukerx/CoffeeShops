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
    
    private var HUD_: MBProgressHUD = MBProgressHUD()
    private var tableData = NSMutableArray()
    
    // MARK: - Views
    override func viewDidLoad() {
        super.viewDidLoad()

        //Loading
        HUD_ = MBProgressHUD.showHUDAddedTo(self.view, animated: true)
        HUD_.mode = MBProgressHUDMode.Indeterminate
        HUD_.labelText = HUDLoadingMessage
        self.view.userInteractionEnabled = false
        
        self.prepareCoffeeShopsInfo()
        
    }

    //MARK: Prepare Shops Details
    private func prepareCoffeeShopsInfo(){

        
        
        let URL = NSURL(string: "https://api.foursquare.com/v2/venues/explore")!
        
        let parameters = [
            "client_id": clientID,
            "client_secret": clientSecret,
            "v" : version,
            "ll": "40.7,-74",
            "section": section,
            "sortByDistance": sortByDistance,
            "limit": limit
            
        ]
        
        
        Alamofire.request(.GET, URL, parameters: parameters as? [String : AnyObject])
            .responseJSON { response in

                print(response)
                self.view.userInteractionEnabled = true
                MBProgressHUD.hideAllHUDsForView(self.view, animated: true)
                
                if response.result.isSuccess{
                    if  let JSONDictionary = response.result.value as? Dictionary<String, NSObject>{
                       print(JSONDictionary)
                        
                    }
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
        //prepare values
        let cellDictionary = tableData[indexPath.row] as! Dictionary <String, NSObject>
        
        
        return cell
    }
 

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
