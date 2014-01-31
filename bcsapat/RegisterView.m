//
//  RegisterView.m
//  bcsapat
//
//  Created by hallgato on 1/14/14.
//  Copyright (c) 2014 hallgato. All rights reserved.
//

#import "RegisterView.h"
#import "MyDatabase.h"
#import "Session.h"
#import <QuartzCore/QuartzCore.h>
#import "DatePickerForRegisterView.h"
#import "User.h"

@interface RegisterView ()

@end

@implementation RegisterView
@synthesize name,password,passwordAgain,email,birthdate,segmentControl,registerButton,cancelButton,user,changeDateButton,scrollView;


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
    

    segmentControl.tintColor = [UIColor colorWithRed:(154/255.0)   green:(111/255.0)  blue:(189/255.0)  alpha:0.5];
    
    segmentControl.segmentedControlStyle = UISegmentedControlStyleBar;
    
    [changeDateButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [changeDateButton setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];

    cancelButton.layer.cornerRadius = 8;
    //loginButton.layer.borderWidth = 1;
    //loginButton.layer.borderColor = [UIColor grayColor].CGColor;
    cancelButton.clipsToBounds = YES;
    
    registerButton.layer.cornerRadius = 8;
    //registerButton.layer.borderWidth = 1;
    //registerButton.layer.borderColor = [UIColor grayColor].CGColor;
    registerButton.clipsToBounds = YES;
    
    changeDateButton.layer.cornerRadius = 8;
    changeDateButton.clipsToBounds = YES;
    
   
    //locationmanager a saját helyem meghatározásához
    locationManager = [[CLLocationManager alloc] init];
    locationManager.delegate = self;
    locationManager.distanceFilter = kCLDistanceFilterNone;
    locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    [locationManager startUpdatingLocation];
    
    
    name.delegate=self;
    name.tag=0;
    
    password.delegate=self;
    password.tag=1;
    
    passwordAgain.delegate=self;
    passwordAgain.tag=2;
    
    email.delegate=self;
    email.tag=3;
    
    birthdate =[[Session getInstance]getBirthday];
    
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bricskok.png"]];
    UIColor * myBackgroundColor = [UIColor colorWithRed:(154/255.0) green:(111/255.0) blue:(189/255.0) alpha:0.5];
    UIColor * myTextColor = [UIColor whiteColor];
    
    name.backgroundColor = myBackgroundColor;
    name.textColor = myTextColor;
    
    password.backgroundColor = myBackgroundColor;
    password.textColor = myTextColor;
    
    passwordAgain.backgroundColor = myBackgroundColor;
    passwordAgain.textColor = myTextColor;
    
    email.backgroundColor = myBackgroundColor;
    email.textColor = myTextColor;
    
	// Do any additional setup after loading the view.
   /* NSArray* paths =NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString* documentsDirectory = [paths objectAtIndex:0];
    NSString *path =[documentsDirectory stringByAppendingPathComponent:@"partyapp.db"];
    
    MyDatabase * db=[[MyDatabase alloc]initWithPath:path];
    
    
    NSArray *array = [db performQuery:@"select * from user;"];
    for (int i=0; i< [array count]; i++){
        NSLog(@"%@",[array objectAtIndex:i]);
    }*/
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (IBAction)cancel:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)register:(id)sender {
    
    if ( (name.text == nil ||
          [name.text isEqualToString:@""]) || (passwordAgain.text == nil ||
                                               [passwordAgain.text isEqualToString:@""])
        || (password.text == nil ||
            [password.text isEqualToString:@""]) ||(email.text == nil ||
                                                    [email.text isEqualToString:@""])
        || (birthdate == nil ||
            [birthdate isEqualToString:@""])) {
        
        UIAlertView * alertview = [[UIAlertView alloc] initWithTitle:@"Regisztrációs hiba!"
                                                             message:@"Minden mező kitöltése kötelező!"
                                                            delegate:nil
                                                   cancelButtonTitle:@"Ok"
                                                   otherButtonTitles: nil];
        [alertview show];
    }
    else if(![password.text isEqualToString:passwordAgain.text]){
        
        UIAlertView * alertview = [[UIAlertView alloc] initWithTitle:@"Regisztrációs hiba!"
                                                             message:@"A megadott jelszavak nem egyezenek!"
                                                            delegate:nil
                                                   cancelButtonTitle:@"Ok"
                                                   otherButtonTitles: nil];
        [alertview show];
        
    }
   else{
      
       user=[[[Session getInstance]getCommunication]
             registerANewUserWithName:name.text
             andPassword:password.text
             andEmail:email.text
             andSex:[segmentControl selectedSegmentIndex]
        andBirthday:birthdate];
    
       if(!user){
           UIAlertView * alertview = [[UIAlertView alloc] initWithTitle:@"Regisztrációs hiba!"
                                                                message:@"A felhasználónév már foglalt!"
                                                               delegate:nil
                                                      cancelButtonTitle:@"Ok"
                                                      otherButtonTitles: nil];
    
  
           [alertview show];
       }
       else{
  
                [[Session getInstance]setActualUser:user];
           
           
           if (locationManager.location.coordinate.latitude==0 && locationManager.location.coordinate.longitude==0) {
               NSMutableArray * inputClubList = [[[Session getInstance] getCommunication] getClubsFromCityName:@"Debrecen"];
               [[Session getInstance] setSearchViewCLubs:inputClubList];
               
               
               UITabBarController *tabBar = [[UIStoryboard storyboardWithName:@"MainStoryboard_iPhone" bundle:nil] instantiateViewControllerWithIdentifier:@"mainMenuTabBar"];
               
               tabBar.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
               [self presentViewController: tabBar animated: YES completion:nil];
               
               UIAlertView * alertview = [[UIAlertView alloc] initWithTitle:@"Rendben!"
                                                                    message:@"Sikeres regisztráció!"
                                                                   delegate:nil
                                                          cancelButtonTitle:@"Ok"
                                                          otherButtonTitles: nil];
               [alertview show];
               
           }
           else{
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
               
               
               UITabBarController *tabBar = [[UIStoryboard storyboardWithName:@"MainStoryboard_iPhone" bundle:nil] instantiateViewControllerWithIdentifier:@"mainMenuTabBar"];
               
               tabBar.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
               [self presentViewController: tabBar animated: YES completion:nil];
               
               
               UIAlertView * alertview = [[UIAlertView alloc] initWithTitle:@"Rendben!"
                                                                        message:@"Sikeres regisztráció!"
                                                                       delegate:nil
                                                              cancelButtonTitle:@"Ok"
                                                              otherButtonTitles: nil];
               [alertview show];
           }

           
       }
           
        
}
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    NSInteger nextTag = textField.tag + 1;
    // Try to find next responder
    UIResponder* nextResponder = [textField.superview viewWithTag:nextTag];
    if (nextResponder) {
        // Found next responder, so set it.
        [nextResponder becomeFirstResponder];
    } else {
        // Not found, so remove keyboard.
        [textField resignFirstResponder];
        [self pickDate:nil];
    }
    return NO; // We do not want UITextField to insert line-breaks.
}

-(void)viewWillAppear:(BOOL)animated{
    birthdate = [[Session getInstance]getBirthday];
    [changeDateButton setTitle: birthdate forState:UIControlStateNormal ];
    [changeDateButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [changeDateButton setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
    [super viewWillAppear:animated];
}

-(void)viewWillDisappear:(BOOL)animated{
    [[Session getInstance]setBirthDay:@""];
    [super viewWillDisappear:animated];
}

- (IBAction)pickDate:(id)sender {

    DatePickerForRegisterView *DatePickerForRegisterView=
    [self.storyboard instantiateViewControllerWithIdentifier:@"DatePickerForRegisterView"];
    [self presentViewController:DatePickerForRegisterView animated:YES completion:nil];
}



- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    [self.scrollView setContentSize:CGSizeMake(320, 400)];
}
@end
