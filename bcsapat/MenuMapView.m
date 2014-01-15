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
    
    
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    MyAnnotation* myAnnotation=[[MyAnnotation alloc] init];
    
    for (int i=0; i<[cimek count]; ++i) {
        
        [geocoder geocodeAddressString:[cimek objectAtIndex:i] completionHandler:^(NSArray* placemarks, NSError* error){
            for (CLPlacemark* aPlacemark in placemarks)
            {
                CLLocationCoordinate2D theCoordinate;
                theCoordinate.latitude=aPlacemark.location.coordinate.latitude;
                theCoordinate.longitude=aPlacemark.location.coordinate.longitude;
                myAnnotation.coordinate=theCoordinate;
                [map addAnnotation:myAnnotation];
                NSLog(@"dsklja");
            }
        }];
        
    }
    
    
   
    
    
    
    /*[geocoder geocodeAddressString:@"Vásásrosnamény Orbán Balázs körút 11" completionHandler:^(NSArray* placemarks, NSError* error){
        for (CLPlacemark* aPlacemark in placemarks)
        {
            NSString *latDest1 = [NSString stringWithFormat:@"%f",aPlacemark.location.coordinate.latitude];
            NSString *lngDest2 = [NSString stringWithFormat:@"%f",aPlacemark.location.coordinate.longitude];
            NSLog(@"%@ geocoder",latDest1);
            NSLog(@"%@ geocoder",lngDest2);
        }
    }];*/
    
    
    
  /*

    NSMutableArray* annotations=[[NSMutableArray alloc] init];
	
	CLLocationCoordinate2D theCoordinate1;
    theCoordinate1.latitude = 37.786996;
    theCoordinate1.longitude = -122.419281;
	
	CLLocationCoordinate2D theCoordinate2;
    theCoordinate2.latitude = 37.810000;
    theCoordinate2.longitude = -122.477989;
	
	CLLocationCoordinate2D theCoordinate3;
    theCoordinate3.latitude = 37.760000;
    theCoordinate3.longitude = -122.447989;
	
	CLLocationCoordinate2D theCoordinate4;
    theCoordinate4.latitude = 37.80000;
    theCoordinate4.longitude = -122.407989;
    
    
    CLLocationCoordinate2D myLocation;
    myLocation.latitude=locationManager.location.coordinate.latitude;
    myLocation.longitude=locationManager.location.coordinate.longitude;
    
	
	MyAnnotation* myAnnotation1=[[MyAnnotation alloc] init];
	
	myAnnotation1.coordinate=theCoordinate1;
	myAnnotation1.title=@"Rohan";
	myAnnotation1.subtitle=@"in the city";
	
	MyAnnotation* myAnnotation2=[[MyAnnotation alloc] init];
	
	myAnnotation2.coordinate=theCoordinate2;
	myAnnotation2.title=@"Vaibhav";
	myAnnotation2.subtitle=@"on a Bridge";
	
	MyAnnotation* myAnnotation3=[[MyAnnotation alloc] init];
	
	myAnnotation3.coordinate=theCoordinate3;
	myAnnotation3.title=@"Rituraj";
	myAnnotation3.subtitle=@"in the forest";
	
	MyAnnotation* myAnnotation4=[[MyAnnotation alloc] init];
	
	myAnnotation4.coordinate=theCoordinate4;
	myAnnotation4.title=@"Sahil";
	myAnnotation4.subtitle=@"at Russian Hill";
    
    
   
	
	[map addAnnotation:myAnnotation1];
	[map addAnnotation:myAnnotation2];
	[map addAnnotation:myAnnotation3];
	[map addAnnotation:myAnnotation4];
    
    MKCoordinateRegion viewRegion = MKCoordinateRegionMakeWithDistance(myLocation, 400, 400);
    [map setRegion:viewRegion animated: YES];
    
   MKPointAnnotation *needle = [[MKPointAnnotation alloc] init];
    needle.coordinate = myLocation;
    needle.title = @"az én pozízcióm";
    needle.subtitle = @"bla bla";
    [map addAnnotation:needle];
    
    
	
	[annotations addObject:myAnnotation1];
	[annotations addObject:myAnnotation2];
	[annotations addObject:myAnnotation3];
	[annotations addObject:myAnnotation4];
   */
    
    
    
    
    
    
    //ha azt akarjuk, hogy a szórakozóhelyeket mutassa a térkép
   /*MKMapRect flyTo = MKMapRectNull;
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

@end
