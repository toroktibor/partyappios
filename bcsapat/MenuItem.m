//
//  MenuItem.m
//  bcsapat
//
//  Created by hallgato on 1/13/14.
//  Copyright (c) 2014 hallgato. All rights reserved.
//

#import "MenuItem.h"

@implementation MenuItem

- (id)initWithId:(NSInteger *) identifier_ andName:(NSString *) name_ andPrice:(NSInteger *) price_ andCurrency:(NSString *) currency_ andUnit:(NSString *) unit_ andDiscount:(NSInteger *) discount_ andMenuCategory:(NSString *) menu_category_ andMenuSort:(NSInteger *) menu_sort_
{
    self = [super init];
    if(self)
    {
        identifier = identifier_;
        name = name_;
        price = price_;
        currency = currency_;
        unit = unit_;
        discount = discount_;
        menu_category = menu_category_;
        menu_sort = menu_sort_;
    }
    return self;
}
@end
