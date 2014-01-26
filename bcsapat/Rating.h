//
//  Rating.h
//  bcsapat
//
//  Created by hallgato on 1/13/14.
//  Copyright (c) 2014 hallgato. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Rating : NSObject{
    NSString * userName;
    NSNumber * value;
    NSString * comment;
}

-(NSString *)getuserName;

-(NSString *)getComment;

@end
