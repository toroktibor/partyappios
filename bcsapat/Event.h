//
//  Event.h
//  bcsapat
//
//  Created by hallgato on 1/13/14.
//  Copyright (c) 2014 hallgato. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Event : NSObject{
    NSInteger * identifier;
    NSString * name;
    NSString * description;
    NSString * start_date;
    NSString * music_type;
}

- (id)initWithId:(NSInteger *) identifier_ andName:(NSString *) name_ andDescription:(NSString *) description_ andStartDate:(NSString *) start_date_ andMusic_type:(NSString *) music_type_;

@end
