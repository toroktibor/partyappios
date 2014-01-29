//
//  Communication.m
//  bcsapat
//
//  Created by hallgato on 1/22/14.
//  Copyright (c) 2014 hallgato. All rights reserved.
//

#import "Communication.h"


@implementation Communication

NSString * mainUrl = @"http://partyapp.bugs3.com/";
NSError *error;

enum requestTypeEnum {
    LOGIN,FAVORITE,OWNED,EVERYTHING,NEWCLUB,SEARCHCLUB,UPDATEPASSWORD,UPDATEUSER,NEWUSER,SETSERVICE,SETOWNER,SETFAVORITE,DELETEFAVORITE
};

enum requestTypeEnum requestType = -1;


-(NSString*) httpPost: (NSString *) file withData: (NSMutableDictionary *) data{
    NSMutableString *post = [NSMutableString string];
    for (NSString* key in [data allKeys]){
        if ([post length]>0)
            [post appendString:@"&"];
        [post appendFormat:@"%@=%@", key, [data objectForKey:key]];
    }
    /*  */
    NSLog(@"POST: %@", post);
    
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@", mainUrl, file ]];
    NSLog(@"URL: %@", url);
    
    NSData *postData = [post dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES];
    NSString *postLength = [NSString stringWithFormat:@"%d",[postData length]];
    
    NSMutableURLRequest * request = [[NSMutableURLRequest alloc] init];
    
    [request setURL:url];
    
    [request setHTTPMethod:@"POST"];
        
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    
    [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Current-Type"];
    
    [request setHTTPBody:postData];
    
    NSLog(@"request: %@",request);

    NSHTTPURLResponse *response = nil;
    NSError *error = [[NSError alloc] init];
    NSString *urlData=[NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    
    
    return urlData;
}

-(User *) authenticationUserWithNickName:(NSString *) nick_name andPassword:(NSString*) password{
  
    NSMutableDictionary * posts = [[NSMutableDictionary alloc] init];
    [posts setObject:@"GET" forKey:@"action"];
    [posts setObject:nick_name forKey:@"NickName"];
    [posts setObject:password forKey:@"Password"];
    
    @try{
        NSString* urlData =[self httpPost:@"user.php" withData:posts];
        NSError *err = [[NSError alloc] init];

        NSMutableDictionary* array = [NSJSONSerialization JSONObjectWithData:urlData options: NSJSONReadingMutableContainers error: &err];

    
    NSLog(@"Login adatai megérkeztek!");
    

    for (NSDictionary* jd in array) {
    
    int identifier = [[ jd objectForKey: @"id" ] intValue];
    NSString * nickname = [ jd objectForKey: @"nick_name" ];
    NSString * pw = [ jd objectForKey: @"password" ];
    NSString * email = [ jd objectForKey: @"email" ];
    int sex = [[ jd objectForKey: @"sex" ] intValue];
    NSString * birthday = [ jd objectForKey: @"birthday" ];
    int type = [[ jd objectForKey: @"type" ] intValue];
    
    User *u = [[User alloc]initWithId:identifier andNickName:nickname andPassword:pw andEmail:email andSex:sex andBirthday:birthday andType:type];
        return u;
    }
    }@catch (NSException *e){
    }
    return nil;
    }


-(NSMutableArray *) getFavoriteClubsFromUserId:(NSInteger *) user_id{
    //copyright Lamfalusy
    NSMutableDictionary * posts = [[NSMutableDictionary alloc] init];
    [posts setObject:@"GETFAVORIT" forKey:@"action"];
    [posts setObject:[NSNumber numberWithInt:*user_id] forKey:@"userid"];
    
    @try{
        NSString* urlData = [self httpPost:@"favorite.php" withData:posts];
        NSError* err = [[NSError alloc] init];
        
        //NSMutableDictionary* array = [NSJSONSerialization JSONObje]
        
    }@catch (NSException *e) {
        ;
    }
    
    requestType = FAVORITE;
}

-(NSMutableArray *) getClubsFromCityName:(NSString *) cityname{
    @try{
    return [self searchClubsWithName:@"" andCityname:cityname andType:@"" andOffset:0 andLimit:0];
    }
    @catch (NSException *e) {
        
    }
    return nil;
    
}

//Elküld egy új hely kérelmet a szervernek, ha a owner_user_id -1 akkor nincs neki tulaj jelöltje
-(void) sendANewClubRequestWithClubname:(NSString *) newClubName andAddress: (NSString *) newClubAddress andType:(NSString *) newClubType andOwnerUserId:(NSInteger *) owner_user_id andServices:(NSString *) services{
    
    NSMutableDictionary * posts = [[NSMutableDictionary alloc] init];
    [posts setObject:@"ADD" forKey:@"action"];
    [posts setObject:newClubName forKey:@"Name"];
    [posts setObject:newClubType forKey:@"Type"];
    [posts setObject:newClubAddress forKey:@"Address"];
    
    //TODO:services és owner beállítása
    
    @try{
        NSDictionary* array =[self httpPost:@"club.php" withData:posts];

    }@catch (NSException *e) {
        
    }
}

-(NSMutableArray *) getOwnedClubsFromUserId:(NSInteger *) user_id{
    NSMutableDictionary * posts = [[NSMutableDictionary alloc] init];
    [posts setObject:@"GETUSERCLUBS" forKey:@"action"];
    [posts setObject:[NSNumber numberWithInt:*user_id] forKey:@"UserID"];
    
    [self httpPost:@"club.php" withData:posts];
    
    requestType = OWNED;
}

-(Club *) getEverythingFromClubId:(NSInteger *) club_id{
    NSMutableDictionary * posts = [[NSMutableDictionary alloc] init];
    [posts setObject:@"GETBYID" forKey:@"action"];
    [posts setObject:[NSNumber numberWithInt:*club_id] forKey:@"id"];
    
    @try{
        NSString* urlData =[self httpPost:@"club.php" withData:posts];
        NSError *err = [[NSError alloc] init];
        
        NSMutableDictionary* array = [NSJSONSerialization JSONObjectWithData:urlData options: NSJSONReadingMutableContainers error: &err];    for (NSDictionary* jd in array) {
        Club *c =[[Club alloc]initWithId:[[ jd objectForKey: @"id" ]intValue ] andName:[ jd objectForKey: @"name" ] andType:[ jd objectForKey: @"type" ] andDescription:[ jd objectForKey: @"description" ] andAddress:[ jd objectForKey: @"address" ] andPhonenumber:[ jd objectForKey: @"phonenumber" ] andEmail:[ jd objectForKey: @"email" ] andDate:@"nemtudommilyendátum" andApproved:[[ jd objectForKey: @"approved" ]intValue] ];
        return c;
    }
    }@catch (NSException *e){
                               
    }
return nil;

}

-(NSMutableArray *) searchClubsWithName:(NSString *) name andCityname:(NSString *) cityname andType:(NSString *) type andOffset:(int ) offset andLimit:(int ) limit{
    NSMutableDictionary * posts = [[NSMutableDictionary alloc] init];
    [posts setObject:@"SEARCH" forKey:@"action"];
    [posts setObject:name forKey:@"name"];
    [posts setObject:cityname forKey:@"cityname"];
    [posts setObject:type forKey:@"type"];
    [posts setObject:[NSNumber numberWithInt:offset] forKey:@"offset"];
    [posts setObject:[NSNumber numberWithInt:limit] forKey:@"limit"];

    @try{
        NSString* urlData =[self httpPost:@"club.php" withData:posts];
        NSError *err = [[NSError alloc] init];
        
        NSMutableDictionary* array = [NSJSONSerialization JSONObjectWithData:urlData options: NSJSONReadingMutableContainers error: &err];
        NSMutableArray *res = [[NSMutableArray alloc] init];
    for (NSDictionary* jd in array) {
        Club *c = [[Club alloc]initWithId:[[ jd objectForKey: @"id" ]intValue ]andName:[ jd objectForKey: @"name" ] andAddress:[ jd objectForKey: @"address" ]];
        [res addObject:c];
    }
    return res;
    }
    @catch (NSException *e) {
        
    }
    return nil;
}

-(void) modifyPasswordWithId:(NSInteger *) id andPassword:(NSString *) password{
    NSMutableDictionary * posts = [[NSMutableDictionary alloc] init];
    [posts setObject:@"UPDATEPASSWORD" forKey:@"action"];
    [posts setObject:[NSNumber numberWithInt:*id] forKey:@"userid"];
    [posts setObject:password forKey:@"password"];
    
    [self httpPost:@"user.php" withData:posts];
    
    requestType = UPDATEPASSWORD;
}

-(void) modifyUserDataWithId:(NSInteger *) id andEmail:(NSString *) email andBirthday:(NSString *) birthday andSex:(NSInteger *) sex{
    NSMutableDictionary * posts = [[NSMutableDictionary alloc] init];
    [posts setObject:@"UPDATEUSER" forKey:@"action"];
    [posts setObject:[NSNumber numberWithInt:*id] forKey:@"UserID"];
    [posts setObject:email forKey:@"Email"];
    [posts setObject:[NSNumber numberWithInt:*sex] forKey:@"Sex"];
    [posts setObject:birthday forKey:@"Birthday"];

    
    [self httpPost:@"user.php" withData:posts];
    
    requestType = UPDATEUSER;
}

-(void) registerANewUserWithName:(NSString *) name andPassword:(NSString *) password andEmail:(NSString *)  email andSex:(NSInteger *) sex andBirthday:(NSString *) birthday{
    NSMutableDictionary * posts = [[NSMutableDictionary alloc] init];
    [posts setObject:@"ADD" forKey:@"action"];
    [posts setObject:name forKey:@"NickName"];
    [posts setObject:password forKey:@"Password"];
    [posts setObject:email forKey:@"Email"];
    [posts setObject:[NSNumber numberWithInt:*sex] forKey:@"Sex"];
    [posts setObject:birthday forKey:@"Birthday"];
    
    
    [self httpPost:@"user.php" withData:posts];
    
    requestType = NEWUSER;
}

-(void) setServisesWithClubID:(NSInteger *) club_id andServices:(NSArray *) services{
    NSMutableDictionary * posts = [[NSMutableDictionary alloc] init];
    
    for(NSString* key in services){
        [posts setObject:@"ADD" forKey:@"action"];
        [posts setObject:[NSNumber numberWithInt:*club_id] forKey:@"ClubID"];
        [posts setObject:key forKey:@"ServiceName"];
    }
    
    [self httpPost:@"service.php" withData:posts];
    
    requestType = SETSERVICE;
}

-(void) setOwnerForClubWithUserID:(NSInteger *) user_id andClubID:(NSInteger *) club_id{
    NSMutableDictionary * posts = [[NSMutableDictionary alloc] init];
    [posts setObject:@"ADD" forKey:@"action"];
    [posts setObject:[NSNumber numberWithInt:*user_id] forKey:@"UserID"];
    [posts setObject:[NSNumber numberWithInt:*club_id] forKey:@"ClubID"];
    
    
    [self httpPost:@"owner.php" withData:posts];
    
    requestType = SETOWNER;
}

-(void) setFavoriteClubForUserWithUserID:(NSInteger *) user_id andClubID:(NSInteger *) club_id{
    NSMutableDictionary * posts = [[NSMutableDictionary alloc] init];
    [posts setObject:@"ADD" forKey:@"action"];
    [posts setObject:[NSNumber numberWithInt:*user_id] forKey:@"UserID"];
    [posts setObject:[NSNumber numberWithInt:*club_id] forKey:@"ClubID"];
    
    
    [self httpPost:@"favorite.php" withData:posts];
    
    requestType = SETFAVORITE;
}

-(void) deleteFavoriteClub:(NSInteger *) club_id forUser:(NSInteger *) user_id{
    NSMutableDictionary * posts = [[NSMutableDictionary alloc] init];
    [posts setObject:@"DELETE" forKey:@"action"];
    [posts setObject:[NSNumber numberWithInt:*club_id] forKey:@"clubid"];
    [posts setObject:[NSNumber numberWithInt:*user_id] forKey:@"userid"];
    
    
    [self httpPost:@"favorite.php" withData:posts];
    
    requestType = DELETEFAVORITE;
}

@end
