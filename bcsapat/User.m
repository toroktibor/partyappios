//
//  User.m
//  bcsapat
//
//  Created by hallgato on 1/13/14.
//  Copyright (c) 2014 hallgato. All rights reserved.
//

#import "User.h"

@implementation User

- (id)initWithId:(NSInteger *) identifier_ andNickName:(NSString *) nick_name_ andPassword:(NSString *) password_ andEmail:(NSString *) email_ andSex:(NSInteger *) sex_ andBirthday:(NSString *) birthday_ andType:(NSInteger *) type_
{
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

-(void)setFavoriteClubs{
    
}

-(void)setUsersClubs{
    
}

-(NSString *)getName{
    return nick_name;
}

-(NSString *)getPassword{
    return password;
}

@end

