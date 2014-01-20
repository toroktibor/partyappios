//
//  MenuMapView.m
//  bcsapat
//
//  Created by hallgato on 1/10/14.
//  Copyright (c) 2014 hallgato. All rights reserved.
//

#import "MenuMapView.h"
#import "ProfileFirstView.h"
#import "NotificationsView.h"
#import "FavouritesView.h"
#import "MyPlacesView.h"
#import "LoginView.h"
#import "AddNewClubView.h"
#import "MyAnnotation.h"
#import "Session.h"

@interface MenuMapView ()



@end

@implementation MenuMapView
@synthesize map,initialLocation;



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
    
    [map setDelegate:self];
    
    map.showsUserLocation=YES;
    
    
    /*CLLocationCoordinate2D userlocation;
    userlocation.latitude = locationManager.location.coordinate.latitude;
    userlocation.longitude = locationManager.location.coordinate.longitude;
    
    MKCoordinateRegion viewRegion = MKCoordinateRegionMakeWithDistance(userlocation, 600, 600);
    [map setRegion:viewRegion animated: YES];*/

    
    
    NSMutableArray * cimek=[[NSMutableArray alloc]init];
    [cimek addObject:@"Debrecen Szombathi István utca 3"];
    [cimek addObject:@"Debrecen Csapó utca 15"];
    [cimek addObject:@"Debrecen Piac utca 2"];
    [cimek addObject:@"Debrecen Miklós utca 20"];
    [cimek addObject:@"Debrecen Kishegyesi út 20"];
    
    
    for (int i=0; i<[cimek count]; ++i) {
        [self processProperties:[cimek objectAtIndex:i]];
    }
   


}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




//a navigation bar jobb felső sarkában lévő gomb megnyomására az action sheet megjelenítése
- (IBAction)showActionSheet:(id)sender {
    UIActionSheet *popupQuery = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"Mégse"
                                              destructiveButtonTitle:nil otherButtonTitles:@"Kedvencek", @"Hozzáadás",@"Helyeim",@"Értesítések",@"Profilom",@"Kijelentkezés", nil];
    
    popupQuery.actionSheetStyle = UIActionSheetStyleBlackOpaque;
    [popupQuery showInView:[UIApplication sharedApplication].keyWindow];
    popupQuery.frame = CGRectMake(0, [UIScreen mainScreen].bounds.size.height-popupQuery.frame.size.height, [UIScreen mainScreen].bounds.size.width, popupQuery.frame.size.height);
}


//action sheet gombjai váltanak a nézetek között
-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 0) {
        
        //ugrás a kedvencek nézetbe
        /*FavouritesView *FavouritesView=
        [self.storyboard instantiateViewControllerWithIdentifier:@"FavouritesView"];
        
        UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:FavouritesView];
        [self presentViewController:navController animated:YES completion:nil];*/
        
        [[[Session getInstance]getSearchViewCLubs]removeAllObjects];
        [[Session getInstance]testAddString:@"Ibolya"];
        
        UITabBarController *tabBar = [[UIStoryboard storyboardWithName:@"MainStoryboard_iPhone" bundle:nil] instantiateViewControllerWithIdentifier:@"mainMenuTabBar"];
        
        tabBar.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
        [self presentViewController: tabBar animated: YES completion:nil];
        
        
        
    } else if (buttonIndex == 1) {
        
        //ugrás az új klubb hozzáadása nézetbe
        AddNewClubView *AddNewClubView=
        [self.storyboard instantiateViewControllerWithIdentifier:@"AddNewClubView"];
        
        [self presentViewController:AddNewClubView animated:YES completion:nil];
        
    } else if (buttonIndex == 2) {
        
        //ugrás a helyeim nézetbe
        MyPlacesView *MyPlacesView=
        [self.storyboard instantiateViewControllerWithIdentifier:@"MyPlacesView"];
        
        UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:MyPlacesView];
        [self presentViewController:navController animated:YES completion:nil];
        
        
        
        
    } else if (buttonIndex == 3) {
        
        //ugrás a helyeim nézetbe
        NotificationsView *NotificationsView=
        [self.storyboard instantiateViewControllerWithIdentifier:@"NotificationsView"];
        
        UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:NotificationsView];
        [self presentViewController:navController animated:YES completion:nil];
        
    }
    else if (buttonIndex == 4) {
        
        //ugrás a profilom nézetbe
        ProfileFirstView *ProfileFirstView=
        [self.storyboard instantiateViewControllerWithIdentifier:@"ProfileFirstView"];
        
        [self presentViewController:ProfileFirstView animated:YES completion:nil];
    }
    else if (buttonIndex == 5) {
        
        //kijelentkezés
        [Session deleteSession];
        LoginView *LoginView=
        [self.storyboard instantiateViewControllerWithIdentifier:@"LoginView"];
        [self presentViewController:LoginView animated:YES completion:nil];
    }
    else if (buttonIndex == 6) {
        // mégse gomb
    }
}



- (void)processProperties:(NSString *)property {
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    [geocoder geocodeAddressString:property completionHandler:^(NSArray* placemarks, NSError* error){
        for (CLPlacemark* aPlacemark in placemarks)
        {
            CLLocationCoordinate2D theCoordinate;
            theCoordinate.latitude=aPlacemark.location.coordinate.latitude;
            theCoordinate.longitude=aPlacemark.location.coordinate.longitude;
            MyAnnotation *annotation=[[MyAnnotation alloc]init];
            annotation.coordinate=theCoordinate;
            annotation.title=property;
            [map addAnnotation:annotation];
        }
    }];

}

- (void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation
{
    if ( !initialLocation )
    {
        self.initialLocation = userLocation.location;
        
        MKCoordinateRegion region;
        region.span = MKCoordinateSpanMake(0.15, 0.2);
        region.center = mapView.userLocation.coordinate;
        //region.span = MKCoordinateSpanMake(0.1, 0.1);
        
         region = [mapView regionThatFits:region];
        [mapView setRegion:region animated:YES];
     
    }
}




@end
