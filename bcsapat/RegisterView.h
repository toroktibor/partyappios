//
//  RegisterView.h
//  bcsapat
//
//  Created by hallgato on 1/14/14.
//  Copyright (c) 2014 hallgato. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import "User.h"

@interface RegisterView : UIViewController<CLLocationManagerDelegate,UITextFieldDelegate>{
    CLLocationManager *locationManager;
}
- (IBAction)cancel:(id)sender;
- (IBAction)register:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *name;
@property (weak, nonatomic) IBOutlet UITextField *password;
@property (weak, nonatomic) IBOutlet UITextField *passwordAgain;
@property (weak, nonatomic) IBOutlet UITextField *email;
@property (weak, nonatomic) NSString *birthdate;
@property (weak, nonatomic) IBOutlet UISegmentedControl *segmentControl;
@property (weak, nonatomic) IBOutlet UIButton *registerButton;
@property (weak, nonatomic) IBOutlet UIButton *cancelButton;
@property (weak, nonatomic) IBOutlet UIButton *changeDateButton;
- (IBAction)pickDate:(id)sender;

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property User * user;
@end
