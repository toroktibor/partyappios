//
//  CommunicationProtocol.h
//  bcsapat
//
//  Created by hallgato on 1/14/14.
//  Copyright (c) 2014 hallgato. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "User.h"
#import "Club.h"

@protocol CommunicationProtocol <NSObject>
@required
+(User *) authenticationUserWithNickName:(NSString *) nick_name andPassword:(NSString*) password;
@required
+(NSMutableArray *) getFavoriteClubsFromUserId:(int) user_id;
@required
+(NSMutableArray *) getClubsFromCityName:(int) cityname;
//Elküld egy új hely kérelmet a szervernek, ha a owner_user_id -1 akkor nincs neki tulaj jelöltje
@required
+(void) sendANewClubRequestWithClubname:(NSString *) newClubName andAddress: (NSString *) newClubAddress andType:(NSString *) newClubType andOwnerUserId:(NSInteger *) owner_user_id andServices:(NSString *) services;
@required
+(NSMutableArray *) getOwnedClubsFromUserId:(int) user_id;
@required
+(Club *) getEverythingFromClubId:(int) club_id;
@required
+(NSMutableArray *) searchClubsWithName:(NSString *) name andCityname:(NSString *) cityname andType:(NSString *) type andOffset:(NSInteger *) offset andLimit:(NSInteger *) limit;
@required
+(void) modifyPasswordWithId:(NSInteger *) id andPassword:(NSString *) password;
@required
+(void) modifyUserDataWithId:(NSInteger *) id andEmail:(NSString *) email andBirthday:(NSString *) birthday andSex:(NSInteger *) sex;
@end
