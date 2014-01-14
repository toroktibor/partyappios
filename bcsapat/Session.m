//
//  Session.m
//  bcsapat
//
//  Created by hallgato on 1/13/14.
//  Copyright (c) 2014 hallgato. All rights reserved.
//

#import "Session.h"

@implementation Session

static Session * _instance = nil;

-(Session *)getInstance{
    if (_instance == nil) {
        _instance = [[Session alloc] init];
    }
    return _instance;
}

-(User *)getActualUser{
    return actualUser;
}

-(void)setActualUser:(User *) user{
    actualUser = user;
}

-(NSMutableArray *) getSearchViewCLubs{
    return searchViewCLubs;
}

-(void)setSearchViewCLubs:(NSMutableArray *) searchViewCLubs_{
    searchViewCLubs = searchViewCLubs_;
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
        //id appdelegate = [[UIApplication sharedApplication] delegate];
        //m_managedObjectContext = [appdelegate managedObjectContext];
        databaseConnection = [[MyDatabase alloc] initWithPath: @"partyapp.db"];
        actualCommunication = [[SillyCommunication alloc] init];
    }
    return self;
}


@end
