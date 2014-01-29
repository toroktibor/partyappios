//
//  Event.m
//  bcsapat
//
//  Created by hallgato on 1/13/14.
//  Copyright (c) 2014 hallgato. All rights reserved.
//

#import "Event.h"

@implementation Event


- (id)initWithId:(int) identifier_ andName:(NSString *) name_ andDescription:(NSString *) description_ andStartDate:(NSString *) start_date_ andMusic_type:(NSString *) music_type_ andApproved:(int)approved_
{
    self = [super init];
    if(self)
    {
        identifier = identifier_;
        name = name_;
        description = description_;
        start_date = start_date_;
        music_type = music_type_;
        approved=approved_;
    }
    return self;
}

-(void)setEventName:(NSString *)eventName{
    name=eventName;
}

-(void)setDescription:(NSString *)description_{
    description=description_;
}

-(void)setStarDate:(NSString *)start{
    start_date=start;
}

-(void)setMusicType:(NSString *)musicType{
    music_type=musicType;
}

-(void)setApproved:(int)approved_{
    approved=approved_;
}

-(NSString *)getEventName{
    return name;
}

-(NSString *)getDescription{
    return  description;
}

-(NSString *)getStartDate{
    return start_date;
}

-(NSString *)getMusicType{
    return music_type;
}

-(int)getApproved{
    return approved;
}
@end
