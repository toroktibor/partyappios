//
//  Rating.m
//  bcsapat
//
//  Created by hallgato on 1/13/14.
//  Copyright (c) 2014 hallgato. All rights reserved.
//

#import "Rating.h"

@implementation Rating

- (id)initWithUserName:(NSString *) userName_ andValue:(float) value_ andComment:(NSString *) comment_{
    self = [super init];
    if(self)
    {
        userName = userName_;
        value = value_*2;
        comment = comment_;
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

@end
