//
//  Club.h
//  bcsapat
//
//  Created by hallgato on 1/13/14.
//  Copyright (c) 2014 hallgato. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Club : NSObject{
    NSInteger * identifier;
    NSString * name;
    NSString * type;
    NSString * description;
    NSString * address;
    NSString * phonenumber;
    NSString * email;
    NSString * date;

    
    NSMutableArray * ownerIds;
    
    NSMutableArray * menuItems;
    NSMutableArray * ratings;
    NSMutableArray * events;
    NSMutableArray * services;
}

-(NSMutableArray *) getOwnerIds;
-(NSMutableArray *) getMenuItems;
-(NSMutableArray *) getRatings;
-(NSMutableArray *) getEvents;
-(NSMutableArray *) getServices;

-(void)setOwnerIds;
-(void)setMenuItems;
-(void)setRatings;
-(void)setEvents;
-(void)setServices;


@end
