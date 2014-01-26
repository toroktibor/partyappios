//
//  ClubMapView.h
//  bcsapat
//
//  Created by hallgato on 1/22/14.
//  Copyright (c) 2014 hallgato. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@interface ClubMapView : UIViewController<MKMapViewDelegate>
@property (weak, nonatomic) IBOutlet MKMapView *map;
@property int index;
@end
