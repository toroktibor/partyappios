//
//  Event.h
//  bcsapat
//
//  Created by hallgato on 1/13/14.
//  Copyright (c) 2014 hallgato. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Event : NSObject{
    int identifier;
    NSString * name;
    NSString * description;
    NSString * start_date;
    NSString * music_type;
    int approved;
}

- (id)initWithId:(int) identifier_ andName:(NSString *) name_ andDescription:(NSString *) description_ andStartDate:(NSString *) start_date_ andMusic_type:(NSString *) music_type_ andApproved:(int)approved_;

-(void) setIdentifier:(int) eventId;

-(void)setEventName:(NSString*)eventName;

-(void)setDescription:(NSString*)description_;

-(void)setStarDate:(NSString *)start;

-(void)setMusicType:(NSString *)musicType;

-(void)setApproved:(int)approved_;

-(int) getIdentifier;

-(NSString *)getEventName;

-(NSString *)getDescription;

-(NSString *)getStartDate;

-(NSString *)getMusicType;

-(int)getApproved;
@end
