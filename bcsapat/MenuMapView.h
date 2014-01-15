//
//  MenuMapView.h
//  bcsapat
//
//  Created by hallgato on 1/10/14.
//  Copyright (c) 2014 hallgato. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>

@interface MenuMapView : UIViewController<UIActionSheetDelegate,MKMapViewDelegate>



@property (weak, nonatomic) IBOutlet MKMapView *map;
- (IBAction)showActionSheet:(id)sender;
@end
