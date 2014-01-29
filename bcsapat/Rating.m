//
//  Rating.m
//  bcsapat
//
//  Created by hallgato on 1/13/14.
//  Copyright (c) 2014 hallgato. All rights reserved.
//

#import "Rating.h"

@implementation Rating

- (id)initWithUserID:(int) userID_ andName:(NSString *) userName_ andValue:(float) value_ andComment:(NSString *) comment_ andApproved:(int) approved_{
    self = [super init];
    if(self)
    {
        userId = userID_;
        userName = userName_;
        value = value_*2;
        comment = comment_;
        approved = approved_;
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

@end
