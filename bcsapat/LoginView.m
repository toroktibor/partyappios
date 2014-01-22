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
    
    
    //locationmanager a saját helyem meghatározásához
    locationManager = [[CLLocationManager alloc] init];
    locationManager.delegate = self;
    locationManager.distanceFilter = kCLDistanceFilterNone;
    locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    [locationManager startUpdatingLocation];
    
    
    /*NSArray* array=[[[Session getInstance]getDatabse]selectAllFromUser];
    for (int i=0; i<[array count]; ++i) {
        NSLog(@"%@",[array objectAtIndex:i]);
    }*/
    
    
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
            
           /* NSDictionary * dict=[userarray objectAtIndex:0];
            User *  user;*/
            
        }

    }
}

-(void) synchronise {
    //location managerből kiszedjük a kordinátákat
    NSString *lat=[NSString stringWithFormat:@"%f",locationManager.location.coordinate.latitude];
    NSString *lon=[NSString stringWithFormat:@"%f",locationManager.location.coordinate.longitude];
    
    
    //a meghívandó url string-be behegesztjük a kordinátákat
    NSString *urlstring=[NSString stringWithFormat:@"http://maps.googleapis.com/maps/api/geocode/json?latlng=%@,%@&sensor=false",lat,lon];
    
    //az url stringből létrehozunk egy urlt
    NSURL *url = [NSURL URLWithString:urlstring];
    
    //NSLog(@"%@",urlstring);
    
    //az url-ből visszakapunk egy egy json-t
    NSData *jsonData = [NSData dataWithContentsOfURL:url];
    NSError *error;
    
    //json-t átadjuk egy szótárnak
    NSDictionary *decoded= [NSJSONSerialization JSONObjectWithData:jsonData options:kNilOptions error:&error];
    
    NSLog(@"%@",[[[[[decoded objectForKey:@"results"]objectAtIndex:0]objectForKey:@"address_components"]objectAtIndex:2]objectForKey:@"long_name"]);
    
    NSString* cityName=[[[[[decoded objectForKey:@"results"]objectAtIndex:0]objectForKey:@"address_components"]objectAtIndex:2]objectForKey:@"long_name"];
    
    NSString* address=[[[decoded objectForKey:@"results"]objectAtIndex:0]objectForKey:@"formatted_address"];
    [[Session getInstance]setUserLocation:address];
    //NSLog(@"%@",address);
    
    NSMutableArray * inputClubList = [[[Session getInstance] getCommunication] getClubsFromCityName:cityName];
    [[Session getInstance] setSearchViewCLubs:inputClubList];
    
    /*NSInteger * user_id = [[[Session getInstance] getActualUser] getID];
    NSMutableArray * favoriteClubList = [[[Session getInstance] getCommunication] getFavoriteClubsFromUserId:user_id];
    [[[Session getInstance] getActualUser] setFavoriteClubs:favoriteClubList];
    NSMutableArray * usersClubList = [[[Session getInstance] getCommunication] getOwnedClubsFromUserId:user_id];
    [[[Session getInstance] getActualUser] setUsersClubs:usersClubList];
    [[Session getInstance] setSearchViewCLubs:inputClubList];*/
}

@end
