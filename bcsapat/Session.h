//
//  Session.h
//  bcsapat
//
//  Created by hallgato on 1/13/14.
//  Copyright (c) 2014 hallgato. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "User.h"
#import "Communication.h"
#import "MyDatabase.h"
#import "Club.h"
#import "GaleryImage.h"
#import "Base64.h"

@interface Session : NSObject{
    Communication * actualCommunication;
    MyDatabase * databaseConnection;
    User * actualUser;
    NSMutableArray * searchViewCLubs;
    BOOL isOnline;
    int SelectedIndex;
    NSString * userLocation;
    NSString *clubTypeForPicker;
    int menuItemIndex;
    NSString *musicType;
    int image;
    int selectedRating;
    NSString * menuItemCategory;
    int selectedEvent;
    NSString * eventTime;
    NSString *birthday;

}

+(void)deleteSession;

+(Session *) getInstance;

-(void)setBirthDay:(NSString*)birthday_;

-(NSString *)getBirthday;

-(void)setEventTime:(NSString*)time;

-(NSString *)getEventTime;

-(void)setSelectedEventIndex:(int)index;

-(int)getSelectedEventIndex;

-(void)setMenuItemCategory:(NSString *)category;

-(NSString *)getMenuItemCategory;

-(void)setSelectedRatingIndex:(int)index;

-(int)getSelectedRatingIndex;

-(void)setMenuItemIndex:(int)itemIndex;

-(int)getMenuItemIndex;

-(void)setClubTypeForPicer:(NSString *)picker;

-(NSString *)getClubTypeForPicker;

-(User *)getActualUser;

-(void)setActualUser:(User*) user;

-(void)addClub:(Club*) club;

-(Club*)getSelectedClubAtIndex:(int) index;

-(BOOL)isNetworAvaiable;

-(MyDatabase*)getDatabse;

-(void)setDatabase;

-(void)logArray;

-(void)testAddString:(NSString*)string;

-(void)checkArray;

-(Communication*)getCommunication;

-(NSMutableArray *) getSearchViewCLubs;
-(void) setSearchViewCLubs:(NSMutableArray *) inputClubsList;

-(void)setSelectedIndex:(int) index;

-(int)getSelectedIndex;

-(void)setUserLocation:(NSString *)location;

-(NSString *)getUserLocation;

-(void)setMusicType:(NSString *)music;

-(NSString *)getMusicType;

-(void)setImage:(int)pics;

-(int)getImage;



@end