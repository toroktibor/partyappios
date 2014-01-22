//
//  InformationView.m
//  bcsapat
//
//  Created by hallgato on 1/16/14.
//  Copyright (c) 2014 hallgato. All rights reserved.
//

#import "InformationView.h"
#import "Session.h"
#import <MessageUI/MFMailComposeViewController.h>
#import <MessageUI/MessageUI.h>

@interface InformationView ()
@end

@implementation InformationView
@synthesize clubNameText;

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
	// Do any additional setup after loading the view.
    
    int selectedIndex=[[Session getInstance]getSelectedIndex];
    [clubNameText setText:[[[[Session getInstance]getSearchViewCLubs]objectAtIndex:selectedIndex]getClubName]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)showEmail:(id)sender {
    if ([MFMailComposeViewController canSendMail]) {
        
        MFMailComposeViewController *mailViewController = [[MFMailComposeViewController alloc] init];
        mailViewController.mailComposeDelegate = self;
        [mailViewController setSubject:@"Subject Goes Here."];
        [mailViewController setMessageBody:@"Your message goes here." isHTML:NO];
        
        [self presentViewController:mailViewController animated:YES completion:nil];
        
    }
    
    else {
        
        NSLog(@"Device is unable to send email in its current state.");
            UIAlertView *Notpermitted=[[UIAlertView alloc] initWithTitle:@"Hiba" message:@"A készülék jelenlegi állapotában nem tud üzenetet küldeni!" delegate:nil
                                                       cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [Notpermitted show];
        
    }
}


/*-(void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error{
    [self dismissViewControllerAnimated:YES completion:nil];
}*/


- (IBAction)callButtonMethod:(id)sender {
    UIDevice *device = [UIDevice currentDevice];
    if ([[device model] isEqualToString:@"iPhone"] ) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel:130-032-2837"]]];
    } else {
        UIAlertView *Notpermitted=[[UIAlertView alloc] initWithTitle:@"Hiba" message:@"A készülék nem támogatja a telefonhívást!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [Notpermitted show];
    }
}

- (void) mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error
{
    switch (result)
    {
        case MFMailComposeResultCancelled:
            NSLog(@"Mail cancelled");
            break;
        case MFMailComposeResultSaved:
            NSLog(@"Mail saved");
            break;
        case MFMailComposeResultSent:
            NSLog(@"Mail sent");
            break;
        case MFMailComposeResultFailed:
            NSLog(@"Mail sent failure: %@", [error localizedDescription]);
            break;
        default:
            break;
    }
    
    // Close the Mail Interface
    [self dismissViewControllerAnimated:YES completion:NULL];
}
@end
