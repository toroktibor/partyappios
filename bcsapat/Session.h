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
}

+(void)deleteSession;

+(Session *) getInstance;

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





@end