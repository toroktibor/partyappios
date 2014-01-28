//
//  Session.h
//  bcsapat
//
//  Created by hallgato on 1/13/14.
//  Copyright (c) 2014 hallgato. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "User.h"
#import "SillyCommunication.h"
#import "MyDatabase.h"
#import "Club.h"

@interface Session : NSObject{
    SillyCommunication * actualCommunication;
    MyDatabase * databaseConnection;
    User * actualUser;
    NSMutableArray * searchViewCLubs;
    BOOL isOnline;
    int SelectedIndex;
    NSString * userLocation;
    NSString *clubTypeForPicker;
    int menuItemIndex;
    NSString *musicType;
    UIImage * image;
}

+(void)deleteSession;

+(Session *) getInstance;

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

-(SillyCommunication*)getCommunication;

-(NSMutableArray *) getSearchViewCLubs;
-(void) setSearchViewCLubs:(NSMutableArray *) inputClubsList;

-(void)setSelectedIndex:(int) index;

-(int)getSelectedIndex;

-(void)setUserLocation:(NSString *)location;

-(NSString *)getUserLocation;

-(void)setMusicType:(NSString *)music;

-(NSString *)getMusicType;

-(void)setImage:(UIImage *)pics;

-(UIImage *)getImage;



@end