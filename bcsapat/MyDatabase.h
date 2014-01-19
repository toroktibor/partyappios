//
//  MyDatabase.h
//  bcsapat
//
//  Created by hallgato on 1/13/14.
//  Copyright (c) 2014 hallgato. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>

@interface MyDatabase : NSObject{
    sqlite3 * database;
}

-(sqlite3 *)getDatabase;

-(id) initWithPath: (NSString *) path;

-(NSArray *)selectAllFromUser;

-(NSArray*) performQuery: (NSString*)query;

-(NSArray *)insertIntoUserTableWithId:(NSInteger *) identifier andWithNickName:(NSString *) nickname andWithPassword:(NSString *) pw andWithType:(NSInteger *) type;

@end
