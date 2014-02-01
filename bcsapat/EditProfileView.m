//
//  EditProfileView.m
//  bcsapat
//
//  Created by hallgato on 1/17/14.
//  Copyright (c) 2014 hallgato. All rights reserved.
//

#import "EditProfileView.h"
#import "Session.h"
#import "ProfileTableView.h"
#import <QuartzCore/QuartzCore.h>

@interface EditProfileView ()

@end

@implementation EditProfileView
@synthesize emailTextField,birthDayTextField,saveButton,changeDateButton;

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
    
 
    
    emailTextField.backgroundColor=[UIColor colorWithRed:(154/255.0) green:(111/255.0) blue:(189/255.0) alpha:0.5];
    emailTextField.textColor=[UIColor whiteColor];
    
    birthDayTextField.backgroundColor=[UIColor colorWithRed:(154/255.0) green:(111/255.0) blue:(189/255.0) alpha:0.5];
    birthDayTextField.textColor=[UIColor whiteColor];
    birthDayTextField.enabled=NO;
    
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bricskok.png"]];
    
 
    
    emailTextField.delegate=self;
    
    
    [emailTextField setText:[[[Session getInstance]getActualUser]getEmail]];
    [birthDayTextField setText:[[[Session getInstance]getActualUser]getBirthday]];
    
    saveButton.layer.cornerRadius = 8;
    saveButton.clipsToBounds = YES;
    
    changeDateButton.layer.cornerRadius = 8;
    changeDateButton.clipsToBounds = YES;
    
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)saveChanges:(id)sender {
    if (  (emailTextField.text == nil ||
                                                               [emailTextField.text isEqualToString:@""])
        || (birthDayTextField.text == nil ||
            [birthDayTextField.text isEqualToString:@""])) {
            
            UIAlertView * alertview = [[UIAlertView alloc] initWithTitle:@"Hiba!"
                                                                 message:@"Minden mező kitöltése kötelező!"
                                                                delegate:nil
                                                       cancelButtonTitle:@"Ok"
                                                       otherButtonTitles: nil];
            [alertview show];
        }
    else{
        [[[Session getInstance]getActualUser]setEmail:emailTextField.text];
        [[[Session getInstance]getActualUser]setBirthday:birthDayTextField.text];
        

        [[[Session getInstance]getActualUser]setSex:1];

        
        User * au = [[Session getInstance]getActualUser];
        
        [[[Session getInstance] getCommunication] modifyUserDataWithId:[au getID] andEmail:[ au getEmail] andBirthday:[au getBirthday] andSex:[au getSex]];
        
        UIAlertView * alertview = [[UIAlertView alloc] initWithTitle:@"Rendben!"
                                                             message:@"Adatok módosítva!"
                                                            delegate:nil
                                                   cancelButtonTitle:@"Ok"
                                                   otherButtonTitles: nil];
        [alertview show];

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
    }
    return NO; // We do not want UITextField to insert line-breaks.
}


-(void)viewWillAppear:(BOOL)animated{
    [birthDayTextField setText:[[[Session getInstance]getActualUser]getBirthday]];
}

@end
