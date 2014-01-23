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
#import "Club.h"
#import "ClubMapView.h"
#import "FoodsAndDrinksTableView.h"
#import "RatingTableViewViewController.h"

@interface InformationView ()
@end

@implementation InformationView
@synthesize clubNameText,addressLabel,phonenumberLabel,emailLabel,imageView,descriptionView;

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
    Club * club=[[Session getInstance]getSelectedClubAtIndex:selectedIndex];
    [clubNameText setText:[club getClubName]];
    [addressLabel setText:[club getAddress]];
    [phonenumberLabel setText:[club getPhoneNumber]];
    [emailLabel setText:[club getEmail]];
    [descriptionView setText:[club getDescription]];
    
    descriptionView.editable=NO;
    
    UIImage * image = [UIImage imageNamed: @"2050-halloween-debrecen-halloween-napok-az-erdospuszta-club-hotelben.jpg"];
    [imageView setImage:image];
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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



- (IBAction)showActionSheet:(id)sender {
    UIActionSheet *popupQuery = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"Mégse"
                                              destructiveButtonTitle:nil otherButtonTitles:@"Tulajdonos vagyok",@"Térkép", @"Hívás",@"Email küldése",@"Árlista",@"Értékelések", nil];
    
    popupQuery.actionSheetStyle = UIActionSheetStyleBlackOpaque;
    [popupQuery showInView:[UIApplication sharedApplication].keyWindow];
    popupQuery.frame = CGRectMake(0, [UIScreen mainScreen].bounds.size.height-popupQuery.frame.size.height, [UIScreen mainScreen].bounds.size.width, popupQuery.frame.size.height);
}


-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 0) {
        
        //tulajdonos vagyok
        
        
        
        
    }
    
    if (buttonIndex == 1) {
        
        //tékép nézet
        
        ClubMapView *ClubMapView=
        [self.storyboard instantiateViewControllerWithIdentifier:@"ClubMapView"];
        [self.navigationController pushViewController:ClubMapView animated:YES];

        
        
        
    } else if (buttonIndex == 2) {
        
        //hívás
        UIDevice *device = [UIDevice currentDevice];
        if ([[device model] isEqualToString:@"iPhone"] ) {
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel:130-032-2837"]]];
        } else {
            UIAlertView *Notpermitted=[[UIAlertView alloc] initWithTitle:@"Hiba" message:@"A készülék nem támogatja a telefonhívást!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [Notpermitted show];
        }

        
    } else if (buttonIndex == 3) {
        
        //email
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
        
    } else if (buttonIndex == 4) {
        
        FoodsAndDrinksTableView *FoodsAndDrinksTableView=
        [self.storyboard instantiateViewControllerWithIdentifier:@"FoodsAndDrinksTableView"];
        [self.navigationController pushViewController:FoodsAndDrinksTableView animated:YES];
            
        }
    
    else if (buttonIndex == 5){
        
        RatingTableViewViewController *RatingTableView=
        [self.storyboard instantiateViewControllerWithIdentifier:@"RatingTableView"];
        UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:RatingTableView];
        [self presentViewController:navController animated:YES completion:nil];
    }

        
    
    else if (buttonIndex == 6) {
        
        //mégse
    }

}


@end
