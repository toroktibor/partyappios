//
//  Communication.h
//  bcsapat
//
//  Created by hallgato on 1/22/14.
//  Copyright (c) 2014 hallgato. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CommunicationProtocol.h"
#import "OwnerRequest.h"
#import "AdminRating.h"

@interface Communication : NSObject

-(NSData*) httpPost: (NSString *) file withData: (NSMutableDictionary *) data;
-(User *) authenticationUserWithNickName:(NSString *) nick_name andPassword:(NSString*) password;
-(NSMutableArray *) getFavoriteClubsFromUserId:(int) user_id;
-(NSMutableArray *) getClubsFromCityName:(NSString *) cityname;
-(void) sendANewClubRequestWithClubname:(NSString *) newClubName andAddress: (NSString *) newClubAddress andType:(NSString *) newClubType andOwnerUserId:(NSInteger *) owner_user_id andServices:(NSString *) services;
-(NSMutableArray *) getOwnedClubsFromUserId:(int) user_id;
-(Club *) getEverythingFromClubId:(int) club_id;
-(NSMutableArray *) searchClubsWithName:(NSString *) name andCityname:(NSString *) cityname andType:(NSString *) type andOffset:(int ) offset andLimit:(int) limit;
-(void) modifyPasswordWithId:(int) id andPassword:(NSString *) password;
-(void) modifyUserDataWithId:(int) id andEmail:(NSString *) email andBirthday:(NSString *) birthday andSex:(int) sex;
-(User *) registerANewUserWithName:(NSString *) name andPassword:(NSString *) password andEmail:(NSString *)  email andSex:(int) sex andBirthday:(NSString *) birthday;
-(void) setServisesWithClubID:(int) club_id andServices:(NSArray *) services;
-(void) setOwnerForClubWithUserID:(int) user_id andClubID:(int) club_id;
-(void) setFavoriteClubForUserWithUserID:(int) user_id andClubID:(int) club_id;
-(void) deleteFavoriteClub:(int) club_id forUser:(int) user_id;
-(NSMutableArray *) getNotApprovedClubs;
-(void) approveClubWithClubId: (int) club_id;
-(void) declineNewClubWithClubId: (int) club_id;
-(void) declineOwnerRequestWithClubId: (int) club_id andUserId: (int) user_id;
-(void) acceptOwnerRequestWithClubId: (int) club_id andUserId: (int) user_id;
-(NSMutableArray *) getNotApprovedOwnerRequest;
-(int) addANewMenuItemWithClubId: (int) clubid andMenuItem: (MenuItem *) menuItem;
-(NSMutableArray *) getMenuItemsForClubWithClubId:(int) club_id;
-(void) updateAMenuItemWithMenuItem:(MenuItem *) menuItem;
-(void) removeEMenuItemWithMenuId:(int) menuId;
-(NSMutableArray *) getEventsOfClubWithEventId:(int) eventId;
-(int) addEventWithClubID:(int) clubid andName:( NSString*) name andDescription:( NSString*) description andStartDate:( NSString*) start_date andRowImage:( NSString*) row_image andType:( NSString*) music_type ;
- (void) updateEventWithID:(int) eventid andName: (NSString *) name andDescription:( NSString*) description andStartDate:( NSString*) start_date andRowImage:( NSString*) row_image andType:( NSString*) music_type ;
-(void) deleteEventWithID:(int) eventId ;
- (int) addRatingWithClubID:(int) clubId andUserID:(int) userId andValue:(float) value andComment:(NSString *) comment ;
-(void) updateRatingWithClubID:(int) clubId andUserID:(int) userId andValue:(float) value andComment:(NSString *) comment ;
-(NSArray *) getRatingsFromClubID:(int) clubId ;
-(NSArray *) getNotApprovedRatings ;
-(void)declineRatingWithUserId:(int) userId andClubId:(int) clubId ;
-(void) acceptRatingWithUserId:(int) userId andClubId:(int) clubId ;
-(void) deleteClubWithId:(int) clubId ;
-(void) updateClubInfoWithId:(int) clubId andName:(NSString *) name andType:(NSString*) type andDescription:(NSString *) description andAddress:(NSString *) address andPhonenumber:(NSString *) phonenumber andEmail:(NSString *) email ;
-(NSString *)setHighlightExpireWithClubId:(int) clubId andDays:(int) days ;
-(int) uploadAnImageWithClubId:(int) clubId andRowImage:(NSString*) rowImage andRotate:(int) rotate;
-(NSString *) downLoadAnImageWithId:(int) imageId;
-(NSMutableArray *) selectClubsImagesIdsWithClubId:(int) clubId;
-(NSString*) downLoadAnImageThumbnailWithImageId:(int) imageId;
@end
