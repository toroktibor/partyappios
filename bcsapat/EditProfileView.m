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

@interface EditProfileView ()

@end

@implementation EditProfileView
@synthesize nameTextField,emailTextField,birthDayTextField,segmentControl;

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
    
    
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"Snowflakes-Background-960x640.png"]];
    
    nameTextField.delegate=self;
    emailTextField.delegate=self;
    birthDayTextField.delegate=self;
    
    [nameTextField setText:[[[Session getInstance]getActualUser]getName]];
    [emailTextField setText:[[[Session getInstance]getActualUser]getEmail]];
    [birthDayTextField setText:[[[Session getInstance]getActualUser]getBirthday]];
    
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
    [textField resignFirstResponder];
    return YES;
}
@end
