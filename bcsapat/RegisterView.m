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
    name.tag=0;
    
    password.delegate=self;
    password.tag=1;
    
    passwordAgain.delegate=self;
    passwordAgain.tag=2;
    
    email.delegate=self;
    email.tag=3;
    
    birthdate.delegate=self;
    birthdate.tag=4;
    
    
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bricskok.png"]];
    
    
    name.backgroundColor=[UIColor colorWithRed:(154/255.0) green:(111/255.0) blue:(189/255.0) alpha:0.5];
    name.textColor=[UIColor whiteColor];
    
    password.backgroundColor=[UIColor colorWithRed:(154/255.0) green:(111/255.0) blue:(189/255.0) alpha:0.5];
    password.textColor=[UIColor whiteColor];
    
    passwordAgain.backgroundColor=[UIColor colorWithRed:(154/255.0) green:(111/255.0) blue:(189/255.0) alpha:0.5];
    passwordAgain.textColor=[UIColor whiteColor];
    
    email.backgroundColor=[UIColor colorWithRed:(154/255.0) green:(111/255.0) blue:(189/255.0) alpha:0.5];
    email.textColor=[UIColor whiteColor];
    
    birthdate.backgroundColor=[UIColor colorWithRed:(154/255.0) green:(111/255.0) blue:(189/255.0) alpha:0.5];
    birthdate.textColor=[UIColor whiteColor];
    
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
                                                             message:@"Minden mező kitöltése kötelező!"
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
