//
//  MyAnnotation.m
//  bcsapat
//
//  Created by hallgato on 1/15/14.
//  Copyright (c) 2014 hallgato. All rights reserved.
//

#import "MyAnnotation.h"

@implementation MyAnnotation

@synthesize coordinate,subtitle,title,approved;


-(NSString *)getTitle{
    return self.title;
}

-(CLLocationCoordinate2D)getCoordinate{
    return self.coordinate;
}

-(int)getApproved{
    return approved;
}
@end
