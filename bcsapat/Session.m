//
//  Session.m
//  bcsapat
//
//  Created by hallgato on 1/13/14.
//  Copyright (c) 2014 hallgato. All rights reserved.
//

#import "Session.h"
#import "User.h"
#import "MyDatabase.h"
#include<unistd.h>
#include<netdb.h>


@implementation Session


static Session * _instance = nil;

+(Session *)getInstance{
    @synchronized([Session class]){
        if (_instance == nil) {
            [[self alloc] init];
            return _instance;
        }
    }
    return _instance;
}

+(void)deleteSession{
    _instance=nil;
}


-(void)setMenuItemIndex:(int)itemIndex{
    menuItemIndex=itemIndex;
}

-(int)getMenuItemIndex{
    return menuItemIndex;
}

-(void)setSelectedIndex:(int)index{
    SelectedIndex=index;
}

-(int)getSelectedIndex{
    return SelectedIndex;
}

-(User *)getActualUser{
    return actualUser;
}

-(void)setActualUser:(User *)user{
    actualUser = user;
}

-(NSMutableArray *) getSearchViewCLubs{
    return searchViewCLubs;
}

-(void)addClub:(Club *)club{
    [searchViewCLubs addObject:club];
}

-(void)testAddString:(NSString*)string{
    [searchViewCLubs addObject:string];
}

-(Club*)getSelectedClubAtIndex:(int)index{
    return [searchViewCLubs objectAtIndex:index];
}

-(void)logArray{
    for (int i=0; i<[searchViewCLubs count]; ++i) {
        NSLog(@"%@",[searchViewCLubs objectAtIndex:i]);
    }
}


-(BOOL)isNetworAvaiable{
    char *hostname;
    struct hostent *hostinfo;
    hostname = "google.com";
    hostinfo = gethostbyname (hostname);
    if (hostinfo == NULL){
       // NSLog(@"-> no connection!\n");
        isOnline=NO;
    }
    else{
       // NSLog(@"-> connection established!\n");
        isOnline=YES;
    }
    return isOnline;
}

-(MyDatabase *)getDatabse{
    return databaseConnection;
}

-(SillyCommunication *)getCommunication{
    return actualCommunication;
}

-(void)setUserLocation:(NSString *)location{
    userLocation=location;
}

-(NSString *)getUserLocation{
    return userLocation;
}

-(NSString *)getClubTypeForPicker{
    return clubTypeForPicker;
}

-(void)setClubTypeForPicer:(NSString *)picker{
    clubTypeForPicker=picker;
}

+(id)alloc {
    @synchronized([Session class]) {
        NSAssert(_instance == nil, @"oops... Mar van ilyen peldany");
        _instance = [super alloc];
        return _instance;
    }
    return nil;
}

-(id)init {
    if (self = [super init]) {
        NSArray* paths =NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString* documentsDirectory = [paths objectAtIndex:0];
        NSString *path =[documentsDirectory stringByAppendingPathComponent:@"partyapp.db"];
        
        databaseConnection = [[MyDatabase alloc] initWithPath:path];
        actualCommunication = [[SillyCommunication alloc] init];
        searchViewCLubs = [[NSMutableArray alloc]init];
        clubTypeForPicker=@"Szórakozóhely típusa";
        musicType=@"Zene típusa";
        image=[[UIImage alloc]init];
    }
    return self;
}

-(void)setSearchViewCLubs:(NSMutableArray *)inputClubsList{
    [searchViewCLubs addObjectsFromArray:inputClubsList];
}

-(void)setMusicType:(NSString *)music{
    musicType=music;
}

-(NSString *)getMusicType{
    return musicType;
}

-(void)setImage:(UIImage *)pics{
    image=pics;
}

-(UIImage *)getImage{
    return image;
}

@end
