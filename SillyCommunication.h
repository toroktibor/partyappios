//
//  SillyCommunication.h
//  bcsapat
//
//  Created by hallgato on 1/14/14.
//  Copyright (c) 2014 hallgato. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CommunicationProtocol.h"
#import "Rating.h"

@interface SillyCommunication : NSObject <CommunicationProtocol>

-(User *)authenticationUserWithNickName:(NSString *)nick_name andPassword:(NSString *)password;
-(NSMutableArray *)getClubsFromCityName:(NSString *)cityname;
-(NSMutableArray *)getFavoriteClubsFromUserId:(int)user_id;
-(NSMutableArray *)getOwnedClubsFromUserId:(int)user_id;

@end
