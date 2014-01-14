//
//  Session.m
//  bcsapat
//
//  Created by hallgato on 1/13/14.
//  Copyright (c) 2014 hallgato. All rights reserved.
//

#import "Session.h"

@implementation Session

-(Session *)getInstance{
    if (instance == nil) {
        instance = [[Session alloc] init];
    }
    return instance;
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

@end
