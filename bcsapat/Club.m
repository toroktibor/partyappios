//
//  Club.m
//  bcsapat
//
//  Created by hallgato on 1/13/14.
//  Copyright (c) 2014 hallgato. All rights reserved.
//

#import "Club.h"

@implementation Club

- (id)initWithId:(int) identifier_ andName:(NSString *) name_ andType:(NSString *) type_ andDescription:(NSString *) description_ andAddress:(NSString *) address_ andPhonenumber:(NSString *) phonenumber_ andEmail:(NSString *) email_ andDate:(NSString *) date_ andApproved:(int)approved_
{
    self = [super init];
    if(self)
    {
        identifier = identifier_;
        name = name_;
        type = type_;
        description = description_;
        address = address_;
        phonenumber = phonenumber_;
        email = email_;
        date = date_;
        approved=approved_;
        ratings=[[NSMutableArray alloc]init];
    }
    return self;
}


- (id)initWithId:(int) identifier_ andName:(NSString *) name_ andAddress:(NSString *) address_{
    self = [super init];
    if(self)
    {
        identifier = identifier_;
        name = name_;
        address = address_;
    }
    return self;
}

-(void)addRating:(float)rating{
    NSNumber * number=[NSNumber numberWithFloat:rating];
    [ratings addObject:number];
}

-(float)getRatingNumber{
    float sum=0;
    for (int i=0; i<[ratings count]; ++i) {
        NSNumber * rating=[ratings objectAtIndex:i];
        sum+=[rating floatValue];
    }
    
    return (sum/[ratings count])/10;
}

-(NSMutableArray *) getOwnerIds{
    return ownerIds;
}

-(NSMutableArray *) getMenuItems{
    return menuItems;
}

-(NSMutableArray *) getRatings{
    return ratings;
}

-(NSMutableArray *) getEvents{
    return events;
}
-(NSMutableArray *) getServices{
    return services;
}
-(NSString *)getAddress{
    return address;
}

-(NSString *)getClubName{
    return name;
}

-(NSString *)getEmail{
    return email;
}

-(NSString *)getPhoneNumber{
    return phonenumber;
}

-(NSString *)getDescription{
    return description;
}

-(int)getApproved{
    return approved;
}

-(void)setApproved:(int)approved_{
    approved=approved_;
}

-(void)setOwnerIds{
    
}

-(void)setMenuItems:(NSMutableArray*) inMenuItems;{
    menuItems = inMenuItems;
}

-(void)setRatings{
    
}

-(void)setEvents{
    
}

-(void)setServices{
    
}


@end
