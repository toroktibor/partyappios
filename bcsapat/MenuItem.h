//
//  MenuItem.h
//  bcsapat
//
//  Created by hallgato on 1/13/14.
//  Copyright (c) 2014 hallgato. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MenuItem : NSObject{
    int identifier;
    NSString * name;
    int price;
    NSString * currency;
    NSString * unit;
    int discount;
    NSString * menu_category;
    int menu_sort;
}

- (id)initWithId:(int) identifier_ andName:(NSString *) name_ andPrice:(int) price_ andCurrency:(NSString *) currency_ andUnit:(NSString *) unit_ andDiscount:(int) discount_ andMenuCategory:(NSString *) menu_category_ andMenuSort:(int) menu_sort_;

-(NSString *)getMenuItemName;

-(NSString *)getCurrency;

-(int)getPrice;

-(NSString *)getUnit;

-(int)getDiscount;

-(NSString *)getMenuItemCategory;

@end
