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
        menuItems=[[NSMutableArray alloc]init];
        events=[[NSMutableArray alloc]init];
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

-(int)getIdentifier{
    return identifier;
}

-(float)getAverageRating{
    float sum=0;
    for (int i=0; i<[ratings count]; ++i) {
        Rating *actualRating=[ratings objectAtIndex:i];
        sum+=actualRating.getValue;
    }
    return (sum/[ratings count])/10;
}

-(void)addEvent:(Event *)event{
    [events addObject:event];
}

-(Event *)getEventAtIndex:(int)index{
    return [events objectAtIndex:index];
}

-(void)addMenuItem:(MenuItem *)menuItem{
    [menuItems addObject:menuItem];
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

-(void)setRatings:(Rating *)rating_{
    [ratings addObject:rating_];
}


-(void)setEvents{
    
}

-(void)setServices{
    
}


//public void downloadEverything() {
//	Log.i(this.getClass().getName(), "Minden infó lekérése a klubról ( " + id + " )");
//    
//	Club clubWithAllInfo = Session.getInstance().getActualCommunicationInterface().getEverythingFromClub(this.id);
//	this.email = clubWithAllInfo.email;
//	this.date = clubWithAllInfo.date;
//	this.description = clubWithAllInfo.description;
//	this.phonenumber = clubWithAllInfo.phonenumber;
//	this.approved = clubWithAllInfo.approved;
//	this.type = clubWithAllInfo.type;
//	this.highlite_expire = clubWithAllInfo.highlite_expire;
//    
//	this.events = Session.getInstance().getActualCommunicationInterface().getEventsOfClub(this.id);
//	Log.i(getClass().getName(), "Klub eseményei: " + this.events.size());
//    
//	this.menuItems = Session.getInstance().getActualCommunicationInterface().getMenuItemsForClub(this.id);
//	this.ratings = Session.getInstance().getActualCommunicationInterface().getRatings(this.id);
//	
//	this.images.clear();
//	ArrayList<Integer> imageIDList = Session.getInstance().getActualCommunicationInterface()
//    .selectClubsImagesIds(this.id);
//	for (int i = 0; i < imageIDList.size(); i++) {
//	    Log.e("galery", "i: " + i);
//	    this.images.add(new GaleryImage(imageIDList.get(i), (ImageUtils.StringToBitMap(Session.getInstance()
//                                                                                       .getActualCommunicationInterface().DownLoadAnImageThumbnail(imageIDList.get(i))))));
//	}
//    
//	Log.i(this.getClass().getName(), "Klub adatai frissítve ( " + id + " )");
//	fullDownloaded=true;
//}

@end
