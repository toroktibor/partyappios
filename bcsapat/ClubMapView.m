//
//  ClubMapView.m
//  bcsapat
//
//  Created by hallgato on 1/22/14.
//  Copyright (c) 2014 hallgato. All rights reserved.
//

#import "ClubMapView.h"
#import "Session.h"
#import "Club.h"
#import "MyAnnotation.h"

@interface ClubMapView ()

@end

@implementation ClubMapView
@synthesize index,map;

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
    
    index=[[Session getInstance]getSelectedIndex];
    Club * club=[[Session getInstance]getSelectedClubAtIndex:index];
    
    
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    [geocoder geocodeAddressString:[club getAddress] completionHandler:^(NSArray* placemarks, NSError* error){
        for (CLPlacemark* aPlacemark in placemarks)
        {
            CLLocationCoordinate2D theCoordinate;
            
            theCoordinate.latitude=aPlacemark.location.coordinate.latitude;
            theCoordinate.longitude=aPlacemark.location.coordinate.longitude;
            
            
            MyAnnotation *annotation=[[MyAnnotation alloc]init];
            annotation.coordinate=theCoordinate;
            annotation.title=[club getClubName];
            annotation.subtitle=[club getAddress];
            annotation.approved=[club getApproved];

          
         
            MKCoordinateRegion viewRegion = MKCoordinateRegionMakeWithDistance(theCoordinate, 5000, 5000);
            [map setRegion:viewRegion animated: YES];
            
            [map addAnnotation:annotation];
        }
    }];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (MKAnnotationView *) mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>) annotation
{
    MKPinAnnotationView *newAnnotation = [[MKPinAnnotationView alloc]     initWithAnnotation:annotation reuseIdentifier:@"pinLocation"];
    
    newAnnotation.canShowCallout = YES;
    
 
    newAnnotation.pinColor = MKPinAnnotationColorPurple;


    return newAnnotation;
    
}


@end
