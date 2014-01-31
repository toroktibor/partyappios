//
//  LoginView.h
//  bcsapat
//
//  Created by hallgato on 1/10/14.
//  Copyright (c) 2014 hallgato. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>

@interface LoginView : UIViewController<CLLocationManagerDelegate,UITextFieldDelegate>{
    CLLocationManager *locationManager;
}


@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

- (IBAction)loginButtonPressed:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *userName;
@property (weak, nonatomic) IBOutlet UITextField *password;
@property (strong, nonatomic) IBOutlet UIButton *loginButton;
@property (weak, nonatomic) IBOutlet UIButton *registerButton;
@end
