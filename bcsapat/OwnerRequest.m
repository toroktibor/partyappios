//
//  OwnerRequest.m
//  bcsapat
//
//  Created by Remek Elek on 29/01/14.
//  Copyright (c) 2014 hallgato. All rights reserved.
//

#import "OwnerRequest.h"

@implementation OwnerRequest

-(id) initWithClub:(Club *) club_ andUser:(User *) user_{
    self = [super init];
    if(self){
        user = user_;
        club = club_;
    }
    return self;
}

-(void) setClub: (Club*) club_{
    club=club_;
}

-(void) setUser: (User*) user_{
    user=user_;
}

-(Club *) getClub{
    return club;
}

-(User *) getUser{
    return user;
}

@end
