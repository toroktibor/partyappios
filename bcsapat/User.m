//
//  User.m
//  bcsapat
//
//  Created by hallgato on 1/13/14.
//  Copyright (c) 2014 hallgato. All rights reserved.
//

#import "User.h"

@implementation User

- (id)initWithId:(int) identifier_ andNickName:(NSString *) nick_name_ andPassword:(NSString *) password_ andEmail:(NSString *) email_ andSex:(int) sex_ andBirthday:(NSString *) birthday_ andType:(int) type_{
    self = [super init];
    if(self)
    {
        identifier = identifier_;
        nick_name = nick_name_;
        password = password_;
        email = email_;
        sex = sex_;
        birthday = birthday_;
        type = type_;
    }
    return self;
}

-(NSMutableArray *) getFavoriteClubs{
    return favoriteClubs;
}

-(NSMutableArray *) getUsersClubs{
    return usersClubs;
}

-(void)setFavoriteClubs:(NSMutableArray *) inputFavoriteClubList{
    favoriteClubs = inputFavoriteClubList;
}

-(void)setUsersClubs:(NSMutableArray *)inputUsersClubList{
    usersClubs = inputUsersClubList;
}

-(void)setUsersClubs{
    
}

-(NSString *)getName{
    return nick_name;
}

-(NSString *)getPassword{
    return password;
}

-(int)getID{
    return identifier;
}

-(NSString *)getEmail{
    return email;
}

-(int)getSex{
    return sex;
}

-(NSString *)getBirthday{
    return birthday;
}

-(int)getType{
    return type;
}

-(void)setId:(int)userId{
    identifier=userId;
}

-(void)setName:(NSString *)userName{
    nick_name=userName;
}

-(void)setPassword:(NSString *)userPassword{
    password=userPassword;
}

-(void)setEmail:(NSString *)userEmail{
    email=userEmail;
}

-(void)setSex:(int)userSexType{
    sex=userSexType;
}

-(void)setBirthday:(NSString *)userBirthay{
    birthday=userBirthay;
}

-(void)setType:(int)userType{
    type=userType;
}

@end

