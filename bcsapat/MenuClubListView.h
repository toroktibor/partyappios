//
//  MenuClubListView.h
//  bcsapat
//
//  Created by hallgato on 1/10/14.
//  Copyright (c) 2014 hallgato. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>

@interface MenuClubListView : UITableViewController<UIActionSheetDelegate,CLLocationManagerDelegate,UITableViewDataSource>{
    CLLocationManager *locationManager;
}

@property NSArray *szh;
@property NSString *clubName;
- (IBAction)showActionSheet:(id)sender;

@end
