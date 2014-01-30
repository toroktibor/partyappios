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
@synthesize nameTextField,emailTextField,birthDayTextField,segmentControl,saveButton,changeDateButton;

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
    
    nameTextField.backgroundColor=[UIColor colorWithRed:(154/255.0) green:(111/255.0) blue:(189/255.0) alpha:0.5];
    nameTextField.textColor=[UIColor whiteColor];
    
    emailTextField.backgroundColor=[UIColor colorWithRed:(154/255.0) green:(111/255.0) blue:(189/255.0) alpha:0.5];
    emailTextField.textColor=[UIColor whiteColor];
    
    birthDayTextField.backgroundColor=[UIColor colorWithRed:(154/255.0) green:(111/255.0) blue:(189/255.0) alpha:0.5];
    birthDayTextField.textColor=[UIColor whiteColor];
    
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bricskok.png"]];
    
    nameTextField.delegate=self;
    nameTextField.tag=0;
    
    emailTextField.delegate=self;
    emailTextField.tag=1;
    
    birthDayTextField.delegate=self;
    birthDayTextField.tag=2;
    
    [nameTextField setText:[[[Session getInstance]getActualUser]getName]];
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
    if ( (nameTextField.text == nil ||
          [nameTextField.text isEqualToString:@""]) || (emailTextField.text == nil ||
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
        [[[Session getInstance]getActualUser]setName:nameTextField.text];
        [[[Session getInstance]getActualUser]setEmail:emailTextField.text];
        [[[Session getInstance]getActualUser]setBirthday:birthDayTextField.text];
        
        if ([segmentControl selectedSegmentIndex]==0) {
            [[[Session getInstance]getActualUser]setSex:1];
        }
        else{
            [[[Session getInstance]getActualUser]setSex:0];
        }
        
        
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
