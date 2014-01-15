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

@interface MenuMapView ()



@end

@implementation MenuMapView
@synthesize map;



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
    
    NSMutableArray * cimek=[[NSMutableArray alloc]init];
    [cimek addObject:@"Debrecen Szombathi István utca 3"];
    [cimek addObject:@"Debrecen Csapó utca 15"];
    [cimek addObject:@"Debrecen Piac utca 2"];
    [cimek addObject:@"Debrecen Miklós utca 20"];
    
    NSMutableArray * annotations=[[NSMutableArray alloc]init];
    
    for (int i=0; i<[cimek count]; ++i) {
        [map addAnnotation:[self getCoordinates:[cimek objectAtIndex:i]]];
        [annotations addObject:[self getCoordinates:[cimek objectAtIndex:i]]];
    }
    
    
    MKMapRect zoomRect = MKMapRectNull;
    for (id <MKAnnotation> annotation in map.annotations)
    {
        MKMapPoint annotationPoint = MKMapPointForCoordinate(map.userLocation.coordinate);
        MKMapRect pointRect = MKMapRectMake(annotationPoint.x, annotationPoint.y, 0.1, 0.1);
        zoomRect = MKMapRectUnion(zoomRect, pointRect);
    }
    [map setVisibleMapRect:zoomRect animated:YES];

    //ha azt akarjuk, hogy a szórakozóhelyeket mutassa a térkép
  /* MKMapRect flyTo = MKMapRectNull;
	for (id annotation  in annotations) {
		NSLog(@"fly to on");
        MKMapPoint annotationPoint = MKMapPointForCoordinate([annotation coordinate]);
        MKMapRect pointRect = MKMapRectMake(annotationPoint.x, annotationPoint.y, 0, 0);
        if (MKMapRectIsNull(flyTo)) {
            flyTo = pointRect;
        } else {
            flyTo = MKMapRectUnion(flyTo, pointRect);
        }
    }
    
    map.visibleMapRect = flyTo;*/
    

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
        FavouritesView *FavouritesView=
        [self.storyboard instantiateViewControllerWithIdentifier:@"FavouritesView"];
        
        UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:FavouritesView];
        [self presentViewController:navController animated:YES completion:nil];
        
        
        
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
        
        UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:ProfileFirstView];
        [self presentViewController:navController animated:YES completion:nil];
    }
    else if (buttonIndex == 5) {
        
        //kijelentkezés
        LoginView *LoginView=
        [self.storyboard instantiateViewControllerWithIdentifier:@"LoginView"];
        [self presentViewController:LoginView animated:YES completion:nil];
    }
    else if (buttonIndex == 6) {
        // mégse gomb
    }
}




-(MyAnnotation *)getCoordinates:(NSString*)adress{
    MyAnnotation* myAnnotation=[[MyAnnotation alloc] init];
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    [geocoder geocodeAddressString:adress completionHandler:^(NSArray* placemarks, NSError* error){
        for (CLPlacemark* aPlacemark in placemarks)
        {
            CLLocationCoordinate2D theCoordinate;
            theCoordinate.latitude=aPlacemark.location.coordinate.latitude;
            theCoordinate.longitude=aPlacemark.location.coordinate.longitude;
            myAnnotation.coordinate=theCoordinate;
        }
    }];

    return myAnnotation;
}


@end
