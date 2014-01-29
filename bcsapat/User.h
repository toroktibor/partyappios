//
//  User.h
//  bcsapat
//
//  Created by hallgato on 1/13/14.
//  Copyright (c) 2014 hallgato. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Club.h"

@interface User : NSObject{
    int  identifier;
    NSString * nick_name;
    NSString * password;
    NSString * email;
    int sex;  // 0 = Férfi 1 = Nő
    NSString * birthday;
    int type;  // 0 = vendég vagy tulaj 1 = admin
    
    NSMutableArray * favoriteClubs;
    NSMutableArray * usersClubs;
}

- (id)initWithId:(int) identifier_ andNickName:(NSString *) nick_name_ andPassword:(NSString *) password_ andEmail:(NSString *) email_ andSex:(int) sex_ andBirthday:(NSString *) birthday_ andType:(int) type_;

-(BOOL) isThisUserOwnerOfClub:(int)clubId;

-(void) modifyUserWithEmail:(NSString *) email_ andBirthday:(NSString *) birthday_ andSex:(int) sex_;

-(void) modifyPassword:(NSString *) password_;

-(BOOL) isLike:(int) clubId;

-(NSMutableArray *) getFavoriteClubs;
-(NSMutableArray *) getUsersClubs;

-(void)setFavoriteClubs:(NSMutableArray *) inputFavoriteClubList;
-(void)setUsersClubs:(NSMutableArray *) inputUsersClubList;

-(NSString *) getName;
-(NSString *) getPassword;
-(int) getID;
-(NSString *) getEmail;
-(int) getType;
-(NSString *) getBirthday;
-(int) getSex;

-(void)setId:(int)userId;
-(void)setName:(NSString *)userName;
-(void)setPassword:(NSString *)userPassword;
-(void)setEmail:(NSString *)userEmail;
-(void)setSex:(int)userSexType;
-(void)setBirthday:(NSString *)userBirthay;
-(void)setType:(int)userType;

-(void)addFavoriteClub:(Club*)club;
-(BOOL)isInFavorite:(int)identifier_;
-(void)printFavoriteClusbId;



@end
