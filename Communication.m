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
NSMutableData * responseData = nil;

enum requestTypeEnum {
    LOGIN,FAVORITE,OWNED,EVERYTHING,NEWCLUB,SEARCHCLUB,UPDATEPASSWORD,UPDATEUSER,NEWUSER,SETSERVICE,SETOWNER,SETFAVORITE,DELETEFAVORITE
};

enum requestTypeEnum requestType = -1;


-(void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response{
    NSLog(@"Letöltés kezdete");
    responseData = [[NSMutableData alloc] init];
}

-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data{
    [responseData appendData:data];
    NSLog(@"append");
}

-(void)connectionDidFinishLoading:(NSURLConnection *)connection{
    NSLog(@"Letöltés kész");
    NSLog(@"Data: %@", [[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding]);
    
    switch ( requestType ) {
        case LOGIN:{
            NSLog(@"Login adatai megérkeztek!");
        
        
            NSArray * ja = [NSJSONSerialization JSONObjectWithData:responseData options:kNilOptions error:nil];
            NSDictionary * jd = [ ja objectAtIndex:0 ];
            
            int identifier = [ jd objectForKey: @"id" ];
            NSString * nickname = [ jd objectForKey: @"nick_name" ];
            NSString * pw = [ jd objectForKey: @"password" ];
            NSString * email = [ jd objectForKey: @"email" ];
            int sex = [ jd objectForKey: @"sex" ];
            NSString * birthday = [ jd objectForKey: @"birthday" ];
            int type = [ jd objectForKey: @"type" ];
            
            User *u = [[User alloc]initWithId:identifier andNickName:nickname andPassword:pw andEmail:email andSex:sex andBirthday:birthday andType:type];
            break;
            }
        case FAVORITE:{
            
            break;
            }
        case OWNED:{
            
            break;
            }
        case EVERYTHING:{
            
            break;
            }
        case NEWCLUB:{
            
            break;
            }
        case SEARCHCLUB:{
            
            break;
            }
        case UPDATEPASSWORD:{
            
            break;
            }
        case UPDATEUSER:{
            
            break;
            }
        case NEWUSER:{
            
            break;
            }
        case SETSERVICE:{
            
            break;
            }
        case SETOWNER:{
            
            break;
            }
        case SETFAVORITE:{
            
            break;
            }
        case DELETEFAVORITE:{
            
            break;
            }
        default:{
            
            NSLog(@"szar az egész");
            break;
            }
    }

}

-(void) httpPost: (NSString *) file withData: (NSMutableDictionary *) data{
    NSString *url = [NSString stringWithFormat:@"%@%@", mainUrl, file ];
    NSLog(@"HTTP POST");
    NSLog(@"URL: %@", url);
    
    NSMutableURLRequest * request = [[NSMutableURLRequest alloc] initWithURL:[[NSURL alloc] initWithString:url] ];
    [request setHTTPMethod:@"POST"];
    
    //NSMutableString *post = [NSString stringWithFormat:@"action=GET&NickName=%@&Password=%@",@"a",@"a"];
   /*  */
    NSMutableString *post = [NSMutableString string];
    for (NSString* key in [data allKeys]){
        if ([post length]>0)
            [post appendString:@"&"];
        [post appendFormat:@"%@=%@", key, [data objectForKey:key]];
    }
    /*  */
    NSLog(@"POST: %@", post);
    NSData *postData = [post dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES];
    NSString *postLength = [NSString stringWithFormat:@"%d",[postData length]];
    
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Current-Type"];
    
    [request setHTTPBody:postData];
    
    NSURLConnection * conn= [[NSURLConnection alloc] initWithRequest:request delegate:self];
    
    if(conn){
        NSLog(@"jo");
    }else{
        NSLog(@"nem jo");
    }
    
}

-(User *) authenticationUserWithNickName:(NSString *) nick_name andPassword:(NSString*) password{
  
    NSMutableDictionary * posts = [[NSMutableDictionary alloc] init];
    [posts setObject:@"GET" forKey:@"action"];
    [posts setObject:nick_name forKey:@"NickName"];
    [posts setObject:password forKey:@"Password"];
    
    [self httpPost:@"user.php" withData:posts];
    
    requestType = LOGIN;
}


-(NSMutableArray *) getFavoriteClubsFromUserId:(NSInteger *) user_id{
    NSMutableDictionary * posts = [[NSMutableDictionary alloc] init];
    [posts setObject:@"GETFAVORIT" forKey:@"action"];
    [posts setObject:[NSNumber numberWithInt:*user_id] forKey:@"userid"];
    
    [self httpPost:@"favorite.php" withData:posts];
    
    requestType = FAVORITE;
}

-(NSMutableArray *) getClubsFromCityName:(NSString *) cityname{
    
}


//Elküld egy új hely kérelmet a szervernek, ha a owner_user_id -1 akkor nincs neki tulaj jelöltje
-(void) sendANewClubRequestWithClubname:(NSString *) newClubName andAddress: (NSString *) newClubAddress andType:(NSString *) newClubType andOwnerUserId:(NSInteger *) owner_user_id andServices:(NSString *) services{
    
    NSMutableDictionary * posts = [[NSMutableDictionary alloc] init];
    [posts setObject:@"ADD" forKey:@"action"];
    [posts setObject:newClubName forKey:@"Name"];
    [posts setObject:newClubType forKey:@"Type"];
    [posts setObject:newClubAddress forKey:@"Address"];
    
    //TODO:services és owner beállítása
    
    [self httpPost:@"club.php" withData:posts];
    
    requestType = NEWCLUB;
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
    
    [self httpPost:@"club.php" withData:posts];
    
    requestType = EVERYTHING;
}

-(NSMutableArray *) searchClubsWithName:(NSString *) name andCityname:(NSString *) cityname andType:(NSString *) type andOffset:(NSInteger *) offset andLimit:(NSInteger *) limit{
    NSMutableDictionary * posts = [[NSMutableDictionary alloc] init];
    [posts setObject:@"SEARCH" forKey:@"action"];
    [posts setObject:name forKey:@"name"];
    [posts setObject:cityname forKey:@"cityname"];
    [posts setObject:type forKey:@"type"];
    [posts setObject:[NSNumber numberWithInt:*offset] forKey:@"offset"];
    [posts setObject:[NSNumber numberWithInt:*limit] forKey:@"limit"];

    
    [self httpPost:@"club.php" withData:posts];
    
    requestType = SEARCHCLUB;
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
