//
//  ChangePasswordView.m
//  bcsapat
//
//  Created by hallgato on 1/17/14.
//  Copyright (c) 2014 hallgato. All rights reserved.
//

#import "ChangePasswordView.h"
#import "Session.h"
#import <QuartzCore/QuartzCore.h>

@interface ChangePasswordView ()

@end

@implementation ChangePasswordView
@synthesize oldPasswordTextField,actualPasswordAgaingTextField,actualPasswordTextField,changeButton;

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
    
    
    oldPasswordTextField.backgroundColor=[UIColor colorWithRed:(154/255.0) green:(111/255.0) blue:(189/255.0) alpha:0.5];
    oldPasswordTextField.textColor=[UIColor whiteColor];
    
    actualPasswordTextField.backgroundColor=[UIColor colorWithRed:(154/255.0) green:(111/255.0) blue:(189/255.0) alpha:0.5];
    actualPasswordTextField.textColor=[UIColor whiteColor];
    
    actualPasswordAgaingTextField.backgroundColor=[UIColor colorWithRed:(154/255.0) green:(111/255.0) blue:(189/255.0) alpha:0.5];
    actualPasswordAgaingTextField.textColor=[UIColor whiteColor];
    
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bricskok.png"]];
    
    oldPasswordTextField.delegate=self;
    oldPasswordTextField.tag=0;
    
    actualPasswordTextField.delegate=self;
    actualPasswordTextField.tag=1;
    
    actualPasswordAgaingTextField.delegate=self;
    actualPasswordAgaingTextField.tag=2;
    
    changeButton.layer.cornerRadius = 8;
    changeButton.clipsToBounds = YES;
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)changePassword:(id)sender {
    if ( (oldPasswordTextField.text == nil ||
          [oldPasswordTextField.text isEqualToString:@""]) || (actualPasswordAgaingTextField.text == nil ||
                                               [actualPasswordAgaingTextField.text isEqualToString:@""])
        || (actualPasswordTextField.text == nil ||
            [actualPasswordTextField.text isEqualToString:@""])) {
            
            UIAlertView * alertview = [[UIAlertView alloc] initWithTitle:@"Hiba!"
                                                                 message:@"Minden mező kitöltése kötelező!"
                                                                delegate:nil
                                                       cancelButtonTitle:@"Ok"
                                                       otherButtonTitles: nil];
            [alertview show];
        }
    else if (![[[[Session getInstance]getActualUser]getPassword]isEqualToString:oldPasswordTextField.text]){
        UIAlertView * alertview = [[UIAlertView alloc] initWithTitle:@"Hiba!"
                                                             message:@"Nem megfelelő aktuális jelszó!"
                                                            delegate:nil
                                                   cancelButtonTitle:@"Ok"
                                                   otherButtonTitles: nil];
        [alertview show];
    }
    else if (![actualPasswordAgaingTextField.text isEqualToString:actualPasswordTextField.text]){
        UIAlertView * alertview = [[UIAlertView alloc] initWithTitle:@"Hiba!"
                                                             message:@"A megadott jelszavak nem egyeznek!"
                                                            delegate:nil
                                                   cancelButtonTitle:@"Ok"
                                                   otherButtonTitles: nil];
        [alertview show];
    }
    else{
        
        [[[Session getInstance] getCommunication] modifyPasswordWithId:[[[Session getInstance]getActualUser] getID] andPassword: actualPasswordTextField.text];
        
        [[[Session getInstance]getActualUser]setPassword:actualPasswordTextField.text];
        UIAlertView * alertview = [[UIAlertView alloc] initWithTitle:@"Rendben!"
                                                             message:@"A jelszó megváltozott!"
                                                            delegate:nil
                                                   cancelButtonTitle:@"Ok"
                                                   otherButtonTitles: nil];
        [alertview show];
        
        NSLog(@"új jelszó: %@",[[[Session getInstance]getActualUser]getPassword]);
        
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
@end
