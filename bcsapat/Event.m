//
//  Event.m
//  bcsapat
//
//  Created by hallgato on 1/13/14.
//  Copyright (c) 2014 hallgato. All rights reserved.
//

#import "Event.h"

@implementation Event


- (id)initWithId:(NSInteger *) identifier_ andName:(NSString *) name_ andDescription:(NSString *) description_ andStartDate:(NSString *) start_date_ andMusic_type:(NSString *) music_type_
{
    self = [super init];
    if(self)
    {
        identifier = identifier_;
        name = name_;
        description = description_;
        start_date = start_date_;
        music_type = music_type_;
    }
    return self;
}

@end
