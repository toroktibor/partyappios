//
//  MenuItem.h
//  bcsapat
//
//  Created by hallgato on 1/13/14.
//  Copyright (c) 2014 hallgato. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MenuItem : NSObject{
    NSInteger * identifier;
    NSString * name;
    NSInteger * price;
    NSString * currency;
    NSString * unit;
    NSInteger * discount;
    NSString * menu_category;
    NSInteger * menu_sort;
}

- (id)initWithId:(NSInteger *) identifier_ andName:(NSString *) name_ andPrice:(NSInteger *) price_ andCurrency:(NSString *) currency_ andUnit:(NSString *) unit_ andDiscount:(NSInteger *) discount_ andMenuCategory:(NSString *) menu_category_ andMenuSort:(NSInteger *) menu_sort_;

@end
