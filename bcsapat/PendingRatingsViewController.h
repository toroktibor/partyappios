//
//  PendingRatingsViewController.h
//  bcsapat
//
//  Created by Remek Elek on 31/01/14.
//  Copyright (c) 2014 hallgato. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PendingRatingsViewController : UITableViewController<UIAlertViewDelegate>

@property (strong,nonatomic) NSMutableArray * RatingsArray;
@property int index;

@end
