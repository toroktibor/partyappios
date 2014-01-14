//
//  Session.h
//  bcsapat
//
//  Created by hallgato on 1/13/14.
//  Copyright (c) 2014 hallgato. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "User.h"

@interface Session : NSObject{
    Session *instance;
    User * actualUser;
    NSMutableArray * searchViewCLubs;
}

@end
