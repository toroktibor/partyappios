//
//  MyAnnotation.h
//  bcsapat
//
//  Created by hallgato on 1/15/14.
//  Copyright (c) 2014 hallgato. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface MyAnnotation : NSObject<MKAnnotation>{
    CLLocationCoordinate2D coordinate;
    NSString * title;
    NSString * subtitle;
    int approved;
}

@property (nonatomic,assign) CLLocationCoordinate2D coordinate;
@property (nonatomic,copy) NSString * title;
@property (nonatomic, copy) NSString * subtitle;
@property int approved;

-(NSString*)getTitle;
-(CLLocationCoordinate2D)getCoordinate;
-(int)getApproved;


@end
