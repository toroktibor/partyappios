//
//  ChangePasswordView.m
//  bcsapat
//
//  Created by hallgato on 1/17/14.
//  Copyright (c) 2014 hallgato. All rights reserved.
//

#import "ChangePasswordView.h"
#import "Session.h"

@interface ChangePasswordView ()

@end

@implementation ChangePasswordView
@synthesize oldPasswordTextField,actualPasswordAgaingTextField,actualPasswordTextField;

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
    
    oldPasswordTextField.delegate=self;
    actualPasswordTextField.delegate=self;
    actualPasswordAgaingTextField.delegate=self;
    
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
    [textField resignFirstResponder];
    return YES;
}
@end
