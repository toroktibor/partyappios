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

@interface Session : NSObject{
    SillyCommunication * actualCommunication;
    MyDatabase * databaseConnection;
    User * actualUser;
    NSMutableArray * searchViewCLubs;
    BOOL * isOnline;
}

+(Session *) instance;

@end