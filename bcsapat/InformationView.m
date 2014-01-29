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
@synthesize imageView,descriptionView,club,addressField,phoneField,emailField,clubNameLabel,scrollView,starRatingView,ratingBackground,likeOrNot,firstButton,likeButton;

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
    
    scrollView.autoresizesSubviews=NO;
    
    likeOrNot=NO;
    
    int selectedIndex=[[Session getInstance]getSelectedIndex];
    club=[[Session getInstance]getSelectedClubAtIndex:selectedIndex];
    
    
    starRatingView = [[TQStarRatingView alloc] initWithFrame:CGRectMake(20, 4, 125, 25)
                                                 numberOfStar:5];
    starRatingView.delegate = self;
    
    [starRatingView setScore:[club getAverageRating] withAnimation:NO];
    [ratingBackground addSubview:starRatingView];
    
    
    
    
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bricskok.png"]];
    
    [[[self navigationController] navigationBar] setTintColor:[UIColor colorWithRed:(60/255.0) green:(60/255.0) blue:(100/255.0) alpha:1.0]];
    

    
    
    descriptionView.editable=NO;
    [descriptionView setText:[club getDescription]];
    descriptionView.backgroundColor=[UIColor colorWithRed:(154/255.0) green:(111/255.0) blue:(189/255.0) alpha:0];
    descriptionView.textColor=[UIColor whiteColor];
    
    UIImage * image = [UIImage imageNamed: @"2050-halloween-debrecen-halloween-napok-az-erdospuszta-club-hotelben.jpg"];
    [imageView setImage:image];
    
    
    clubNameLabel.text=[club getClubName];
    
    addressField.backgroundColor=[UIColor colorWithRed:(154/255.0) green:(111/255.0) blue:(189/255.0) alpha:0.5];
    addressField.textColor=[UIColor whiteColor];
    addressField.enabled=NO;
    addressField.text=[club getAddress];
    
    emailField.backgroundColor=[UIColor colorWithRed:(154/255.0) green:(111/255.0) blue:(189/255.0) alpha:0.5];
    emailField.textColor=[UIColor whiteColor];
    emailField.enabled=NO;
    emailField.text=[club getEmail];
    
    phoneField.backgroundColor=[UIColor colorWithRed:(154/255.0) green:(111/255.0) blue:(189/255.0) alpha:0.5];
    phoneField.textColor=[UIColor whiteColor];
    phoneField.enabled=NO;
    phoneField.text=[club getPhoneNumber];
    
    ratingBackground.backgroundColor=[UIColor colorWithRed:(154/255.0) green:(111/255.0) blue:(189/255.0) alpha:0.5];
    ratingBackground.textColor=[UIColor whiteColor];
    ratingBackground.enabled=NO;
    
    
    UIBarButtonItem *actionItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAction target:self action:@selector(showActionSheet)];
    UIBarButtonItem *likeButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"ic_action_favorite.png"] style:UIBarButtonItemStyleBordered target:self action:@selector(like)];
    
    
    
    NSArray *actionButtonItems = @[actionItem, likeButton];
    self.navigationItem.rightBarButtonItems = actionButtonItems;
    
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
            NSArray *toRecipients = [NSArray arrayWithObjects:[club getEmail],nil];
            [mailViewController setToRecipients:toRecipients];
            //[mailViewController setSubject:@"Subject Goes Here."];
            //[mailViewController setMessageBody:@"Your message goes here." isHTML:NO];
            
            [self presentViewController:mailViewController animated:YES completion:nil];
            
        }
        
        else {
            
            NSLog(@"Device is unable to send email in its current state.");
            UIAlertView *Notpermitted=[[UIAlertView alloc] initWithTitle:@"Hiba" message:@"A készülék jelenleg nem tud üzenetet küldeni!" delegate:nil
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
        [self.navigationController pushViewController:RatingTableView animated:YES];
    }

        
    
    else if (buttonIndex == 6) {
        
        //mégse
    }

}


- (IBAction)back:(id)sender {
    
    UITabBarController *tabBar = [[UIStoryboard storyboardWithName:@"MainStoryboard_iPhone" bundle:nil] instantiateViewControllerWithIdentifier:@"mainMenuTabBar"];
    
    
    tabBar.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    [self presentViewController: tabBar animated: YES completion:nil];
}


- (void)showActionSheet{
    
    UIActionSheet *popupQuery = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"Mégse"
                                              destructiveButtonTitle:nil otherButtonTitles:@"Tulajdonos vagyok",@"Mutasd a térképen", @"Hívás",@"Email küldése",@"Árlista",@"Értékelések", nil];
    
    popupQuery.actionSheetStyle = UIActionSheetStyleBlackOpaque;
    [popupQuery showInView:[UIApplication sharedApplication].keyWindow];
    popupQuery.frame = CGRectMake(0, [UIScreen mainScreen].bounds.size.height-popupQuery.frame.size.height, [UIScreen mainScreen].bounds.size.width, popupQuery.frame.size.height);
}


-(void)viewWillAppear:(BOOL)animated{
    [starRatingView setScore:[club getAverageRating] withAnimation:NO];
    
    [super viewWillAppear:animated];
}


-(void)like{

}
@end
