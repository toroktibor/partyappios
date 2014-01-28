//
//  Club.h
//  bcsapat
//
//  Created by hallgato on 1/13/14.
//  Copyright (c) 2014 hallgato. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Rating.h"

@interface Club : NSObject{
    int identifier;
    NSString * name;
    NSString * type;
    NSString * description;
    NSString * address;
    NSString * phonenumber;
    NSString * email;
    NSString * date;
    int approved;

    
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
-(NSString *) getAddress;
-(NSString *) getClubName;
-(NSString *) getEmail;
-(NSString *) getPhoneNumber;
-(NSString *) getDescription;


-(int)getApproved;

-(float)getAverageRating;



-(void)setOwnerIds;
-(void)setMenuItems:(NSMutableArray*) inMenuItems;
-(void)setRatings:(Rating *)rating_;
-(void)setEvents;
-(void)setServices;
-(void)setApproved:(int)approved_;
- (id)initWithId:(int) identifier_ andName:(NSString *) name_ andType:(NSString *) type_ andDescription:(NSString *) description_ andAddress:(NSString *) address_ andPhonenumber:(NSString *) phonenumber_ andEmail:(NSString *) email_ andDate:(NSString *) date_ andApproved:(int) approved_;


@end
