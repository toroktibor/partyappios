//
//  SillyCommunication.m
//  bcsapat
//
//  Created by hallgato on 1/14/14.
//  Copyright (c) 2014 hallgato. All rights reserved.
//

#import "SillyCommunication.h"
#import "User.h"
#import "MenuItem.h"

@implementation SillyCommunication{
    NSMutableArray * users;
    NSMutableArray * clubs;
}

- (id)init
{
    users = [[NSMutableArray alloc] init];
    User * auser = [[User alloc] initWithId:0 andNickName:@"a" andPassword:@"a" andEmail:@"a@a.com" andSex:0 andBirthday:@"1990.01.01" andType:0];
    [users addObject:auser];
    User * buser = [[User alloc] initWithId:0 andNickName:@"b" andPassword:@"b" andEmail:@"b@b.com" andSex:0 andBirthday:@"1991.01.01" andType:0];
    [users addObject:buser];
    User * cuser = [[User alloc] initWithId:0 andNickName:@"c" andPassword:@"c" andEmail:@"c@c.com" andSex:0 andBirthday:@"1992.01.01" andType:1];
    [users addObject:cuser];
    return self;
    
    clubs = [[NSMutableArray alloc]init];
    Club * aclub = [[Club alloc] initWithId:0 andName:@"F@sz Kivan" andType:@"Kocsma" andDescription:@"Kicsit ideges vagyok mostmár!!!" andAddress:@"Debrecen, Kishegyesi utca 49" andPhonenumber:@"06306665556" andEmail:@"isten@f.a" andDate:@"2000.01.01"];
    Club * bclub = [[Club alloc] initWithId:1 andName:@"Bebasz-Lak" andType:@"Elithely" andDescription:@"Kicsit sem igényes hely." andAddress:@"Debrecen, Kishegyesi utca 50" andPhonenumber:@"06306665559" andEmail:@"isten@f.sza" andDate:@"2000.01.01"];
    Club * cclub = [[Club alloc] initWithId:2 andName:@"Kivan" andType:@"Lokál" andDescription:@"Csúnya lesz!" andAddress:@"Budapest, Kishegyesi utca 56" andPhonenumber:@"06306365556" andEmail:@"isten@jozsi.a" andDate:@"2000.01.01"];
    
    NSMutableArray * itemArray = [[NSMutableArray alloc] init];
    MenuItem * amenuItem = [[MenuItem alloc] initWithId:0 andName:@"Szar" andPrice:100 andCurrency:@"HUF" andUnit:@"liter" andDiscount:0 andMenuCategory:@"Desszert" andMenuSort:0];
    MenuItem * bmenuItem = [[MenuItem alloc] initWithId:1 andName:@"Szar1" andPrice:1000 andCurrency:@"HUF" andUnit:@"liter" andDiscount:0 andMenuCategory:@"Desszert" andMenuSort:0];
    MenuItem * cmenuItem = [[MenuItem alloc] initWithId:2 andName:@"Szar2" andPrice:500 andCurrency:@"HUF" andUnit:@"liter" andDiscount:0 andMenuCategory:@"Desszert" andMenuSort:0];
    [itemArray addObject:amenuItem];
    [itemArray addObject:bmenuItem];
    [itemArray addObject:cmenuItem];
    
    [aclub setMenuItems:itemArray];
    
    [clubs addObject:aclub];
    [clubs addObject:bclub];
    [clubs addObject:cclub];
    
    
}

-(User *)authenticationUserWithNickName:(NSString *)nick_name andPassword:(NSString *)password {
    
    
    for (int i = 0; i<[users count]; i++) {
        NSInteger index = i;
        User * actualUser = [users objectAtIndex:index];
        if( [nick_name isEqualToString: [actualUser getName] ] && [password isEqualToString: [actualUser getPassword]]) {
            return actualUser;
        }
    }
    return nil;
}

-(void)sendANewClubRequestWithClubname:(NSString *)newClubName andAddress:(NSString *)newClubAddress andType:(NSString *)newClubType andOwnerUserId:(NSInteger *)owner_user_id {
    
}

-(NSMutableArray *)getClubsFromCityName:(NSString *)cityname {
    NSMutableArray * out = [[NSMutableArray alloc]init];
    for (int i = 0; i<[clubs count]; i++) {
        NSInteger index = i;
        User * actualClub = [clubs objectAtIndex:index];
        if( [actualClub.getName hasPrefix:cityname]) {
            [out addObject:actualClub];
        }
    }
    return out;
}

-(NSMutableArray *)getFavoriteClubsFromUserId:(NSInteger *)user_id {
    NSMutableArray * out = [[NSMutableArray alloc]init];
    if(user_id == 0){
        [out addObject:[clubs objectAtIndex:0]];
        [out addObject:[clubs objectAtIndex:1]];
    }
    return out;
}

-(NSMutableArray *)getOwnedClubsFromUserId:(NSInteger *)user_id{
    NSMutableArray * out = [[NSMutableArray alloc]init];
    if(user_id == 0){
        [out addObject:[clubs objectAtIndex:0]];
        [out addObject:[clubs objectAtIndex:1]];
    }
    return out;
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
