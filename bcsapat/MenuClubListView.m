//
//  MenuClubListView.m
//  bcsapat
//
//  Created by hallgato on 1/10/14.
//  Copyright (c) 2014 hallgato. All rights reserved.
//

#import "MenuClubListView.h"
#import "NotificationsView.h"
#import "LoginView.h"
#import "InformationView.h"
#import "Session.h"
#import "ProfileTableView.h"
#import "AddNewClubTableView.h"
#import "AdminTableView.h"

@interface MenuClubListView ()

@end

@implementation MenuClubListView


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
    
    [[[self navigationController] navigationBar] setTintColor:[UIColor colorWithRed:(60/255.0) green:(60/255.0) blue:(100/255.0) alpha:1.0]];
    
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bricskok.png"]];
    self.tableView.backgroundView = imageView;
    
    locationManager = [[CLLocationManager alloc] init];
    locationManager.delegate = self;
    locationManager.distanceFilter = kCLDistanceFilterNone;
    locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    [locationManager startUpdatingLocation];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    UIImage *tabBackground = [[UIImage imageNamed:@"tab_bar_mukodj2.png"]
                              resizableImageWithCapInsets:UIEdgeInsetsMake(0, 0, 0, 0)];
    [[UITabBar appearance] setBackgroundImage:tabBackground];
    
    

    
    [[UITabBar appearance] setSelectionIndicatorImage:
     [UIImage imageNamed:@"tab_select_indicator_white"]];
    [[UITabBar appearance] setSelectedImageTintColor:[UIColor whiteColor]];
    [[UITabBar appearance] setTintColor:[UIColor whiteColor]];
    
  [[UITabBarItem appearance] setTitleTextAttributes:
     [NSDictionary dictionaryWithObjectsAndKeys:
      [UIColor whiteColor], UITextAttributeTextColor,
      [UIFont fontWithName:@"" size:0.0], UITextAttributeFont,
      nil]
                                             forState:UIControlStateNormal];
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [[[Session getInstance]getSearchViewCLubs]count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"ClubListViewCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    
    UIView *customColorView = [[UIView alloc] init];
    customColorView.backgroundColor = [UIColor colorWithRed:154/255.0
                                                      green:111/255.0
                                                       blue:189/255.0
                                                      alpha:0.5];
    cell.selectedBackgroundView =  customColorView;
    
    
    cell.textLabel.textColor=[UIColor whiteColor];
    cell.detailTextLabel.textColor=[UIColor whiteColor];
    cell.textLabel.text=[[[[Session getInstance]getSearchViewCLubs]objectAtIndex:indexPath.row]getClubName];
    cell.detailTextLabel.text=[[[[Session getInstance]getSearchViewCLubs]objectAtIndex:indexPath.row]getAddress];
    cell.imageView.image=[UIImage imageNamed:@"2050-halloween-debrecen-halloween-napok-az-erdospuszta-club-hotelben.jpg"];
    
    
    
    UIImage *accessoryImage = [UIImage imageNamed:@"ic_action_next_item.png"];
    UIImageView *accImageView = [[UIImageView alloc] initWithImage:accessoryImage];
    accImageView.userInteractionEnabled = YES;
    [accImageView setFrame:CGRectMake(0, 0, 28.0, 28.0)];
    cell.accessoryView = accImageView;
    
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
    
    
   /* NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setInteger:selectedIndex forKey: @"selectedIndex"];
    [defaults synchronize];*/
    
    [[Session getInstance]setSelectedIndex:indexPath.row];
    
    
    UITabBarController *tabBar = [[UIStoryboard storyboardWithName:@"MainStoryboard_iPhone" bundle:nil] instantiateViewControllerWithIdentifier:@"ClubTabBar"];
    
    
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
    
    //user ág
    if ([[[Session getInstance]getActualUser]getType]==0) {

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

       else if (buttonIndex == 1) {
        

        //lista frissítése kedvencek nézetre
        [[[Session getInstance]getSearchViewCLubs]removeAllObjects];
        int user_id = [[[Session getInstance] getActualUser] getID];
        NSMutableArray * favoriteClubList = [[[Session getInstance] getCommunication] getFavoriteClubsFromUserId:user_id];
        [[Session getInstance] setSearchViewCLubs:favoriteClubList];
        
        UITabBarController *tabBar = [[UIStoryboard storyboardWithName:@"MainStoryboard_iPhone" bundle:nil] instantiateViewControllerWithIdentifier:@"mainMenuTabBar"];
        
        tabBar.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
        [self presentViewController: tabBar animated: YES completion:nil];
        
        
        
    }   else if (buttonIndex == 3) {
        //új klubb hozzáadása
        
        AddNewClubTableView *AddNewClubTableView=
        [self.storyboard instantiateViewControllerWithIdentifier:@"AddNewClubTableView"];
        UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:AddNewClubTableView];
        [self presentViewController:navController animated:YES completion:nil];
        
    }   else if (buttonIndex == 2) {
        
        //lista frissítése saját helyekre
         [[[Session getInstance]getSearchViewCLubs]removeAllObjects];
        
        int user_id = [[[Session getInstance] getActualUser] getID];
        NSMutableArray * ownClubList = [[[Session getInstance] getCommunication] getOwnedClubsFromUserId:user_id];
        [[Session getInstance] setSearchViewCLubs:ownClubList];
        
        
        UITabBarController *tabBar = [[UIStoryboard storyboardWithName:@"MainStoryboard_iPhone" bundle:nil] instantiateViewControllerWithIdentifier:@"mainMenuTabBar"];
        
        tabBar.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
        [self presentViewController: tabBar animated: YES completion:nil];
        
        
        
        
    }   else if (buttonIndex == 4) {
        
        //értesítések nézet
        NotificationsView *NotificationsView=
        [self.storyboard instantiateViewControllerWithIdentifier:@"NotificationsView"];
        
        UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:NotificationsView];
        [self presentViewController:navController animated:YES completion:nil];
        
    }
        else if (buttonIndex == 5) {
        
        //profilom nézet
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
    //admin ág
 else{
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
     
     else if (buttonIndex == 1) {
         
         
         //lista frissítése kedvencek nézetre
         [[[Session getInstance]getSearchViewCLubs]removeAllObjects];
         int user_id = [[[Session getInstance] getActualUser] getID];
         NSMutableArray * favoriteClubList = [[[Session getInstance] getCommunication] getFavoriteClubsFromUserId:user_id];
         [[Session getInstance] setSearchViewCLubs:favoriteClubList];
         
         UITabBarController *tabBar = [[UIStoryboard storyboardWithName:@"MainStoryboard_iPhone" bundle:nil] instantiateViewControllerWithIdentifier:@"mainMenuTabBar"];
         
         tabBar.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
         [self presentViewController: tabBar animated: YES completion:nil];
         
         
         
     }   else if (buttonIndex == 3) {
         //új klubb hozzáadása
         
         AddNewClubTableView *AddNewClubTableView=
         [self.storyboard instantiateViewControllerWithIdentifier:@"AddNewClubTableView"];
         UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:AddNewClubTableView];
         [self presentViewController:navController animated:YES completion:nil];
         
     }   else if (buttonIndex == 2) {
         
         //lista frissítése saját helyekre
         [[[Session getInstance]getSearchViewCLubs]removeAllObjects];
         
         int user_id = [[[Session getInstance] getActualUser] getID];
         NSMutableArray * ownClubList = [[[Session getInstance] getCommunication] getOwnedClubsFromUserId:user_id];
         [[Session getInstance] setSearchViewCLubs:ownClubList];
         
         
         UITabBarController *tabBar = [[UIStoryboard storyboardWithName:@"MainStoryboard_iPhone" bundle:nil] instantiateViewControllerWithIdentifier:@"mainMenuTabBar"];
         
         tabBar.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
         [self presentViewController: tabBar animated: YES completion:nil];
         
         
         
         
     }   else if (buttonIndex == 4) {
         
         //értesítések nézet
         NotificationsView *NotificationsView=
         [self.storyboard instantiateViewControllerWithIdentifier:@"NotificationsView"];
         
         UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:NotificationsView];
         [self presentViewController:navController animated:YES completion:nil];
         
     }
     else if (buttonIndex == 5) {
         
         //profilom nézet
         ProfileTableView *ProfileTableView=
         [self.storyboard instantiateViewControllerWithIdentifier:@"ProfileTableView"];
         UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:ProfileTableView];
         [self presentViewController:navController animated:YES completion:nil];
     }
     else if (buttonIndex == 6) {
         //Jóváhagyások
         
         AdminTableView *AdminTableView=
         [self.storyboard instantiateViewControllerWithIdentifier:@"AdminTableView"];
         UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:AdminTableView];
         [self presentViewController:navController animated:YES completion:nil];

     }
     else if (buttonIndex == 7) {
         //kijelentkezés
         
         [Session deleteSession];
         LoginView *LoginView=
         [self.storyboard instantiateViewControllerWithIdentifier:@"LoginView"];
         [self presentViewController:LoginView animated:YES completion:nil];
     }
     
     else if (buttonIndex == 8) {
         // mégse
     }
    }
}

//a navigation bar jobb felső sarkában lévő gomb megnyomására az action sheet megjelenítése
- (IBAction)showActionSheet:(id)sender {
    
    //admin action sheet
    if ([[[Session getInstance]getActualUser]getType]==1) {
        UIActionSheet *popupQuery = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"Mégse"
                                                  destructiveButtonTitle:nil otherButtonTitles:@"Közeli helyek",@"Kedvencek", @"Helyeim",@"Hely hozzáadása",@"Értesítések",@"Profilom",@"Jóváhagyások",@"Kijelentkezés", nil];
        
        popupQuery.actionSheetStyle = UIActionSheetStyleBlackOpaque;
        [popupQuery showInView:[UIApplication sharedApplication].keyWindow];
        popupQuery.frame = CGRectMake(0, [UIScreen mainScreen].bounds.size.height-popupQuery.frame.size.height, [UIScreen mainScreen].bounds.size.width, popupQuery.frame.size.height);
    }
    //user action sheet
    else{
        UIActionSheet *popupQuery = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"Mégse"
                                                  destructiveButtonTitle:nil otherButtonTitles:@"Közeli helyek",@"Kedvencek", @"Helyeim",@"Hely hozzáadása",@"Értesítések",@"Profilom",@"Kijelentkezés", nil];
        
        popupQuery.actionSheetStyle = UIActionSheetStyleBlackOpaque;
        [popupQuery showInView:[UIApplication sharedApplication].keyWindow];
        popupQuery.frame = CGRectMake(0, [UIScreen mainScreen].bounds.size.height-popupQuery.frame.size.height, [UIScreen mainScreen].bounds.size.width, popupQuery.frame.size.height);
    }
}
@end
