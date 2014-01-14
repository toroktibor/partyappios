//
//  CommunicationProtocol.h
//  bcsapat
//
//  Created by hallgato on 1/14/14.
//  Copyright (c) 2014 hallgato. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "User.h"

@protocol CommunicationProtocol <NSObject>
+(User *) authenticationUserWithNickName:(NSString *) nick_name andPassword:(NSString*) password;
@required
+(NSMutableArray *) getFavoriteClubsFromUserId:(NSInteger *) user_id;
+(NSMutableArray *) getClubsFromCityName:(NSString *) cityname;
//Elküld egy új hely kérelmet a szervernek, ha a owner_user_id -1 akkor nincs neki tulaj jelöltje
+(void) sendANewClubRequestWithClubname:(NSString *) newClubName andAddress: (NSString *) newClubAddress andType:(NSString *) newClubType andOwnerUserId:(NSInteger *) owner_user_id;
@end
