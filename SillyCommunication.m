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
#import "Club.h"
#import "Rating.h"

@implementation SillyCommunication{
    NSMutableArray * users;
    NSMutableArray * clubs;
}

- (id)init
{
    users = [[NSMutableArray alloc] init];
    User * auser = [[User alloc] initWithId:0 andNickName:@"a" andPassword:@"a" andEmail:@"a@a.com" andSex:0 andBirthday:@"1990.01.01" andType:1];
    [users addObject:auser];
    User * buser = [[User alloc] initWithId:0 andNickName:@"b" andPassword:@"b" andEmail:@"b@b.com" andSex:0 andBirthday:@"1991.01.01" andType:0];
    [users addObject:buser];
    User * cuser = [[User alloc] initWithId:0 andNickName:@"c" andPassword:@"c" andEmail:@"c@c.com" andSex:0 andBirthday:@"1992.01.01" andType:0];
    [users addObject:cuser];

    clubs = [[NSMutableArray alloc]init];
    Club * aclub = [[Club alloc] initWithId:0 andName:@"F@sz Kivan" andType:@"Kocsma" andDescription:@"Kicsit ideges vagyok mostmár!!!" andAddress:@"Debrecen, Kishegyesi utca 1" andPhonenumber:@"06306665556" andEmail:@"isten@f.a" andDate:@"2000.01.01" andApproved:1];
    Club * bclub = [[Club alloc] initWithId:1 andName:@"Almácska" andType:@"Elithely" andDescription:@"Kicsit sem igényes hely." andAddress:@"Debrecen, Miklós utca 10" andPhonenumber:@"06306665559" andEmail:@"isten@f.sza" andDate:@"2000.01.01" andApproved:0];
    Club * cclub = [[Club alloc] initWithId:2 andName:@"Le'Programozlak" andType:@"Elithely" andDescription:@"Kicsit sem igényes hely." andAddress:@"Debrecen, Piac utca 2" andPhonenumber:@"06306665559" andEmail:@"isten@f.sza" andDate:@"2000.01.01" andApproved:0];
    Club * dclub = [[Club alloc] initWithId:3 andName:@"Bp ugra-bugra" andType:@"Elithely" andDescription:@"Kicsit sem igényes hely." andAddress:@"Budapest, Petőfi utca 1" andPhonenumber:@"06306665559" andEmail:@"isten@f.sza" andDate:@"2000.01.01" andApproved:0];
    
   NSMutableArray * itemArray = [[NSMutableArray alloc] init];
    MenuItem * amenuItem = [[MenuItem alloc] initWithId:0 andName:@"Szar" andPrice:100 andCurrency:@"HUF" andUnit:@"liter" andDiscount:0 andMenuCategory:@"Desszert" andMenuSort:0];
    MenuItem * bmenuItem = [[MenuItem alloc] initWithId:1 andName:@"Szar1" andPrice:1000 andCurrency:@"HUF" andUnit:@"liter" andDiscount:0 andMenuCategory:@"Desszert" andMenuSort:0];
    MenuItem * cmenuItem = [[MenuItem alloc] initWithId:2 andName:@"Szar2" andPrice:500 andCurrency:@"HUF" andUnit:@"liter" andDiscount:0 andMenuCategory:@"Desszert" andMenuSort:0];
    [itemArray addObject:amenuItem];
    [itemArray addObject:bmenuItem];
    [itemArray addObject:cmenuItem];
    
    [aclub setMenuItems:itemArray];
    [cclub setMenuItems:itemArray];
    [bclub setMenuItems:itemArray];
    [dclub setMenuItems:itemArray];
    
    Rating *elso=[[Rating alloc]initWithUserName:@"Béla" andValue:3 andComment:@"Fasza hely! Jó volt itt bebaszni! Meg jók a csajok is! A pia meg ócsó!"];
    Rating *masodik=[[Rating alloc]initWithUserName:@"Józsi" andValue:5 andComment:@"Nagyon asza hely!"];
    Rating *harmadik=[[Rating alloc]initWithUserName:@"Béla" andValue:2 andComment:@"Fasza hely!"];
    Rating *negyedik=[[Rating alloc]initWithUserName:@"Józsi" andValue:4 andComment:@"Nagyon asza hely!"];
    Rating *otodik=[[Rating alloc]initWithUserName:@"Béla" andValue:2 andComment:@"Fasza hely!"];
    Rating *hatodik=[[Rating alloc]initWithUserName:@"Józsi" andValue:5 andComment:@"Nagyon asza hely!"];
    Rating *hetedik=[[Rating alloc]initWithUserName:@"Béla" andValue:1 andComment:@"Fasza hely!"];
    Rating *nyolcadik=[[Rating alloc]initWithUserName:@"Józsi" andValue:1 andComment:@"Nagyon asza hely!"];
    
    
    [aclub setRatings:elso];
    [aclub setRatings:masodik];
    
    [bclub setRatings:harmadik];
    [bclub setRatings:negyedik];
    
    [cclub setRatings:otodik];
    [cclub setRatings:hatodik];
    
    [dclub setRatings:hetedik];
    [dclub setRatings:nyolcadik];

    
 

    
    [clubs addObject:aclub];
    [clubs addObject:bclub];
    [clubs addObject:cclub];
    [clubs addObject:dclub];
    

    return self;
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
        Club * actualClub = [clubs objectAtIndex:index];
        if( [actualClub.getAddress hasPrefix:cityname]) {
            [out addObject:actualClub];
        }
    }
    return out;
}

-(NSMutableArray *)getFavoriteClubsFromUserId:(int)user_id {
    NSMutableArray * out = [[NSMutableArray alloc]init];
    if(user_id == 0){
        [out addObject:[clubs objectAtIndex:0]];
        [out addObject:[clubs objectAtIndex:1]];
    }
    return out;
}

-(NSMutableArray *)getOwnedClubsFromUserId:(int)user_id{
    NSMutableArray * out = [[NSMutableArray alloc]init];
    if(user_id == 0){
        [out addObject:[clubs objectAtIndex:2]];
        [out addObject:[clubs objectAtIndex:3]];
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
