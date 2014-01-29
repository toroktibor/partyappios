//
//  AdminRating.m
//  bcsapat
//
//  Created by hallgato on 1/29/14.
//  Copyright (c) 2014 hallgato. All rights reserved.
//

#import "AdminRating.h"

@implementation AdminRating

- (id)initWithUserID:(int) userID_ andUserName:(NSString *) userName_ andValue:(float) value_ andComment:(NSString *) comment_ andApproved:(int) approved_ andClubID:(int) clubID_ andClubName:(NSString *) clubname_{
    self = [super init];
    if(self)
    {
        userId = userID_;
        userName = userName_;
        value = value_*2;
        comment = comment_;
        approved = approved_;
        clubId = clubID_;
        clubName = clubname_;
    }
    return self;
}

-(NSString *)getComment{
    return comment;
}

-(NSString *)getuserName{
    return userName;
}

-(float)getValue{
    return value;
}

-(int)getUserId{
    return userId;
}

-(int)getApproved{
    return approved;
}

-(int)getClubId{
    return clubId;
}

-(NSString *)getClubName{
    return clubName;
}

@end
