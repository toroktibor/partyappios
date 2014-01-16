//
//  MenuClubListView.m
//  bcsapat
//
//  Created by hallgato on 1/10/14.
//  Copyright (c) 2014 hallgato. All rights reserved.
//

#import "MenuClubListView.h"
#import "ProfileFirstView.h"
#import "NotificationsView.h"
#import "FavouritesView.h"
#import "MyPlacesView.h"
#import "LoginView.h"
#import "AddNewClubView.h"
#import "InformationView.h"

@interface MenuClubListView ()

@end

@implementation MenuClubListView
@synthesize szh;

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
    
    
    szh = [[NSArray alloc] initWithObjects:@"Ibolya", @"Bárka", @"Roncs",nil];
    
    //locationmanager a saját helyem meghatározásához
    locationManager = [[CLLocationManager alloc] init];
    locationManager.delegate = self;
    locationManager.distanceFilter = kCLDistanceFilterNone;
    locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    [locationManager startUpdatingLocation];
    
    
    //location managerből kiszedjük a kordinátákat
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
    
   NSLog(@"%@",[[[[[decoded objectForKey:@"results"]objectAtIndex:0]objectForKey:@"address_components"]objectAtIndex:2]objectForKey:@"long_name"]);
   


    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [szh count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    cell.textLabel.text=[szh objectAtIndex:indexPath.row];
    
    return cell;
}

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
    

    NSString *selected=[szh objectAtIndex:indexPath.row];
    
    
    UITabBarController *tabBar = [[UIStoryboard storyboardWithName:@"MainStoryboard_iPhone" bundle:nil] instantiateViewControllerWithIdentifier:@"TabBar"];
    
    
    tabBar.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    [self presentViewController: tabBar animated: YES completion:nil];
    
    
    
    /*NSString *selected=[szh objectAtIndex:indexPath.row];
    
    UIAlertView * alertview = [[UIAlertView alloc] initWithTitle:@"Selected!"
                                                         message:selected
                                                        delegate:nil
                                               cancelButtonTitle:@"Ok"
                                               otherButtonTitles: nil];
    
    [alertview show];*/

}



//action sheet gombjai váltanak a nézetek között
-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 0) {
        
        FavouritesView *FavouritesView=
        [self.storyboard instantiateViewControllerWithIdentifier:@"FavouritesView"];
        
        UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:FavouritesView];
        [self presentViewController:navController animated:YES completion:nil];
        
        
        
    } else if (buttonIndex == 1) {
        AddNewClubView *AddNewClubView=
        [self.storyboard instantiateViewControllerWithIdentifier:@"AddNewClubView"];
        
        [self presentViewController:AddNewClubView animated:YES completion:nil];
        
    } else if (buttonIndex == 2) {
        
        
        MyPlacesView *MyPlacesView=
        [self.storyboard instantiateViewControllerWithIdentifier:@"MyPlacesView"];
        
        UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:MyPlacesView];
        [self presentViewController:navController animated:YES completion:nil];
        
        
        
        
    } else if (buttonIndex == 3) {
        
        NotificationsView *NotificationsView=
        [self.storyboard instantiateViewControllerWithIdentifier:@"NotificationsView"];
        
        UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:NotificationsView];
        [self presentViewController:navController animated:YES completion:nil];
        
    }
    else if (buttonIndex == 4) {
        
        ProfileFirstView *ProfileFirstView=
        [self.storyboard instantiateViewControllerWithIdentifier:@"ProfileFirstView"];
        
        UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:ProfileFirstView];
        //[self.navigationController pushViewController:ProfileFirstView animated:YES];
        //[self presentModalViewController:ProfileFirstView animated:YES];
        [self presentViewController:navController animated:YES completion:nil];
    }
    else if (buttonIndex == 5) {
        LoginView *LoginView=
        [self.storyboard instantiateViewControllerWithIdentifier:@"LoginView"];
        [self presentViewController:LoginView animated:YES completion:nil];
    }
    else if (buttonIndex == 6) {
        // NSLog(@"Mégse");
    }
}

//a navigation bar jobb felső sarkában lévő gomb megnyomására az action sheet megjelenítése
- (IBAction)showActionSheet:(id)sender {
    UIActionSheet *popupQuery = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"Mégse"
                                              destructiveButtonTitle:nil otherButtonTitles:@"Kedvencek", @"Hozzáadás",@"Helyeim",@"Értesítések",@"Profilom",@"Kijelentkezés", nil];
    
    popupQuery.actionSheetStyle = UIActionSheetStyleBlackOpaque;
    [popupQuery showInView:[UIApplication sharedApplication].keyWindow];
    popupQuery.frame = CGRectMake(0, [UIScreen mainScreen].bounds.size.height-popupQuery.frame.size.height, [UIScreen mainScreen].bounds.size.width, popupQuery.frame.size.height);
}
@end
