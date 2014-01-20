//
//  LoginView.m
//  bcsapat
//
//  Created by hallgato on 1/10/14.
//  Copyright (c) 2014 hallgato. All rights reserved.
//

#import "LoginView.h"
#import "Session.h"
#import "Session.h"
#import "User.h"

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
    
    NSArray* array=[[[Session getInstance]getDatabse]selectAllFromUser];
    for (int i=0; i<[array count]; ++i) {
        NSLog(@"%@",[array objectAtIndex:i]);
    }
    
    
    userName.delegate=self;
    password.delegate=self;
    
    if (![[Session getInstance]isNetworAvaiable]) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Nincs internet kapcsolat!"
                                                        message:@"Offline módban tudsz csak bejelentkezni!"
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];

    }
    
    
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
    
    
   
    if ([[Session getInstance]isNetworAvaiable]) {
        //login online
        User * user=[[[Session getInstance]getCommunication]authenticationUserWithNickName:userNameString andPassword:passwordString];
        if(user==nil){
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Hibás belépési adatok!"
                                                            message:@"A jelszavad vagy a felhasználóneved helytelen."
                                                           delegate:nil
                                                  cancelButtonTitle:@"OK"
                                                  otherButtonTitles:nil];
            [alert show];

        }
        else{
            [[Session getInstance]setActualUser:user];
            [self synchronise];
            
            [[Session getInstance]testAddString:@"Ibolya"];
            [[Session getInstance]testAddString:@"Bárka"];
            [[Session getInstance]testAddString:@"Roncs"];
            
            UITabBarController *tabBar = [[UIStoryboard storyboardWithName:@"MainStoryboard_iPhone" bundle:nil] instantiateViewControllerWithIdentifier:@"mainMenuTabBar"];
            
            tabBar.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
            [self presentViewController: tabBar animated: YES completion:nil];
        }
    }
    else{
        //login offline
        NSArray* userarray=[[[Session getInstance]getDatabse]loginWithNickName:userNameString andPassword:passwordString];
        if (userarray==nil) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Hibás belépési adatok!"
                                                            message:@"A jelszavad vagy a felhasználóneved helytelen."
                                                           delegate:nil
                                                  cancelButtonTitle:@"OK"
                                                  otherButtonTitles:nil];
            [alert show];

        }
        else{
            
            NSDictionary * dict=[userarray objectAtIndex:0];
            User *  user;
            
        }

    }
}

-(void) synchronise {

}

@end
