//
//  User.h
//  bcsapat
//
//  Created by hallgato on 1/13/14.
//  Copyright (c) 2014 hallgato. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface User : NSObject{
    NSInteger * identifier;
    NSString * nick_name;
    NSString * password;
    NSString * email;
    NSInteger * sex;
    NSString * birthday;
    NSInteger * type;
    
    NSMutableArray * favoriteClubs;
    NSMutableArray * usersClubs;
}

- (id)initWithId:(NSInteger *) identifier_ andNickName:(NSString *) nick_name_ andPassword:(NSString *) password_ andEmail:(NSString *) email_ andSex:(NSInteger *) sex_ andBirthday:(NSString *) birthday_ andType:(NSInteger *) type_;

-(NSMutableArray *) getFavoriteClubs;
-(NSMutableArray *) getUsersClubs;

-(void)setFavoriteClubs;
-(void)setUsersClubs;

@end
