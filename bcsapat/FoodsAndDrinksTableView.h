//
//  FoodsAndDrinksTableView.h
//  bcsapat
//
//  Created by hallgato on 1/22/14.
//  Copyright (c) 2014 hallgato. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FoodsAndDrinksTableView : UITableViewController

@property NSMutableArray * menuItemsArray;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *addNewMenuItem;

@end
