//
//  SillyCommunication.m
//  bcsapat
//
//  Created by hallgato on 1/14/14.
//  Copyright (c) 2014 hallgato. All rights reserved.
//

#import "SillyCommunication.h"

@implementation SillyCommunication

+(User *)authenticationUserWithNickName:(NSString *)nick_name andPassword:(NSString *)password {
    
    if( [nick_name isEqualToString: @"a" ] && [password isEqualToString: @"a"]) {
        return [[User alloc] initWithId: 1 andNickName:@"a" andPassword:@"a" andEmail:@"a@a.com" andSex:1 andBirthday: @"1991.01.01." andType: 1 ];
    }
    else
        return nil;
}

+(void)sendANewClubRequestWithClubname:(NSString *)newClubName andAddress:(NSString *)newClubAddress andType:(NSString *)newClubType andOwnerUserId:(NSInteger *)owner_user_id {
    
}

+(NSMutableArray *)getClubsFromCityName:(NSString *)cityname {
    
}

+(NSMutableArray *)getFavoriteClubsFromUserId:(NSInteger *)user_id {
    
}



@end
