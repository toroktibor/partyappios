//
//  MenuItem.m
//  bcsapat
//
//  Created by hallgato on 1/13/14.
//  Copyright (c) 2014 hallgato. All rights reserved.
//

#import "MenuItem.h"

@implementation MenuItem

- (id)initWithId:(int) identifier_ andName:(NSString *) name_ andPrice:(int) price_ andCurrency:(NSString *) currency_ andUnit:(NSString *) unit_ andDiscount:(int) discount_ andMenuCategory:(NSString *) menu_category_ andMenuSort:(int) menu_sort_
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

-(NSString *)getMenuItemName{
    return  name;
}

-(NSString *)getCurrency{
    return currency;
}

-(int)getPrice{
    return price;
}

-(NSString *)getUnit{
    return unit;
}

-(NSString *)getMenuItemCategory{
    return menu_category;
}

-(int)getDiscount{
    return discount;
}

-(void)setMenuItemName:(NSString *)name_{
    name=name_;
}

-(void)setMenuItemPrice:(int)price_{
    price=price_;
}


-(void)setMenuItemCurreny:(NSString *)currency_{
    currency=currency_;
}


-(void)setMenuItemUnit:(NSString *)unit_{
    unit=unit_;
}

-(void)setMenuItemDiscount:(int)discount_{
    discount=discount_;
}

-(void)setMenuItemCategory:(NSString *)category{
    menu_category=category;
}










@end
