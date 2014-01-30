//
//  Club.m
//  bcsapat
//
//  Created by hallgato on 1/13/14.
//  Copyright (c) 2014 hallgato. All rights reserved.
//

#import "Club.h"

@implementation Club

- (id)initWithId:(int) identifier_ andName:(NSString *) name_ andType:(NSString *) type_ andDescription:(NSString *) description_ andAddress:(NSString *) address_ andPhonenumber:(NSString *) phonenumber_ andEmail:(NSString *) email_ andDate:(NSString *) date_ andHighliteExpire:(NSString *) highlite_expire_ andApproved:(int)approved_
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
        highlite_expire = highlite_expire_;
        approved=approved_;
        fullDownloaded = NO;
        ratings = [[NSMutableArray alloc]init];
        images = [[NSMutableArray alloc]init];
    }
    return self;
}

- (id)initWithId:(int) identifier_ andName:(NSString *) name_ andType:(NSString *) type_ andDescription:(NSString *) description_ andAddress:(NSString *) address_ andPhonenumber:(NSString *) phonenumber_ andEmail:(NSString *) email_  andHighliteExpire:(NSString *) highlite_expire_ andApproved:(int)approved_{
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
        highlite_expire = highlite_expire_;
        approved=approved_;
        fullDownloaded = NO;
        ratings = [[NSMutableArray alloc]init];
        images = [[NSMutableArray alloc]init];
    }
    return self;
    
}

- (id)initWithId:(int) identifier_ andName:(NSString *) name_ andType:(NSString *) type_ andDescription:(NSString *) description_ andAddress:(NSString *) address_ andPhonenumber:(NSString *) phonenumber_ andEmail:(NSString *) email_  andHighliteExpire:(NSString *) highlite_expire_ andApproved:(int)approved_ andServices:(NSArray *)services_{
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
        highlite_expire = highlite_expire_;
        approved=approved_;
        services=[[NSMutableArray alloc]initWithArray:services_];
        fullDownloaded = NO;
        ratings = [[NSMutableArray alloc]init];
        images = [[NSMutableArray alloc]init];
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
        fullDownloaded = NO;
        ratings = [[NSMutableArray alloc]init];
        images = [[NSMutableArray alloc]init];
    }
    return self;
}

- (id)initWithId:(int) identifier_ andName:(NSString *) name_ andAddress:(NSString *) address_ andApproved:(int)approved_{
    self = [super init];
    if(self)
    {
        identifier = identifier_;
        name = name_;
        address = address_;
        approved = approved_;
        fullDownloaded = NO;
        ratings = [[NSMutableArray alloc]init];
        images = [[NSMutableArray alloc]init];
    }
    return self;
}

- (id)initWithId:(int) identifier_ andName:(NSString *) name_ andAddress:(NSString *) address_ andApproved:(int)approved_ andHighliteExpire:(NSString *) highlite_expire_ {
    self = [super init];
    if(self)
    {
        identifier = identifier_;
        name = name_;
        address = address_;
        approved = approved_;
        highlite_expire = highlite_expire_;
        fullDownloaded = NO;
        ratings = [[NSMutableArray alloc]init];
        images = [[NSMutableArray alloc]init];
    }
    return self;
}

-(BOOL)isNotFullDownloaded{
    return !fullDownloaded;
}



-(Rating *) isRatingThisUser:(int) userId {
    if(ratings == nil || [ratings count] ==0)
    	return nil;
	for (Rating *rating in ratings) {
	    if ([rating getUserId] == userId)
            return rating;
	}
	return nil;
}



-(int)getIdentifier{
    return identifier;
}

-(float)getAverageRating{
    float sum=0;
    if ([ratings count] == 0) {
        return 0;
    }else {
        for (int i=0; i<[ratings count]; ++i) {
            Rating *actualRating=[ratings objectAtIndex:i];
            sum+=[actualRating getValue];
        }
     return (sum/[ratings count])/10;
    }
}

-(void)addEvent:(Event *)event{
    [events addObject:event];
}

-(Event *)getEventAtIndex:(int)index{
    return [events objectAtIndex:index];
}

-(void)addMenuItem:(MenuItem *)menuItem{
    if((NSNull *) menuItems == [NSNull null]){
        menuItems = [[NSMutableArray alloc] initWithObjects:menuItem, nil];
    }
    [menuItems addObject:menuItem];
}

-(NSMutableArray *) getOwnerName{
    return ownerName;
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

-(NSMutableArray *) getImages{
    return images;
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


-(void)setRatings:(NSArray *)rating_{
    ratings =rating_;
}


-(void)setEvents{
    
}

-(void)setServices{
    
}

-(void)setClubName:(NSString *) name_{
    name = name_;
}

-(void)setDescription:(NSString *) description_{
    description = description_;
}

-(void)setAddress:(NSString *) address_{
    address = address_;
}

-(void)setEmail:(NSString *) email_{
    email = email_;
}

-(void)setPhoneNumber:(NSString *) phonenumber_ {
    phonenumber = phonenumber_;
}




@end
