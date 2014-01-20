//
//  SillyCommunication.m
//  bcsapat
//
//  Created by hallgato on 1/14/14.
//  Copyright (c) 2014 hallgato. All rights reserved.
//

#import "SillyCommunication.h"

@implementation SillyCommunication

-(User *)authenticationUserWithNickName:(NSString *)nick_name andPassword:(NSString *)password {
    
    if( [nick_name isEqualToString: @"a" ] && [password isEqualToString: @"a"]) {
        return [[User alloc] initWithId: 0 andNickName:@"a" andPassword:@"a" andEmail:@"a@a.com" andSex:1 andBirthday: @"1991.01.01." andType:0 ];
    }
    else
        return nil;
}

-(void)sendANewClubRequestWithClubname:(NSString *)newClubName andAddress:(NSString *)newClubAddress andType:(NSString *)newClubType andOwnerUserId:(NSInteger *)owner_user_id {
    
}

-(NSMutableArray *)getClubsFromCityName:(NSString *)cityname {
    return nil;
}

-(NSMutableArray *)getFavoriteClubsFromUserId:(NSInteger *)user_id {
    return nil;
}

-(NSMutableArray *)getOwnedClubsFromUserId:(NSInteger *)user_id{
    return nil;
}

-(void)modifyPasswordWithId:(NSInteger *)id andPassword:(NSString *)password{
    
}

-(void)modifyUserDataWithId:(NSInteger *)id andEmail:(NSString *)email andBirthday:(NSString *)birthday andSex:(NSInteger *)sex{
    
}

-(NSMutableArray *)searchClubsWithName:(NSString *)name andCityname:(NSString *)cityname andType:(NSString *)type andOffset:(NSInteger *)offset andLimit:(NSInteger *)limit{
    return nil;
}

-(Club *)getEverythingFromClubId:(NSInteger *)club_id{
    return nil;
}

@end
