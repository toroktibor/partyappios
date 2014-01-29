//
//  Communication.m
//  bcsapat
//
//  Created by hallgato on 1/22/14.
//  Copyright (c) 2014 hallgato. All rights reserved.
//

#import "Communication.h"


@implementation Communication

NSString * mainUrl = @"http://95.85.19.48/";
NSError *error;

-(NSString*) httpPost: (NSString *) file withData: (NSMutableDictionary *) data{
    NSMutableString *post = [NSMutableString string];
    for (NSString* key in [data allKeys]){
        if ([post length]>0)
            [post appendString:@"&"];
        [post appendFormat:@"%@=%@", key, [data objectForKey:key]];
    }
    
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@", mainUrl, file ]];
    
    NSData *postData = [post dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES];
    NSString *postLength = [NSString stringWithFormat:@"%d",[postData length]];
    
    NSMutableURLRequest * request = [[NSMutableURLRequest alloc] init];
    [request setURL:url];
    [request setHTTPMethod:@"POST"];
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Current-Type"];
    [request setHTTPBody:postData];
    
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


-(NSMutableArray *) getFavoriteClubsFromUserId:(int) user_id{
    //copyright Lamfalusy
    NSMutableDictionary * posts = [[NSMutableDictionary alloc] init];
    [posts setObject:@"GETFAVORIT" forKey:@"action"];
    [posts setObject:[NSNumber numberWithInt:user_id] forKey:@"userid"];
    
    @try{
        NSString* urlData = [self httpPost:@"favorite.php" withData:posts];
        NSError* err = [[NSError alloc] init];
        
        NSMutableDictionary* array = [NSJSONSerialization JSONObjectWithData:urlData options:NSJSONReadingMutableContainers error: &err];
        NSMutableArray *res = [[NSMutableArray alloc] init];
        
        for( NSDictionary* jd in array){
            Club *c = [[Club alloc]initWithId:[[ jd objectForKey: @"id" ]intValue ]andName:[ jd objectForKey: @"name" ] andAddress:[ jd objectForKey: @"address" ]];
            [res addObject:c];
        }
        return res;
        
    }@catch (NSException *e) {
        
    }
    
    return nil;
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
-(void) sendANewClubRequestWithClubname:(NSString *) newClubName andAddress: (NSString *) newClubAddress andType:(NSString *) newClubType andOwnerUserId:(int) owner_user_id andServices:(NSString *) services{
    
    NSMutableDictionary * posts = [[NSMutableDictionary alloc] init];
    [posts setObject:@"ADD" forKey:@"action"];
    [posts setObject:newClubName forKey:@"Name"];
    [posts setObject:newClubType forKey:@"Type"];
    [posts setObject:newClubAddress forKey:@"Address"];
    
    //TODO:services és owner beállítása
    
    @try{
        NSDictionary* array =[self httpPost:@"club.php" withData:posts];
        if ([array isEqual:@"FAILED"]) {
            //itt baj lesz
        } else{
            int club_id =[[ array objectForKey: @"NewID" ]intValue ];
            [self setServisesWithClubID:club_id andServices:services];
            if ( owner_user_id != -1 ) {
                [self setOwnerForClubWithUserID:owner_user_id andClubID:club_id];
            }
                
        }
        
    }@catch (NSException *e) {
        
    }
}

-(NSMutableArray *) getOwnedClubsFromUserId:(int) user_id{
    //copyright Lamfalusy
    NSMutableDictionary * posts = [[NSMutableDictionary alloc] init];
    [posts setObject:@"GETUSERCLUBS" forKey:@"action"];
    [posts setObject:[NSNumber numberWithInt:user_id] forKey:@"UserID"];
    
    @try{
        NSString* urlData = [self httpPost:@"owner.php" withData:posts];
        NSError* err = [[NSError alloc] init];
        
        NSMutableDictionary* array = [NSJSONSerialization JSONObjectWithData:urlData options:NSJSONReadingMutableContainers error: &err];
        NSMutableArray *res = [[NSMutableArray alloc] init];
        
        for( NSDictionary* jd in array){
            Club *c = [[Club alloc]initWithId:[[ jd objectForKey: @"id" ]intValue ]andName:[ jd objectForKey: @"name" ] andAddress:[ jd objectForKey: @"address" ]];
            [res addObject:c];
        }
        return res;
        
    }@catch (NSException *e) {
        
    }
    
    return nil;
}

-(Club *) getEverythingFromClubId:(int) club_id{
    NSMutableDictionary * posts = [[NSMutableDictionary alloc] init];
    [posts setObject:@"GETBYID" forKey:@"action"];
    [posts setObject:[NSNumber numberWithInt:club_id] forKey:@"id"];
    
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

-(NSMutableArray *) searchClubsWithName:(NSString *) name andCityname:(NSString *) cityname andType:(NSString *) type andOffset:(int ) offset andLimit:(int) limit{
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

-(void) modifyPasswordWithId:(int) id andPassword:(NSString *) password{
    NSMutableDictionary * posts = [[NSMutableDictionary alloc] init];
    [posts setObject:@"UPDATEPASSWORD" forKey:@"action"];
    [posts setObject:[NSNumber numberWithInt:id] forKey:@"userid"];
    [posts setObject:password forKey:@"password"];
    
    [self httpPost:@"user.php" withData:posts];
    
}

-(void) modifyUserDataWithId:(int) id andEmail:(NSString *) email andBirthday:(NSString *) birthday andSex:(int) sex{
    NSMutableDictionary * posts = [[NSMutableDictionary alloc] init];
    [posts setObject:@"UPDATEUSER" forKey:@"action"];
    [posts setObject:[NSNumber numberWithInt:id] forKey:@"UserID"];
    [posts setObject:email forKey:@"Email"];
    [posts setObject:[NSNumber numberWithInt:sex] forKey:@"Sex"];
    [posts setObject:birthday forKey:@"Birthday"];

    
    [self httpPost:@"user.php" withData:posts];
    
}

-(User *) registerANewUserWithName:(NSString *) name andPassword:(NSString *) password andEmail:(NSString *)  email andSex:(int) sex andBirthday:(NSString *) birthday{
    //copyright Lamfalusy
    NSMutableDictionary * posts = [[NSMutableDictionary alloc] init];
    
    [posts setObject:@"ADD" forKey:@"action"];
    [posts setObject:name forKey:@"NickName"];
    [posts setObject:password forKey:@"Password"];
    [posts setObject:email forKey:@"Email"];
    [posts setObject:[NSNumber numberWithInt:sex] forKey:@"Sex"];
    [posts setObject:birthday forKey:@"Birthday"];
    
    @try{
        NSString* urlData = [self httpPost:@"user.php" withData:posts];
        NSError* err = [[NSError alloc] init];
        
        NSMutableDictionary* array = [NSJSONSerialization JSONObjectWithData:urlData options:NSJSONReadingMutableContainers error: &err];
        
        for (NSDictionary* jd in array) {
            User *u =[[User alloc]initWithId:[[jd objectForKey:@"NewID"] intValue] andNickName:name andPassword:password andEmail:email andSex:[[NSNumber numberWithInt:sex] intValue] andBirthday:birthday andType:0 ];
            return u;
        }
        
    }@catch (NSException *e) {
        
    }
    
    return nil;
}

-(void) setServisesWithClubID:(int) club_id andServices:(NSArray *) services{
    //ebbe bele javitottam de nem biztos h frankon :D (Lamfalusy)
    for(NSString* key in services){
        NSMutableDictionary * posts = [[NSMutableDictionary alloc] init];
        [posts setObject:@"ADD" forKey:@"action"];
        [posts setObject:[NSNumber numberWithInt:club_id] forKey:@"ClubID"];
        [posts setObject:key forKey:@"ServiceName"];
        [self httpPost:@"service.php" withData:posts];
    }
    
}

-(void) setOwnerForClubWithUserID:(int) user_id andClubID:(int) club_id{
    NSMutableDictionary * posts = [[NSMutableDictionary alloc] init];
    [posts setObject:@"ADD" forKey:@"action"];
    [posts setObject:[NSNumber numberWithInt:user_id] forKey:@"UserID"];
    [posts setObject:[NSNumber numberWithInt:club_id] forKey:@"ClubID"];
    
    
    [self httpPost:@"owner.php" withData:posts];
    
}

-(void) setFavoriteClubForUserWithUserID:(int) user_id andClubID:(int) club_id{
    NSMutableDictionary * posts = [[NSMutableDictionary alloc] init];
    [posts setObject:@"ADD" forKey:@"action"];
    [posts setObject:[NSNumber numberWithInt:user_id] forKey:@"UserID"];
    [posts setObject:[NSNumber numberWithInt:club_id] forKey:@"ClubID"];
    
    
    [self httpPost:@"favorite.php" withData:posts];
    
}

-(void) deleteFavoriteClub:(int) club_id forUser:(int) user_id{
    NSMutableDictionary * posts = [[NSMutableDictionary alloc] init];
    [posts setObject:@"DELETE" forKey:@"action"];
    [posts setObject:[NSNumber numberWithInt:club_id] forKey:@"clubid"];
    [posts setObject:[NSNumber numberWithInt:user_id] forKey:@"userid"];
    
    
    [self httpPost:@"favorite.php" withData:posts];
    
}

-(NSMutableArray *) getNotApprovedClubs{
    NSMutableDictionary * posts = [[NSMutableDictionary alloc] init];
    [posts setObject:@"GETNOTAPPROVEDCLUB" forKey:@"action"];
    
    @try{
        NSString* urlData = [self httpPost:@"club.php" withData:posts];
        NSError* err = [[NSError alloc] init];
        
        NSMutableDictionary* array = [NSJSONSerialization JSONObjectWithData:urlData options:NSJSONReadingMutableContainers error: &err];
        NSMutableArray *res = [[NSMutableArray alloc] init];
        
        for( NSDictionary* jd in array){
            Club *c = [[Club alloc]initWithId:[[ jd objectForKey: @"id" ]intValue ]andName:[ jd objectForKey: @"name" ] andAddress:[ jd objectForKey: @"address" ]];
            [res addObject:c];
        }
        return res;
        
    }@catch (NSException *e) {
        ;
    }
    
    return nil;
}

-(void) approveClubWithClubId: (int) club_id{
    NSMutableDictionary * posts = [[NSMutableDictionary alloc] init];
    [posts setObject:@"ACCEPTCLUB" forKey:@"action"];
    [posts setObject:[NSNumber numberWithInt:club_id] forKey:@"clubid"];
    
    [self httpPost:@"club.php" withData:posts];
}

-(void) declineNewClubWithClubId: (int) club_id{
    NSMutableDictionary * posts = [[NSMutableDictionary alloc] init];
    [posts setObject:@"DECLINECLUB" forKey:@"action"];
    [posts setObject:[NSNumber numberWithInt:club_id] forKey:@"clubid"];
    
    [self httpPost:@"club.php" withData:posts];
}

-(void) declineOwnerRequestWithClubId: (int) club_id andUserId: (int) user_id{
    NSMutableDictionary * posts = [[NSMutableDictionary alloc] init];
    [posts setObject:@"DELETE" forKey:@"action"];
    [posts setObject:[NSNumber numberWithInt:club_id] forKey:@"clubid"];
    [posts setObject:[NSNumber numberWithInt:user_id] forKey:@"userid"];
    
    [self httpPost:@"owner.php" withData:posts];
}

-(void) acceptOwnerRequestWithClubId: (int) club_id andUserId: (int) user_id{
    NSMutableDictionary * posts = [[NSMutableDictionary alloc] init];
    [posts setObject:@"ACCEPT" forKey:@"action"];
    [posts setObject:[NSNumber numberWithInt:club_id] forKey:@"clubid"];
    [posts setObject:[NSNumber numberWithInt:user_id] forKey:@"userid"];
    
    [self httpPost:@"owner.php" withData:posts];
}

-(NSMutableArray *) getNotApprovedOwnerRequest{
    NSMutableDictionary * posts = [[NSMutableDictionary alloc] init];
    [posts setObject:@"GET" forKey:@"action"];
    
    @try{
        NSString* urlData = [self httpPost:@"owner.php" withData:posts];
        NSError* err = [[NSError alloc] init];
        
        NSMutableDictionary* array = [NSJSONSerialization JSONObjectWithData:urlData options:NSJSONReadingMutableContainers error: &err];
        NSMutableArray *res = [[NSMutableArray alloc] init];
        
        for( NSDictionary* jd in array){
            OwnerRequest *o = [[OwnerRequest alloc] initWithClub:[[Club alloc] initWithId:[[jd objectForKey:@"club_id"] intValue] andName:[jd objectForKey:@"name"]  andAddress:[jd objectForKey:@"address"] ] andUser:[[User alloc]initWithId:[[jd objectForKey:@"user_id"] intValue] andNickName:[jd objectForKey:@"nick_name"] andPassword:@"" andEmail:[jd objectForKey:@"email"] andSex:0 andBirthday:@"" andType:0]];
            
            [res addObject:o];
        }
        return res;
        
    }@catch (NSException *e) {
        ;
    }
    
    return nil;
}

-(int) addANewMenuItemWithClubId: (int) clubid andMenuItem: (MenuItem *) menuItem{
    NSMutableDictionary * posts = [[NSMutableDictionary alloc] init];
    [posts setObject:@"ADDNEW" forKey:@"action"];
    [posts setObject:[NSNumber numberWithInt:[menuItem getIdentifier]] forKey:@"menuid"];
    [posts setObject:[menuItem getMenuItemName] forKey:@"name"];
    [posts setObject:[NSNumber numberWithInt:[menuItem getPrice]] forKey:@"price"];
    [posts setObject:[menuItem getCurrency] forKey:@"currency"];
    [posts setObject:[menuItem getUnit] forKey:@"unit"];
    [posts setObject:[NSNumber numberWithInt:[menuItem getDiscount]] forKey:@"discount"];
    [posts setObject:[menuItem getMenuItemCategory] forKey:@"menu_category"];
    [posts setObject:[NSNumber numberWithInt:[menuItem getMenuSort]] forKey:@"menu_sort"];
    
    @try{
        NSString* urlData = [self httpPost:@"menu_item.php" withData:posts];
        NSError* err = [[NSError alloc] init];
        
        NSMutableDictionary* array = [NSJSONSerialization JSONObjectWithData:urlData options:NSJSONReadingMutableContainers error: &err];
        for( NSDictionary* jd in array){
            return [[jd objectForKey:@"NewID"] intValue];
        }
    }@catch (NSException *e) {
        ;
    }
    
    return 0;
}

-(NSMutableArray *) getMenuItemsForClubWithClubId:(int) club_id{
    NSMutableDictionary * posts = [[NSMutableDictionary alloc] init];
    [posts setObject:@"GETFROMCLUBID" forKey:@"action"];
    [posts setObject:[NSNumber numberWithInt:club_id] forKey:@"clubid"];
    
    @try{
        NSString* urlData = [self httpPost:@"menu_item.php" withData:posts];
        NSError* err = [[NSError alloc] init];
        
        NSMutableDictionary* array = [NSJSONSerialization JSONObjectWithData:urlData options:NSJSONReadingMutableContainers error: &err];
        NSMutableArray *res = [[NSMutableArray alloc] init];
        
        for( NSDictionary* jd in array){
            MenuItem *m = [[MenuItem alloc] initWithId:[[jd objectForKey:@"id"] intValue] andName:[jd objectForKey:@"name"] andPrice:[[jd objectForKey:@"price"] intValue]andCurrency:[jd objectForKey:@"currency"] andUnit:[jd objectForKey:@"unit"] andDiscount:[[jd objectForKey:@"discount"] intValue]andMenuCategory:[jd objectForKey:@"menu_category"] andMenuSort:[[jd objectForKey:@"menu_sort"] intValue]];
            
            [res addObject:m];
        }
        return res;
        
    }@catch (NSException *e) {
        ;
    }
    
    return nil;
}

-(void) updateAMenuItemWithMenuItem:(MenuItem *) menuItem{
    NSMutableDictionary * posts = [[NSMutableDictionary alloc] init];
    [posts setObject:@"UPDATE" forKey:@"action"];
    [posts setObject:[NSNumber numberWithInt:[menuItem getIdentifier]] forKey:@"menuid"];
    [posts setObject:[menuItem getMenuItemName] forKey:@"name"];
    [posts setObject:[NSNumber numberWithInt:[menuItem getPrice]] forKey:@"price"];
    [posts setObject:[menuItem getCurrency] forKey:@"currency"];
    [posts setObject:[menuItem getUnit] forKey:@"unit"];
    [posts setObject:[NSNumber numberWithInt:[menuItem getDiscount]] forKey:@"discount"];
    [posts setObject:[menuItem getMenuItemCategory] forKey:@"menu_category"];
    [posts setObject:[NSNumber numberWithInt:[menuItem getMenuSort]] forKey:@"menu_sort"];
    
    
    [self httpPost:@"menu_item.php" withData:posts];
}

-(void) removeEMenuItemWithMenuId:(int) menuId{
    NSMutableDictionary * posts = [[NSMutableDictionary alloc] init];
    [posts setObject:@"DELETE" forKey:@"action"];
    [posts setObject:[NSNumber numberWithInt:menuId] forKey:@"menuid"];
    
    [self httpPost:@"menu_item.php" withData:posts];
}

-(NSMutableArray *) getEventsOfClubWithEventId:(int) eventId{
    NSMutableDictionary * posts = [[NSMutableDictionary alloc] init];
    [posts setObject:@"GETEVENTSOFCLUB" forKey:@"action"];
    [posts setObject:[NSNumber numberWithInt:eventId] forKey:@"id"];
    
    @try{
        NSString* urlData = [self httpPost:@"event.php" withData:posts];
        NSError* err = [[NSError alloc] init];
        
        NSMutableDictionary* array = [NSJSONSerialization JSONObjectWithData:urlData options:NSJSONReadingMutableContainers error: &err];
        NSMutableArray *res = [[NSMutableArray alloc] init];
        
        for( NSDictionary* jd in array){
            Event *e = [[Event alloc] initWithId:[[jd objectForKey:@"id"] intValue] andName:[jd objectForKey:@"name"] andDescription:[jd objectForKey:@"description"] andStartDate:[jd objectForKey:@"start_date"] andMusic_type:[jd objectForKey:@"music_type"]];
            
            [res addObject:e];
        }
        return res;
        
    }@catch (NSException *e) {
        ;
    }
    
    return nil;
}

@end










































