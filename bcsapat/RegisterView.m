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

@interface RegisterView ()

@end

@implementation RegisterView
@synthesize name,password,passwordAgain,email,birthdate,segmentControl;


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
    
    name.delegate=self;
    password.delegate=self;
    passwordAgain.delegate=self;
    email.delegate=self;
    birthdate.delegate=self;
    
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
        || (birthdate.text == nil ||
            [birthdate.text isEqualToString:@""])) {
        
        UIAlertView * alertview = [[UIAlertView alloc] initWithTitle:@"Regisztrációs hiba!"
                                                             message:@"Nem adtál meg minden adatot!"
                                                            delegate:nil
                                                   cancelButtonTitle:@"Ok"
                                                   otherButtonTitles: nil];
        [alertview show];
    }
   else{
      
        
        
    }
}




- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

@end
