//
//  AdminRating.h
//  bcsapat
//
//  Created by hallgato on 1/29/14.
//  Copyright (c) 2014 hallgato. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AdminRating : NSObject{
    int userId;
    NSString * userName;
    float value;
    NSString * comment;
    int approved;
    int clubId;
    NSString * clubName;
}


-(NSString *)getuserName;

-(NSString *)getComment;

-(float)getValue;

-(int)getUserId;

-(int)getApproved;

-(int)getClubId;

-(NSString *)getClubName;

- (id)initWithUserID:(int) userID_ andUserName:(NSString *) userName_ andValue:(float) value_ andComment:(NSString *) comment_ andApproved:(int) approved_ andClubID:(int) clubID_ andClubName:(NSString *) clubname_;


@end
