//
//  PendingOwnerRequestViewController.h
//  bcsapat
//
//  Created by Remek Elek on 31/01/14.
//  Copyright (c) 2014 hallgato. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PendingOwnerRequestViewController : UITableViewController<UIAlertViewDelegate>

@property (strong,nonatomic) NSMutableArray * OwnerRequestsArray;
@property int index;

@end
