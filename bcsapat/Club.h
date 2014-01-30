//
//  Club.h
//  bcsapat
//
//  Created by hallgato on 1/13/14.
//  Copyright (c) 2014 hallgato. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Rating.h"
#import "MenuItem.h"
#import "Event.h"

@interface Club : NSObject{
    int identifier;
    NSString * name;
    NSString * type;
    NSString * description;
    NSString * address;
    NSString * phonenumber;
    NSString * email;
    NSString * date;
    NSString * highlite_expire;
    int approved;
    
    BOOL fullDownloaded;
    
    NSString * ownerName;
    
    NSMutableArray * menuItems;
    NSMutableArray * ratings;
    NSMutableArray * events;
    NSMutableArray * services;
    NSMutableArray * images;
}


-(NSMutableArray *) getOwnerIds;
-(NSMutableArray *) getMenuItems;
-(NSMutableArray *) getRatings;
-(NSMutableArray *) getEvents;
-(NSMutableArray *) getServices;

-(NSString *) getAddress;
-(void) setAddress:(NSString *) a;
-(NSString *) getClubName;
-(void) setClubName:(NSString *) a;
-(NSString *) getEmail;
-(void) setEmail:(NSString *) a;
-(NSString *) getPhoneNumber;
-(void) setPhoneNumber:(NSString *) a;
-(NSString *) getDescription;
-(void) setDescription:(NSString *) a;


-(int)getIdentifier;

-(void)addEvent:(Event *)event;
-(Event *)getEventAtIndex:(int)index;

-(int)getApproved;

-(float)getAverageRating;

-(void)addMenuItem:(MenuItem *)menuItem;


-(void)setOwnerIds;
-(void)setMenuItems:(NSMutableArray*) inMenuItems;
-(void)setRatings:(NSArray *)rating_;
-(void)setEvents;
-(void)setServices;
-(void)setApproved:(int)approved_;

- (id)initWithId:(int) identifier_ andName:(NSString *) name_ andAddress:(NSString *) address_;
- (id)initWithId:(int) identifier_ andName:(NSString *) name_ andAddress:(NSString *) address_ andApproved:(int)approved_;
- (id)initWithId:(int) identifier_ andName:(NSString *) name_ andAddress:(NSString *) address_ andApproved:(int)approved_ andHighliteExpire:(NSString *) highlite_expire_ ;
- (id)initWithId:(int) identifier_ andName:(NSString *) name_ andType:(NSString *) type_ andDescription:(NSString *) description_ andAddress:(NSString *) address_ andPhonenumber:(NSString *) phonenumber_ andEmail:(NSString *) email_ andDate:(NSString *) date_ andHighliteExpire:(NSString *) highlite_expire_ andApproved:(int)approved_;

- (id)initWithId:(int) identifier_ andName:(NSString *) name_ andType:(NSString *) type_ andDescription:(NSString *) description_ andAddress:(NSString *) address_ andPhonenumber:(NSString *) phonenumber_ andEmail:(NSString *) email_  andHighliteExpire:(NSString *) highlite_expire_ andApproved:(int)approved_;

- (id)initWithId:(int) identifier_ andName:(NSString *) name_ andType:(NSString *) type_ andDescription:(NSString *) description_ andAddress:(NSString *) address_ andPhonenumber:(NSString *) phonenumber_ andEmail:(NSString *) email_  andHighliteExpire:(NSString *) highlite_expire_ andApproved:(int)approved_ andServices:(NSArray *)services_;

-(BOOL)isNotFullDownloaded;
-(Rating *) isRatingThisUser:(int) userId;


@end
