//
//  SearchTableView.h
//  bcsapat
//
//  Created by hallgato on 1/22/14.
//  Copyright (c) 2014 hallgato. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>

@interface SearchTableView : UITableViewController<UIActionSheetDelegate,CLLocationManagerDelegate,UITextFieldDelegate>{
    CLLocationManager *locationManager;
}






@property (weak, nonatomic) IBOutlet UITextField *addressTextField;
@property (weak, nonatomic) IBOutlet UILabel *typeLabel;
@property (weak, nonatomic) IBOutlet UITextField *nameTextField;

@property BOOL liveMusicSelected;
@property BOOL sportBroadcastSelected;
@property BOOL snookerSelected;
@property BOOL danceSelected;

- (IBAction)showActionSheet:(id)sender;

@end
