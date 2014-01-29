//
//  Rating.h
//  bcsapat
//
//  Created by hallgato on 1/13/14.
//  Copyright (c) 2014 hallgato. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Rating : NSObject{
    int userId;
    NSString * userName;
    float value;
    NSString * comment;
    int approved;
}


-(NSString *)getuserName;

-(NSString *)getComment;

-(float)getValue;

-(int)getUserId;

-(int)getApproved;

- (id)initWithUserID:(int) userID_ andName:(NSString *) userName_ andValue:(float) value_ andComment:(NSString *) comment_ andApproved:(int) approved_;

@end
