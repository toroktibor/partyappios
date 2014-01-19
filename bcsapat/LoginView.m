//
//  LoginView.m
//  bcsapat
//
//  Created by hallgato on 1/10/14.
//  Copyright (c) 2014 hallgato. All rights reserved.
//

#import "LoginView.h"
#import "Session.h"

@interface LoginView ()

@end

@implementation LoginView
@synthesize userName,password;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    userName.delegate=self;
    password.delegate=self;
    
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

- (IBAction)loginButtonPressed:(id)sender {
    NSString * userNameString = [userName text];
    NSString * passwordString = [password text];
    if([userNameString isEqualToString:@""]){
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Nem adtál meg felhasználónevet!"
                                                        message:@"Kérlek add meg a felhasználóneved a belépéshez."
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
        return ;
    }
    if([passwordString isEqualToString:@""]){
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Nem adtál meg jelszót!"
                                                        message:@"Kérlek add meg a jelszavad a belépéshez."
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
        return ;
    }
    
    if(!([userNameString isEqualToString:@"a"] && [passwordString isEqualToString:@"a"])){
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Hibás belépési adatok!"
                                                        message:@"A jelszavad vagy a felhasználóneved helytelen."
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
        return ;
    }
    
    //[Session ];
    
    UITabBarController *tabBar = [[UIStoryboard storyboardWithName:@"MainStoryboard_iPhone" bundle:nil] instantiateViewControllerWithIdentifier:@"mainMenuTabBar"];
    
    tabBar.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    [self presentViewController: tabBar animated: YES completion:nil];
}

-(void) synchronise {

}

@end
