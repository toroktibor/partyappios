//
//  SearchTableView.m
//  bcsapat
//
//  Created by hallgato on 1/22/14.
//  Copyright (c) 2014 hallgato. All rights reserved.
//

#import "SearchTableView.h"
#import "PickerForSearchView.h"
#import "Session.h"
#import "NotificationsView.h"
#import "ProfileTableView.h"
#import "AddNewClubView.h"
#import "LoginView.h"

@interface SearchTableView ()

@end

@implementation SearchTableView
@synthesize danceCheckBox,snookerCheckBox,nameTextField,sportBroadcastCheckBox,liveMusicCheckBox,typeLabel,addressTextField,danceSelected,snookerSelected,liveMusicSelected,sportBroadcastSelected;
- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    addressTextField.delegate=self;
    nameTextField.delegate=self;
    
    danceSelected=NO;
    liveMusicSelected=NO;
    sportBroadcastSelected=NO;
    snookerSelected=NO;
    
    locationManager = [[CLLocationManager alloc] init];
    locationManager.delegate = self;
    locationManager.distanceFilter = kCLDistanceFilterNone;
    locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    [locationManager startUpdatingLocation];
    
    [danceCheckBox setBackgroundImage:[UIImage imageNamed:@"1389999128_unchecked_checkbox.png"]
                           forState:UIControlStateNormal];
    [danceCheckBox setBackgroundImage:[UIImage imageNamed:@"1389999143_checked_checkbox.png"]
                           forState:UIControlStateSelected];
    
    [snookerCheckBox setBackgroundImage:[UIImage imageNamed:@"1389999128_unchecked_checkbox.png"]
                             forState:UIControlStateNormal];
    [snookerCheckBox setBackgroundImage:[UIImage imageNamed:@"1389999143_checked_checkbox.png"]
                             forState:UIControlStateSelected];
    
    [sportBroadcastCheckBox setBackgroundImage:[UIImage imageNamed:@"1389999128_unchecked_checkbox.png"]
                               forState:UIControlStateNormal];
    [sportBroadcastCheckBox setBackgroundImage:[UIImage imageNamed:@"1389999143_checked_checkbox.png"]
                               forState:UIControlStateSelected];
    
    [liveMusicCheckBox setBackgroundImage:[UIImage imageNamed:@"1389999128_unchecked_checkbox.png"]
                                      forState:UIControlStateNormal];
    [liveMusicCheckBox setBackgroundImage:[UIImage imageNamed:@"1389999143_checked_checkbox.png"]
                                      forState:UIControlStateSelected];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source







/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     */
    
    if (indexPath.section==4 && indexPath.row==0) {
        //session tömb újratöltése kell!!!!!!
        
        UITabBarController *tabBar = [[UIStoryboard storyboardWithName:@"MainStoryboard_iPhone" bundle:nil] instantiateViewControllerWithIdentifier:@"mainMenuTabBar"];
        
        tabBar.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
        [self presentViewController: tabBar animated: YES completion:nil];

    }
    else if (indexPath.section==2 && indexPath.row==0){
        //picker megnyitása
        PickerForSearchView *PickerForSearchView=
        [self.storyboard instantiateViewControllerWithIdentifier:@"PickerForSearchView"];
        [self.navigationController pushViewController:PickerForSearchView animated:YES];
    }
}


- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

- (IBAction)danceCheck:(id)sender {
    danceSelected=!danceSelected;
    [danceCheckBox setSelected:danceSelected];
    
}

- (IBAction)liveMusicCheck:(id)sender {
    liveMusicSelected=!liveMusicSelected;
    [liveMusicCheckBox setSelected:liveMusicSelected];
}

- (IBAction)sportBoradcastCheck:(id)sender {
    sportBroadcastSelected=!sportBroadcastSelected;
    [sportBroadcastCheckBox setSelected:sportBroadcastSelected];
}

- (IBAction)snookerCheck:(id)sender {
    snookerSelected=!snookerSelected;
    [snookerCheckBox setSelected:snookerSelected];
}

- (IBAction)showActionSheet:(id)sender {
    UIActionSheet *popupQuery = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"Mégse"
                                              destructiveButtonTitle:nil otherButtonTitles:@"Közeli helyek",@"Kedvencek", @"Hozzáadás",@"Helyeim",@"Értesítések",@"Profilom",@"Kijelentkezés", nil];
    
    popupQuery.actionSheetStyle = UIActionSheetStyleBlackOpaque;
    [popupQuery showInView:[UIApplication sharedApplication].keyWindow];
    //popupQuery.frame = CGRectMake(0, [UIScreen mainScreen].bounds.size.height-popupQuery.frame.size.height, [UIScreen mainScreen].bounds.size.width, popupQuery.frame.size.height);
}


-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 0) {
        
        
        
        //lista frissitése közeli helyekre
        
        [[[Session getInstance]getSearchViewCLubs]removeAllObjects];
        NSString *lat=[NSString stringWithFormat:@"%f",locationManager.location.coordinate.latitude];
        NSString *lon=[NSString stringWithFormat:@"%f",locationManager.location.coordinate.longitude];
        
        
        //a meghívandó url string-be behegesztjük a kordinátákat
        NSString *urlstring=[NSString stringWithFormat:@"http://maps.googleapis.com/maps/api/geocode/json?latlng=%@,%@&sensor=false",lat,lon];
        
        //az url stringből létrehozunk egy urlt
        NSURL *url = [NSURL URLWithString:urlstring];
        
        //NSLog(@"%@",urlstring);
        
        //az url-ből visszakapunk egy egy json-t
        NSData *jsonData = [NSData dataWithContentsOfURL:url];
        NSError *error;
        
        //json-t átadjuk egy szótárnak
        NSDictionary *decoded= [NSJSONSerialization JSONObjectWithData:jsonData options:kNilOptions error:&error];
        
        NSString* address=[[[decoded objectForKey:@"results"]objectAtIndex:0]objectForKey:@"formatted_address"];
        [[Session getInstance]setUserLocation:address];
        
        NSLog(@"%@",[[[[[decoded objectForKey:@"results"]objectAtIndex:0]objectForKey:@"address_components"]objectAtIndex:2]objectForKey:@"long_name"]);
        
        NSString* cityName=[[[[[decoded objectForKey:@"results"]objectAtIndex:0]objectForKey:@"address_components"]objectAtIndex:2]objectForKey:@"long_name"];
        
        NSMutableArray * inputClubList = [[[Session getInstance] getCommunication] getClubsFromCityName:cityName];
        [[Session getInstance] setSearchViewCLubs:inputClubList];
        
        UITabBarController *tabBar = [[UIStoryboard storyboardWithName:@"MainStoryboard_iPhone" bundle:nil] instantiateViewControllerWithIdentifier:@"mainMenuTabBar"];
        
        tabBar.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
        [self presentViewController: tabBar animated: YES completion:nil];
        
        
        
    }
    
    if (buttonIndex == 1) {
        
        //lista frissitése kedvencek nézetre
        
        [[[Session getInstance]getSearchViewCLubs]removeAllObjects];
        NSInteger * user_id = [[[Session getInstance] getActualUser] getID];
        NSMutableArray * favoriteClubList = [[[Session getInstance] getCommunication] getFavoriteClubsFromUserId:user_id];
        [[Session getInstance] setSearchViewCLubs:favoriteClubList];
        
        UITabBarController *tabBar = [[UIStoryboard storyboardWithName:@"MainStoryboard_iPhone" bundle:nil] instantiateViewControllerWithIdentifier:@"mainMenuTabBar"];
        
        tabBar.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
        [self presentViewController: tabBar animated: YES completion:nil];
        
        
        
    } else if (buttonIndex == 2) {
        
        //új klubb hozzáadása nézet
        AddNewClubView *AddNewClubView=
        [self.storyboard instantiateViewControllerWithIdentifier:@"AddNewClubView"];
        [self presentViewController:AddNewClubView animated:YES completion:nil];
        
    } else if (buttonIndex == 3) {
        
        //lista frissítése saját helyekre
        [[[Session getInstance]getSearchViewCLubs]removeAllObjects];
        
        UITabBarController *tabBar = [[UIStoryboard storyboardWithName:@"MainStoryboard_iPhone" bundle:nil] instantiateViewControllerWithIdentifier:@"mainMenuTabBar"];
        
        tabBar.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
        [self presentViewController: tabBar animated: YES completion:nil];
        
        
        
        
    } else if (buttonIndex == 4) {
        
        //értesítések nézet
        NotificationsView *NotificationsView=
        [self.storyboard instantiateViewControllerWithIdentifier:@"NotificationsView"];
        
        UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:NotificationsView];
        [self presentViewController:navController animated:YES completion:nil];
        
    }
    else if (buttonIndex == 5) {
        
        //ugrás a profilom nézetbe
        ProfileTableView *ProfileTableView=
        [self.storyboard instantiateViewControllerWithIdentifier:@"ProfileTableView"];
        UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:ProfileTableView];
        [self presentViewController:navController animated:YES completion:nil];
    }
    else if (buttonIndex == 6) {
        
        //kijelentkezés
        [Session deleteSession];
        LoginView *LoginView=
        [self.storyboard instantiateViewControllerWithIdentifier:@"LoginView"];
        [self presentViewController:LoginView animated:YES completion:nil];
    }
    else if (buttonIndex == 7) {
        // NSLog(@"Mégse");
    }
}


@end