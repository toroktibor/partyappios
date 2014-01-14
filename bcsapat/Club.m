//
//  Club.m
//  bcsapat
//
//  Created by hallgato on 1/13/14.
//  Copyright (c) 2014 hallgato. All rights reserved.
//

#import "Club.h"

@implementation Club

- (id)initWithId:(NSInteger *) identifier_ andName:(NSString *) name_ andType:(NSString *) type_ andDescription:(NSString *) description_ andAddress:(NSString *) address_ andPhonenumber:(NSString *) phonenumber_ andEmail:(NSString *) email_ andDate:(NSString *) date_
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
    }
    return self;
}


- (id)initWithId:(NSInteger *) identifier_ andName:(NSString *) name_ andAddress:(NSString *) address_{
    self = [super init];
    if(self)
    {
        identifier = identifier_;
        name = name_;
        address = address_;
    }
    return self;
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



-(void)setOwnerIds{
    
}

-(void)setMenuItems{
    
}

-(void)setRatings{
    
}

-(void)setEvents{
    
}

-(void)setServices{
    
}


@end
