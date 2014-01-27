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

-(void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response{
    responseData = [[NSMutableData alloc] init];
}

-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data{
    [responseData appendData:data];
}

-(void)connectionDidFinishLoading:(NSURLConnection *)connection{
    NSLog(@"Letöltés kész");
    NSLog(@"Data: %@", [[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding]);
}

-(NSString *) httpPost: (NSString *) file withData: (NSMutableDictionary *) data{
    NSString *url = [NSString stringWithFormat:@"%@%@", mainUrl, file ];
    NSLog(@"HTTP POST");
    NSLog(@"URL: %@", url);
    
    NSMutableURLRequest * request = [[NSMutableURLRequest alloc] initWithURL:[[NSURL alloc] initWithString:url] ];
    [request setHTTPMethod:@"POST"];
    
    
    NSString *post = [NSString stringWithFormat:@"&NickName=%@&Password=%@",@"nick_name",@"password"];
    NSLog(@"POST: %@", post);
    NSData *postData = [post dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES];
    NSString *postLength = [NSString stringWithFormat:@"%d",[postData length]];
    
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Current-Type"];
    
    [request setHTTPBody:postData];
    
    NSURLConnection * conn= [[NSURLConnection alloc] initWithRequest:request delegate:self];
    
    
}

-(User *) authenticationUserWithNickName:(NSString *) nick_name andPassword:(NSString*) password{
    //    1. set post string with actual username and password.
    NSString *post = [NSString stringWithFormat:@"&NickName=%@&Password=%@",@"nick_name",@"password"];
    NSLog(@"%@",post);
    //    2. Encode the post string using NSASCIIStringEncoding and also the post string you need to send in NSData format.
    NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    
    //    You need to send the actual length of your data. Calculate the length of the post string.
    NSString *postLength = [NSString stringWithFormat:@"%d",[postData length]];
    
    //    3. Create a Urlrequest with all the properties like HTTP method, http header field with length of the post string.
    //    Create URLRequest object and initialize it.
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    
    //    Set the Url for which your going to send the data to that request.
    [request setURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://www.schonherz.bl.ee/partyapp/user.php"]]];
    
    //    Now, set HTTP method (POST or GET).
    //    Write this lines as it is in your code.
    [request setHTTPMethod:@"GET"];
    
    //    Set HTTP header field with length of the post data.
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    
    //    Also set the Encoded value for HTTP header Field.
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Current-Type"];
    
    //    Set the HTTPBody of the urlrequest with postData.
    [request setHTTPBody:postData];
    
    //    4. Now, create URLConnection object. Initialize it with the URLRequest.
    NSURLConnection *conn = [[NSURLConnection alloc]initWithRequest:request delegate:self];
    
    //    It returns the initialized url connection and begins to load the data for the url request. You can check that whether you URL connection is done properly or not using just if/else statement as below.
    if(conn)
    {
        NSLog(@"Connection successful");
    }
    else
    {
        NSLog(@"Connection could not be made");
    }
}


-(NSMutableArray *) getFavoriteClubsFromUserId:(NSInteger *) user_id{
    
}

-(NSMutableArray *) getClubsFromCityName:(NSString *) cityname{
    
}


//Elküld egy új hely kérelmet a szervernek, ha a owner_user_id -1 akkor nincs neki tulaj jelöltje
-(void) sendANewClubRequestWithClubname:(NSString *) newClubName andAddress: (NSString *) newClubAddress andType:(NSString *) newClubType andOwnerUserId:(NSInteger *) owner_user_id andServices:(NSString *) services{
    
}

-(NSMutableArray *) getOwnedClubsFromUserId:(NSInteger *) user_id{
    
}

-(Club *) getEverythingFromClubId:(NSInteger *) club_id{
    
}

-(NSMutableArray *) searchClubsWithName:(NSString *) name andCityname:(NSString *) cityname andType:(NSString *) type andOffset:(NSInteger *) offset andLimit:(NSInteger *) limit{
    
}

-(void) modifyPasswordWithId:(NSInteger *) id andPassword:(NSString *) password{
    
}

-(void) modifyUserDataWithId:(NSInteger *) id andEmail:(NSString *) email andBirthday:(NSString *) birthday andSex:(NSInteger *) sex{
    
}

-(void) registerANewUserWithName:(NSString *) name andPassword:(NSString *) password andEmail:(NSString *)  email andSex:(NSInteger *) sex andBirthday:(NSString *) birthday{
    
}

-(void) setServisesWithClubID:(NSInteger *) club_id andServices:(NSString *) services{
    
}

-(void) setOwnerForClubWithUserID:(NSInteger *) user_id andClubID:(NSInteger *) club_id{
    
}

-(void) setFavoriteClubForUserWithUserID:(NSInteger *) user_id andClubID:(NSInteger *) club_id{
    
}

-(void) deleteFavoriteClubForUserWithFavoriteID:(NSInteger *) favorite_id{
    
}

@end
