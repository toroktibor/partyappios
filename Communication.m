//
//  Communication.m
//  bcsapat
//
//  Created by hallgato on 1/22/14.
//  Copyright (c) 2014 hallgato. All rights reserved.
//

#import "Communication.h"

@implementation Communication

-(id)init{
    
}

-(User *) authenticationUserWithNickName:(NSString *) nick_name andPassword:(NSString*) password{
    
}

-(NSMutableArray *) getFavoriteClubsFromUserId:(NSInteger *) user_id{
    
}

-(NSMutableArray *) getClubsFromCityName:(NSString *) cityname{
    
}


//Elküld egy új hely kérelmet a szervernek, ha a owner_user_id -1 akkor nincs neki tulaj jelöltje
-(void) sendANewClubRequestWithClubname:(NSString *) newClubName andAddress: (NSString *) newClubAddress andType:(NSString *) newClubType andOwnerUserId:(NSInteger *) owner_user_id andServices:(NSString *) services{
    
}

-(NSMutableArray *) getOwnedClubsFromUserId:(NSInteger *) user_id{
    
}

-(Club *) getEverythingFromClubId:(NSInteger *) club_id{
    
}

-(NSMutableArray *) searchClubsWithName:(NSString *) name andCityname:(NSString *) cityname andType:(NSString *) type andOffset:(NSInteger *) offset andLimit:(NSInteger *) limit{
    
}

-(void) modifyPasswordWithId:(NSInteger *) id andPassword:(NSString *) password{
    
}

-(void) modifyUserDataWithId:(NSInteger *) id andEmail:(NSString *) email andBirthday:(NSString *) birthday andSex:(NSInteger *) sex{
    
}

-(void) registerANewUserWithName:(NSString *) name andPassword:(NSString *) password andEmail:(NSString *)  email andSex:(NSInteger *) sex andBirthday:(NSString *) birthday{
    
}

-(void) setServisesWithClubID:(NSInteger *) club_id andServices:(NSString *) services{
    
}

-(void) setOwnerForClubWithUserID:(NSInteger *) user_id andClubID:(NSInteger *) club_id{
    
}

-(void) setFavoriteClubForUserWithUserID:(NSInteger *) user_id andClubID:(NSInteger *) club_id{
    
}

-(void) deleteFavoriteClubForUserWithFavoriteID:(NSInteger *) favorite_id{
    
}

@end