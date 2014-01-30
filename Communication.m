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

-(NSData*) httpPost: (NSString *) file withData: (NSMutableDictionary *) data{
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
    NSData *urlData=[NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    
    
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
            Club *c = [[Club alloc]initWithId:[[ jd objectForKey: @"id" ]intValue ]andName:[ jd objectForKey: @"name" ] andAddress:[ jd objectForKey: @"address" ] andHighliteExpire:[ jd objectForKey: @"address" ]];
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
        NSString* urlData = [self httpPost:@"club.php" withData:posts];
        NSError* err = [[NSError alloc] init];
        
        NSMutableDictionary* array = [NSJSONSerialization JSONObjectWithData:urlData options:NSJSONReadingMutableContainers error: &err];
        NSMutableArray *res = [[NSMutableArray alloc] init];
        
        for( NSDictionary* jd in array){
            Club *c = [[Club alloc]initWithId:[[ jd objectForKey: @"id" ]intValue ]andName:[ jd objectForKey: @"name" ] andAddress:[ jd objectForKey: @"address" ]];
            [res addObject:c];
//            NSLog(@"id: %d name: %@ address: %@",[c getIdentifier],[c getClubName],[c getAddress]);
            NSLog(@"%@",jd);
            NSLog(@"id: %d name: %@ address: %@",[[ jd objectForKey: @"id" ]intValue ],[ jd objectForKey: @"name" ],[c getAddress],[ jd objectForKey: @"address" ]);
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
        Club *c =[[Club alloc]initWithId:[[ jd objectForKey: @"id" ]intValue ] andName:[ jd objectForKey: @"name" ] andType:[ jd objectForKey: @"type" ] andDescription:[ jd objectForKey: @"description" ] andAddress:[ jd objectForKey: @"address" ] andPhonenumber:[ jd objectForKey: @"phonenumber" ] andEmail:[ jd objectForKey: @"email" ] andDate:@"nemtudommilyendátum" andHighliteExpire: [jd objectForKey: @"highlight_expire" ]  andApproved:[[ jd objectForKey: @"approved" ]intValue] ];
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
        NSLog(@"%d",[array count]);
        
        if ([array count]==0) {
            return nil;
        }
        else{
        User *u =[[User alloc]initWithId:[[array objectForKey:@"NewID"] intValue] andNickName:name andPassword:password andEmail:email andSex:[[NSNumber numberWithInt:sex] intValue] andBirthday:birthday andType:0 ];
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
    [posts setObject:[NSNumber numberWithInt:clubid] forKey:@"clubid"];
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

-(NSMutableArray *) getEventsOfClubWithClubId:(int) clubId{
    NSMutableDictionary * posts = [[NSMutableDictionary alloc] init];
    [posts setObject:@"GETEVENTSOFCLUB" forKey:@"action"];
    [posts setObject:[NSNumber numberWithInt:clubId] forKey:@"id"];
    
    @try{
        NSString* urlData = [self httpPost:@"event.php" withData:posts];
        NSError* err = [[NSError alloc] init];
        
        NSMutableDictionary* array = [NSJSONSerialization JSONObjectWithData:urlData options:NSJSONReadingMutableContainers error: &err];
        NSMutableArray *res = [[NSMutableArray alloc] init];

        for( NSDictionary* jd in array){
            Event *e = [[Event alloc] initWithId:[[jd objectForKey:@"id"] intValue] andName:[jd objectForKey:@"name"] andDescription:[jd objectForKey:@"description"] andStartDate:[jd objectForKey:@"start_date"] andMusic_type:[jd objectForKey:@"music_type"] andApproved:1];
            
            [res addObject:e];
        }
        return res;
        
    }@catch (NSException *e) {
        ;
    }
    
    return nil;
}

-(int) addEventWithClubID:(int) clubid andName:( NSString*) name andDescription:( NSString*) description andStartDate:( NSString*) start_date andRowImage:( NSString*) row_image andType:( NSString*) music_type {
    @try {
        NSMutableDictionary * posts = [[NSMutableDictionary alloc] init];
        [posts setObject:@"ADDNEW" forKey:@"action"];
        [posts setObject:[NSNumber numberWithInt:clubid] forKey:@"clubid"];
        [posts setObject:name forKey:@"name"];
        [posts setObject:description forKey:@"description"];
        [posts setObject:start_date forKey:@"start_date"];
        [posts setObject:row_image forKey:@"row_image"];
        [posts setObject:music_type forKey:@"music_type"];
        
        NSString* urlData = [self httpPost:@"event.php" withData:posts];
        NSError* err = [[NSError alloc] init];
        
        NSMutableDictionary* array = [NSJSONSerialization JSONObjectWithData:urlData options:NSJSONReadingMutableContainers error: &err];
        
        for (NSDictionary* jd in array) {
            int event_id =  [[jd objectForKey:@"NewID"] intValue];
            return event_id;
        }
        
    } @catch (NSException *e) {
        
    }
    
    return 0;
}

- (void) updateEventWithID:(int) eventid andName: (NSString *) name andDescription:( NSString*) description andStartDate:( NSString*) start_date andRowImage:( NSString*) row_image andType:( NSString*) music_type {
    @try {
        NSMutableDictionary * posts = [[NSMutableDictionary alloc] init];
        [posts setObject:@"UPDATE" forKey:@"action"];
        [posts setObject:[NSNumber numberWithInt:eventid] forKey:@"eventid"];
        [posts setObject:name forKey:@"name"];
        [posts setObject:description forKey:@"description"];
        [posts setObject:start_date forKey:@"start_date"];
        [posts setObject:row_image forKey:@"row_image"];
        [posts setObject:music_type forKey:@"music_type"];
        
        
        [self httpPost:@"event.php" withData:posts];
        
        
    } @catch (NSException *e) {
        
    }
    
}

-(void) deleteEventWithID:(int) eventId {
    @try {
        NSMutableDictionary * posts = [[NSMutableDictionary alloc] init];
        [posts setObject:@"DELETE" forKey:@"action"];
        [posts setObject:[NSString stringWithFormat:@"%d",eventId] forKey:@"eventid"];
        
        
        [self httpPost:@"event.php" withData:posts];
        
        
    } @catch (NSException *e) {
        
    }
    
}


- (int) addRatingWithClubID:(int) clubId andUserID:(int) userId andValue:(float) value andComment:(NSString *) comment {
    @try {
        NSMutableDictionary * posts = [[NSMutableDictionary alloc] init];
        [posts setObject:@"ADD" forKey:@"action"];
        [posts setObject:[NSNumber numberWithInt:clubId] forKey:@"clubid"];
        [posts setObject:[NSNumber numberWithInt:userId] forKey:@"userid"];
        [posts setObject:[NSNumber numberWithFloat:value] forKey:@"value"];
        [posts setObject:comment forKey:@"comment"];
        
        NSString* urlData = [self httpPost:@"rating.php" withData:posts];
        NSError* err = [[NSError alloc] init];
        
        NSMutableDictionary* array = [NSJSONSerialization JSONObjectWithData:urlData options:NSJSONReadingMutableContainers error: &err];
        
        for (NSDictionary* jd in array) {
            int rating_id =  [[jd objectForKey:@"NewID"] intValue];
            return rating_id;
        }
        
    } @catch (NSException *e) {
        
    }
    
    return 0;
}

-(void) updateRatingWithClubID:(int) clubId andUserID:(int) userId andValue:(float) value andComment:(NSString *) comment {
    
    @try {
        NSMutableDictionary * posts = [[NSMutableDictionary alloc] init];
        [posts setObject:@"UPDATE" forKey:@"action"];
        [posts setObject:[NSNumber numberWithInt:clubId] forKey:@"clubid"];
        [posts setObject:[NSNumber numberWithInt:userId] forKey:@"userid"];
        [posts setObject:[NSNumber numberWithFloat:value] forKey:@"value"];
        [posts setObject:comment forKey:@"comment"];
        
        [self httpPost:@"rating.php" withData:posts];
        
        
    } @catch (NSException *e) {
        
    }
    
}


-(NSMutableArray *) getRatingsFromClubID:(int) clubId {
    
    @try {
        NSMutableDictionary * posts = [[NSMutableDictionary alloc] init];
        [posts setObject:@"GET" forKey:@"action"];
        [posts setObject:[NSNumber numberWithInt:clubId] forKey:@"clubid"];
        
        NSString* urlData = [self httpPost:@"rating.php" withData:posts];
        NSError* err = [[NSError alloc] init];
        
        NSMutableDictionary* array = [NSJSONSerialization JSONObjectWithData:urlData options:NSJSONReadingMutableContainers error: &err];
        
        NSMutableArray *res = [[NSMutableArray alloc] init];
        for( NSDictionary* jd in array){
            Rating *r = [[Rating alloc] initWithUserID:[[ jd objectForKey: @"user_id" ]intValue ] andName:[ jd objectForKey: @"name" ] andValue:[[ jd objectForKey: @"value" ]floatValue ] andComment:[ jd objectForKey: @"comment" ] andApproved:[[ jd objectForKey: @"approved" ]intValue ] ];
            [res addObject:r];
        }
        return res;
        
    }@catch (NSException *e) {
        
    }
    return nil;
}

-(NSArray *) getNotApprovedRatings {
    @try {
        NSMutableDictionary * posts = [[NSMutableDictionary alloc] init];
        [posts setObject:@"GETNOTAPPROVED" forKey:@"action"];
        
        NSString* urlData = [self httpPost:@"rating.php" withData:posts];
        NSError* err = [[NSError alloc] init];
        
        NSMutableDictionary* array = [NSJSONSerialization JSONObjectWithData:urlData options:NSJSONReadingMutableContainers error: &err];
        
        NSMutableArray *res = [[NSMutableArray alloc] init];
        for( NSDictionary* jd in array){
            AdminRating *r = [[AdminRating alloc]initWithUserID:[[ jd objectForKey: @"user_id" ]intValue ] andUserName:[ jd objectForKey: @"name" ] andValue:[[ jd objectForKey: @"user_id" ]floatValue ] andComment:[ jd objectForKey: @"comment" ] andApproved:[[ jd objectForKey: @"approved" ]intValue ] andClubID:[[ jd objectForKey: @"club_id" ]intValue ] andClubName:[ jd objectForKey: @"clubName" ]];
            [res addObject:r];
        }
        return res;
        
    }@catch (NSException *e) {
        
    }
    return nil;
}


-(void)declineRatingWithUserId:(int) userId andClubId:(int) clubId {
    @try {
        NSMutableDictionary * posts = [[NSMutableDictionary alloc] init];
        [posts setObject:@"DECLINERATING" forKey:@"action"];
        [posts setObject:[NSNumber numberWithInt:clubId] forKey:@"clubid"];
        [posts setObject:[NSNumber numberWithInt:userId] forKey:@"userid"];
        
        [self httpPost:@"rating.php" withData:posts];
    }@catch (NSException *e) {
        
    }
}

-(void) acceptRatingWithUserId:(int) userId andClubId:(int) clubId {
    @try {
        NSMutableDictionary * posts = [[NSMutableDictionary alloc] init];
        [posts setObject:@"APPROVERATING" forKey:@"action"];
        [posts setObject:[NSNumber numberWithInt:clubId] forKey:@"clubid"];
        [posts setObject:[NSNumber numberWithInt:userId] forKey:@"userid"];
        
        [self httpPost:@"rating.php" withData:posts];
    }@catch (NSException *e) {
        
    }
}


-(void) deleteClubWithId:(int) clubId {
    @try {
        NSMutableDictionary * posts = [[NSMutableDictionary alloc] init];
        [posts setObject:@"DELETE" forKey:@"action"];
        [posts setObject:[NSNumber numberWithInt:clubId] forKey:@"clubid"];
        
        [self httpPost:@"club.php" withData:posts];
    }@catch (NSException *e) {
        
    }
}


-(void) updateClubInfoWithId:(int) clubId andName:(NSString *) name andType:(NSString*) type andDescription:(NSString *) description andAddress:(NSString *) address andPhonenumber:(NSString *) phonenumber andEmail:(NSString *) email {
    @try {
        NSMutableDictionary * posts = [[NSMutableDictionary alloc] init];
        [posts setObject:@"UPDATE" forKey:@"action"];
        [posts setObject:[NSNumber numberWithInt:clubId] forKey:@"clubid"];
        [posts setObject:name forKey:@"name"];
        [posts setObject:type forKey:@"type"];
        [posts setObject:description forKey:@"description"];
        [posts setObject:address forKey:@"address"];
        [posts setObject:phonenumber forKey:@"phonenumber"];
        [posts setObject:email forKey:@"email"];
        
        [self httpPost:@"club.php" withData:posts];
    }@catch (NSException *e) {
        
    }
}


-(NSString *)setHighlightExpireWithClubId:(int) clubId andDays:(int) days {
    @try {
        NSMutableDictionary * posts = [[NSMutableDictionary alloc] init];
        [posts setObject:@"SETHIGHLIGHTEXPIRE" forKey:@"action"];
        [posts setObject:[NSNumber numberWithInt:clubId] forKey:@"clubid"];
        [posts setObject:[NSString stringWithFormat:@"%d",days] forKey:@"day"];
        
        
        NSString* urlData = [self httpPost:@"club.php" withData:posts];
        NSError* err = [[NSError alloc] init];
        
        NSMutableDictionary* array = [NSJSONSerialization JSONObjectWithData:urlData options:NSJSONReadingMutableContainers error: &err];
        
        for( NSDictionary* jd in array){
            NSString * newDate = [NSString stringWithFormat:@"%@", [jd objectForKey:@"highlight_expire"] ];
            return newDate;
        }
        
    }@catch (NSException *e) {
        
    }
    return @"";
}

-(int) uploadAnImageWithClubId:(int) clubId andRowImage:(NSString*) rowImage andRotate:(int) rotate{
    @try {
        NSMutableDictionary * posts = [[NSMutableDictionary alloc] init];
        [posts setObject:@"ADD" forKey:@"action"];
        [posts setObject:[NSNumber numberWithInt:clubId] forKey:@"clubid"];
        [posts setObject:rowImage forKey:@"rawImage"];
        [posts setObject:[NSNumber numberWithInt:rotate] forKey:@"rotate"];
        
        NSData* urlData = [self httpPost:@"image.php" withData:posts];
        NSError* err = [[NSError alloc] init];
        
        NSMutableDictionary* array = [NSJSONSerialization JSONObjectWithData:urlData options:NSJSONReadingMutableContainers error: &err];
        
        return [[array objectForKey:@"NewID"] intValue];
        
    } @catch (NSException *e) {
        
    }
    
    return 0;
}

-(NSString *) downLoadAnImageWithId:(int) imageId{
    @try {
        NSMutableDictionary * posts = [[NSMutableDictionary alloc] init];
        [posts setObject:@"GET" forKey:@"action"];
        [posts setObject:[NSNumber numberWithInt:imageId] forKey:@"imageid"];
        
        NSData* urlData = [self httpPost:@"image.php" withData:posts];
        NSError* err = [[NSError alloc] init];
        
        NSMutableDictionary* array = [NSJSONSerialization JSONObjectWithData:urlData options:NSJSONReadingMutableContainers error: &err];
        
        for (NSDictionary* jd in array) {
            NSString* image = [jd objectForKey:@"rawImage"];
            return image;
        }
        
    } @catch (NSException *e) {
        
    }
    
    return @"";
}

-(NSMutableArray *) selectClubsImagesIdsWithClubId:(int) clubId{
    @try {
        NSMutableDictionary * posts = [[NSMutableDictionary alloc] init];
        [posts setObject:@"GETIDS" forKey:@"action"];
        [posts setObject:[NSNumber numberWithInt:clubId] forKey:@"clubid"];
        
        NSString* urlData = [self httpPost:@"image.php" withData:posts];
        NSError* err = [[NSError alloc] init];
        NSMutableArray *res = [[NSMutableArray alloc] init];
        
        NSMutableDictionary* array = [NSJSONSerialization JSONObjectWithData:urlData options:NSJSONReadingMutableContainers error: &err];
        
        for (NSDictionary* jd in array) {
            NSNumber * imageId = [jd objectForKey:@"imageid"];
            [res addObject:imageId];
        }
        return res;
        
    } @catch (NSException *e) {
        
    }
    
    return nil;
}

-(NSString*) downLoadAnImageThumbnailWithImageId:(int) imageId{
    @try {
        NSMutableDictionary * posts = [[NSMutableDictionary alloc] init];
        [posts setObject:@"GETTHUMBNAIL" forKey:@"action"];
        [posts setObject:[NSNumber numberWithInt:imageId] forKey:@"imageid"];
        
        NSString* urlData = [self httpPost:@"image.php" withData:posts];
        NSError* err = [[NSError alloc] init];
        
        NSMutableDictionary* array = [NSJSONSerialization JSONObjectWithData:urlData options:NSJSONReadingMutableContainers error: &err];
        
        for (NSDictionary* jd in array) {
            NSString* image = [jd objectForKey:@"rawImage"];
            return image;
        }
        
    } @catch (NSException *e) {
        
    }
    
    return @"";
}

@end










































