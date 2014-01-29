//
//  OwnerRequest.h
//  bcsapat
//
//  Created by Remek Elek on 29/01/14.
//  Copyright (c) 2014 hallgato. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Club.h"
#import "User.h"

@interface OwnerRequest : NSObject{
    Club* club;
    User* user;
}

-(id) initWithClub:(Club *) club_ andUser:(User *) user_;

-(void) setClub: (Club*) club_;

-(void) setUser: (User*) user_;

-(Club *) getClub;

-(User *) getUser;
@end
