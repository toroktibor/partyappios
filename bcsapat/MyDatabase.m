//
//  MyDatabase.m
//  bcsapat
//
//  Created by hallgato on 1/13/14.
//  Copyright (c) 2014 hallgato. All rights reserved.
//

#import "MyDatabase.h"

@implementation MyDatabase

-(sqlite3 *)getDatabase{
    return database;
}

//betölti az adatbázist
//TODO: le kell kezelni h ha nem éri el az adatbázist akkor hozzon létre egy üreset

-(id) initWithPath: (NSString *) path{
    if(self =[super init]){
        sqlite3 *dbConnection;
        if(sqlite3_open([path UTF8String], &dbConnection) != SQLITE_OK ){
            NSLog(@"SQLITE Unable to open Db!");
            return nil;
        }
        database = dbConnection;
    }
    return self;
}

//lefuttatja a query-t és visszatér az eredménnyel
-(NSArray *) performQuery: (NSString *) query{
    sqlite3_stmt *statement = nil;
    const char * sql = [query UTF8String];
    if( sqlite3_prepare_v2(database, sql, -1, &statement, NULL) != SQLITE_OK){
        NSLog(@"SQLITE Error with query");
    }else{
        NSMutableArray * result= [NSMutableArray array];
        while (sqlite3_step(statement) == SQLITE_ROW) {
            NSMutableDictionary * row = [NSMutableDictionary dictionary];
            for (int i=0; i<sqlite3_column_count(statement); ++i) {
                int colType = sqlite3_column_type(statement, i);
                NSString * colName = [NSString stringWithUTF8String: sqlite3_column_name(statement, i)];
                id value;
                switch (colType) {
                    case SQLITE_TEXT: {
                        const unsigned char * col = sqlite3_column_text(statement, i);
                        value = [ NSString stringWithUTF8String:(const char*)col];
                        break;
                    }
                    case SQLITE_INTEGER: {
                        int col = sqlite3_column_int(statement, i);
                        value = [ NSNumber numberWithInt:col ];
                        break;
                    }
                    case SQLITE_FLOAT: {
                        int col = sqlite3_column_double(statement, i);
                        value = [ NSNumber numberWithInt:col ];
                        break;
                    }
                    case SQLITE_NULL:
                    default:
                    {
                        value = [ NSNull null ];
                        break;
                    }
                }
                [row setObject:value forKey:colName];
            }
            [result addObject:row];
        }
        return result;
    }
    return nil;
    
}

//teszt select
-(NSArray *)selectAllFromUser{
    NSString * query = [NSString stringWithFormat:@"SELECT * FROM user;"];
    return [self performQuery:query];
}





//bejelentkezés:
-(NSArray *)loginWithNickName:(NSString *) nickName andPassword:(NSString *) password{
    NSString * query = [NSString stringWithFormat:@"SELECT * FROM user WHERE nick_name = %@ AND password = %@;",nickName,password];
    return [self performQuery:query];
}
//ha nil->
-(NSArray *)loginWithNickName:(NSString *) nickName{
    NSString * query = [NSString stringWithFormat:@"SELECT * FROM user WHERE nick_name = %@;",nickName];
    return [self performQuery:query];
}
//ha ez is nil akkor nem jó a felhasználónév, ha nem nil, akkor helytelen a jelszó

//user beszúrása
-(NSArray *)insertIntoUserTableWithId:(NSInteger *) identifier andWithNickName:(NSString *) nickname andWithPassword:(NSString *) pw andWithType:(NSInteger *) type{
    NSString * query = [NSString stringWithFormat:@"INSERT INTO user VALUES(%d,'%@','%@',%d,datetime('now'));",(int)identifier,nickname,pw,(int)type];
    return [self performQuery:query];
}
//user updatelése
-(NSArray *)updateUserWithUserId:(NSInteger *) userId andNickName:(NSString *) nickName andPassword:(NSString *) password andType:(NSString *) type{
    NSString *query =
	[NSString stringWithFormat:@"UPDATE user SET nick_name = '%@', password = '%@', type = %@, last_update = datetime('now') WHERE id = %d;",nickName,password,type,(int)userId];
    return [self performQuery:query];
}

//felhasználó jelszavának módosítása
-(NSArray *)updatePassword:(NSString *) newPassword withUserId:(NSInteger *) userId{
    NSString *query = [NSString stringWithFormat:@"UPDATE user SET password = '%@' WHERE id = %d;",newPassword,(int)userId];
    return [self performQuery:query];
}

//kedvencek helyek listája
-(NSArray *)favoriteClubsWithUserId:(NSInteger *) userId{
    NSString *query = [NSString stringWithFormat:@"SELECT club.* FROM user INNER JOIN favorite ON user.id = favorite.user_id INNER JOIN club ON favorite.club_id = club.id WHERE favorite.user_id = %d ORDER BY club.highlight_expire DESC, club.name;",(int)userId];
    return [self performQuery:query];
}

//saját helyek listája
-(NSArray *)ownClubsWithUserId:(NSInteger *) userId{
    NSString *query = [NSString stringWithFormat:@"SELECT club.* FROM user INNER JOIN owner ON user.id = owner.user_id INNER JOIN club ON owner.club_id = club.id WHERE owner.user_id = %d ORDER BY club.highlight_expire DESC, club.name;",(int)userId];
    return [self performQuery:query];
}

//keresés a kedvencek közt
-(NSArray *)searchInFavoriteClubsWithUserId:(NSInteger *) userId andAddress:(NSString *) address andClubType:(NSString *) type andServiceList:(NSString *) service{
    NSString *query = [NSString stringWithFormat:@"SELECT DISTINCT club.* FROM user INNER JOIN favorite ON user.id = favorite.user_id INNER JOIN club ON favorite.club_id = club.id INNER JOIN service ON club.id = service.club_id	WHERE favorite.user_id = %d	AND club.address LIKE '%%%@%%' AND club.type = %@ AND service.service_name IN (%@) ORDER BY club.highlight_expire DESC, club.name;",(int)userId,address,type,service];
    return [self performQuery:query];
}
//keresés saját helyek közt
-(NSArray *)searchInOwnClubsWithUserId:(NSInteger *) userId andAddress:(NSString *) address andClubType:(NSString *) type andServiceList:(NSString *) service{
    NSString *query = [NSString stringWithFormat:@"SELECT DISTINCT club.* FROM user INNER JOIN owner ON user.id = owner.user_id INNER JOIN club ON owner.club_id = club.id INNER JOIN service ON club.id = service.club_id	WHERE owner.user_id = %d AND club.address LIKE '%%%@%%' AND club.type = %@ AND service.service_name IN (%@) ORDER BY club.highlight_expire DESC, club.name;",(int)userId,address,type,service];
    return [self performQuery:query];
}

//
//új szórakozóhely beszúrása
-(NSArray *)insertClubWithId:(NSInteger *) identifier andName:(NSString *) name andType:(NSString *) type andDescription:(NSString *) description andAddress:(NSString *) address andPhonenumber:(NSString *) phonenumber endEmail:(NSString *) email andHighlightExpire:(NSString *) highlight_expire
{
    NSString * query = [NSString stringWithFormat:@"INSERT INTO club VALUES(%d,'%@','%@','%@','%@','%@','%@','%@');",(int)identifier,name,type,description,address,phonenumber,email,highlight_expire];
    return [self performQuery:query];
}
//szórakozóhely adatainak frissítése
-(NSArray *)updateClubWithId:(NSInteger *) clubId andName:(NSString *) name andType:(NSString *) type andDescription:(NSString *) description andAddress:(NSString *) address andPhonenumber:(NSString *) phonenumber endEmail:(NSString *) email andHighlightExpire:(NSString *) highlight_expire
{
    NSString *query =
	[NSString stringWithFormat:@"UPDATE club SET name = '%@', type = '%@', description = '%@', address = '%@', phonenumber = '%@', email = '%@', highlight_expire ='%@'  WHERE id = %d;",name,type,description,address,phonenumber,email,highlight_expire,(int)clubId];
    return [self performQuery:query];
}
//szórakozóhely adatainak megtekintése
-(NSArray *)clubInformationWithId:(NSInteger *) clubId{
	NSString *query =
	[NSString stringWithFormat:@"SELECT * FROM club WHERE id = %d;",(int)clubId];
    return [self performQuery:query];
}
//szórakozóhely törlése
-(NSArray *)deleteClubWithId:(NSInteger *) identifier{
    NSString * query = [NSString stringWithFormat:@"DELETE FROM club WHERE id = %d;",(int)identifier];
    return [self performQuery:query];
}
//események listája
-(NSArray *)eventInformationWithId:(NSInteger *) eventId{
	NSString *query =
	[NSString stringWithFormat:@"SELECT * FROM event WHERE id = %d;",(int)eventId];
    return [self performQuery:query];
}
//új esemény
-(NSArray *)newEventWithId:(NSInteger *) identifier andClubID:(NSInteger *) clubId andName:(NSString *) name andDescription:(NSString *) description andStartDate:(NSString *) startDate andMusicType:(NSString *) musicType andRowImage:(NSObject*) rowImage{
	NSString *query =
	[NSString stringWithFormat:@"INSERT INTO event VALUES(%d,%d,'%@','%@','%@','%@',%@);",(int)identifier,(int)clubId,name,description,startDate,musicType,rowImage];
    return [self performQuery:query];
}
//esemény frissítése
-(NSArray *)updateEventWithId:(NSInteger *) identifier andClubID:(NSInteger *) clubId andName:(NSString *) name andDescription:(NSString *) description andStartDate:(NSString *) startDate andMusicType:(NSString *) musicType andRowImage:(NSObject*) rowImage{
    
        NSString *query =
        [NSString stringWithFormat:@"UPDATE event SET club_id = %d, name = '%@', description = '%@' , start_date = '%@' , music_type = '%@' , row_image= %@  WHERE id = %d;",(int)clubId,name,description,startDate,musicType,rowImage,(int)identifier];
        return [self performQuery:query];
    }

//esemény törlése
-(NSArray *)deleteEventWithId:(NSInteger *) identifier{
    NSString * query = [NSString stringWithFormat:@"DELETE FROM event WHERE id = %d;",(int)identifier];
    return [self performQuery:query];
}
//kedvenc hely beszúrása
-(NSArray *)newFavoriteClubWithId:(NSInteger *) identifier andUserId:(NSInteger *) userId andClubID:(NSInteger *) clubId{
        NSString *query =
        [NSString stringWithFormat:@"INSERT INTO favorite VALUES(%d,%d,%d);",(int)identifier,(int)userId,(int)clubId];
        return [self performQuery:query];
    }
//kedvenc hely frissítése
-(NSArray *)updateFavoriteWithId:(NSInteger *) identifier andUserId:(NSInteger *) userId andClubID:(NSInteger *) clubId{
        
            NSString *query =
            [NSString stringWithFormat:@"UPDATE favorite SET user_id = %d, club_id = %d WHERE id = %d;",(int)userId,(int)clubId,(int)identifier];
            return [self performQuery:query];
        }
//kedvenc hely törlése
-(NSArray *)deleteFavoriteWithId:(NSInteger *) identifier{
            NSString * query = [NSString stringWithFormat:@"DELETE FROM favorite WHERE id = %d;",(int)identifier];
            return [self performQuery:query];
        }
//saját hely beszúrása
-(NSArray *)newOwnClubWithClubId:(NSInteger *) clubId andUserId:(NSInteger *) userId andApproved:(NSInteger *) approved{
            NSString *query =
            [NSString stringWithFormat:@"INSERT INTO owner VALUES(%d,%d,%d);",(int)clubId,(int)userId,(int)approved];
            return [self performQuery:query];
        }
//saját hely frissítése(jóváhagyás)
-(NSArray *)updateOwnClubWithClubId:(NSInteger *) clubId andUserId:(NSInteger *) userId andApproved:(NSInteger *) approved{
            NSString *query =
            [NSString stringWithFormat:@"UPDATE owner SET approved = %d WHERE club_id = %d AND user_id = %d;",(int)approved,(int)clubId,(int)userId];
            return [self performQuery:query];
        }
//saját hely törlése
-(NSArray *)deleteOwnWithClubId:(NSInteger *) clubId andUserId:(NSInteger *) userId{
            NSString * query = [NSString stringWithFormat:@"DELETE FROM owner WHERE club_id = %d AND user_id = %d ;",(int)clubId,(int)userId];
            return [self performQuery:query];
        }
//kedvencek eseményeinek listája
-(NSArray *)favoritesEventInformationWithId:(NSInteger *) userId{
            NSString *query =
            [NSString stringWithFormat:@"SELECT event.* FROM user INNER JOIN favorite ON user.id = favorite.user_id INNER JOIN club ON favorite.club_id = club.id INNER JOIN event ON club.id = event.club_id	WHERE favorite.user_id = %d;",(int)userId];
            return [self performQuery:query];
        }
//árlista megjelenítése
-(NSArray *)pricesWithClubId:(NSInteger *) clubId{
            NSString *query =
            [NSString stringWithFormat:@"SELECT menu_item.* FROM club INNER JOIN menu_item ON club.id = menu_item.club_id  WHERE menu_item.club_id = %d;",(int)clubId];
            return [self performQuery:query];
        }
//árlista elem beszúrása
-(NSArray *)newPriceWithId:(NSInteger *) identifier andClubId:(NSInteger *) clubId andName:(NSString *) name andPrice:(NSInteger *) price andDiscount:(NSInteger *) discount andMenuCategory:(NSString *) menuCategory andMenuSort:(NSInteger *) menuSort andCurrency:(NSString *) currency andUnit:(NSString *) unit{
            NSString *query =
            [NSString stringWithFormat:@"INSERT INTO menu_item VALUES(%d,%d,'%@',%d,%d,'%@',%d,'%@','%@');",(int)identifier,(int)clubId,name,(int)price,(int)discount,menuCategory,(int)menuSort,currency,unit];
            return [self performQuery:query];
        }
//árlista elem frissítése
-(NSArray *)updatePriceWithId:(NSInteger *) identifier andClubId:(NSInteger *) clubId andName:(NSString *) name andPrice:(NSInteger *) price andDiscount:(NSInteger *) discount andMenuCategory:(NSString *) menuCategory andMenuSort:(NSInteger *) menuSort andCurrency:(NSString *) currency andUnit:(NSString *) unit{
            NSString *query =
            [NSString stringWithFormat:@"UPDATE menu_item SET club_id = %d, name = '%@' , price = %d , discount = %d , menu_category = '%@' , menu_sort = %d , currency = '%@' , unit = '%@' WHERE id = %d;",(int)clubId,name,(int)price,(int)discount,menuCategory,(int)menuSort,currency,unit,(int)identifier];
            return [self performQuery:query];
        }
//árlista elem törlése
-(NSArray *)deletePriceWithId:(NSInteger *) identifier{
            NSString * query = [NSString stringWithFormat:@"DELETE FROM menu_item WHERE id = %d ;",(int)identifier];
            return [self performQuery:query];
        }

@end
