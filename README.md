# CoffeeShops


# Using
* Xcode 7 
* Swift 2.1
* iOS 8.1+



#How to run my code
* Install CocoaPod:
```
platform :ios, '8.0'
use_frameworks!

pod 'Alamofire', '~> 3.3'
pod 'MBProgressHUD', '~> 0.9.2'
```

* cd ~/Path/To/Folder/Containing/CoffeeShops
* pod install
* run CoffeeShops.xcworkspace

# What approach I took.
* I read the details of the the question and get a fully understanding about this question.
* I draw a brief idea about the UX which includes a tableview for coffee shops and a mapview for displaying location
* I read foursquare API document, I choose "https://api.foursquare.com/v2/venues/explore" which is more suitable for this task.
* than coding and testing for this question.
* I use a push segue to display location on a map
* I created an extra static tableView as a main entry, because I will display a alert for user who first time open this app and who needs to turn location service on.






