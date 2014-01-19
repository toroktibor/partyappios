//
//  Session.m
//  bcsapat
//
//  Created by hallgato on 1/13/14.
//  Copyright (c) 2014 hallgato. All rights reserved.
//

#import "Session.h"
#import "User.h"
#import "MyDatabase.h"


@implementation Session

static Session * _instance = nil;

+(Session *)getInstance{
    if (_instance == nil) {
        _instance = [[Session alloc] init];
        return _instance;
    }
    return nil;
}

-(User *)getActualUser{
    return actualUser;
}

-(void)setActualUser:(User *)user{
    actualUser = user;
}

-(NSMutableArray *) getSearchViewCLubs{
    return searchViewCLubs;
}

-(void)addClub:(Club *)club{
    [searchViewCLubs addObject:club];
}

-(Club*)getSelectedClubAtIndex:(int)index{
    return [searchViewCLubs objectAtIndex:index];
}


+(id)alloc {
    @synchronized([Session class]) {
        NSAssert(_instance == nil, @"oops... Mar van ilyen peldany");
        _instance = [super alloc];
        return _instance;
    }
    return nil;
}

-(id)init {
    if (self = [super init]) {
        databaseConnection = [[MyDatabase alloc] initWithPath: @"partyapp.db"];
        actualCommunication = [[SillyCommunication alloc] init];
        searchViewCLubs = [[NSMutableArray alloc]init];
    }
    return self;
}


@end
