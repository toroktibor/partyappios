//
//  AppDelegate.h
//  bcsapat
//
//  Created by hallgato on 1/7/14.
//  Copyright (c) 2014 hallgato. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyDatabase.h"

@class TQViewController;

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) MyDatabase * dbConnection;


@property (strong, nonatomic) TQViewController *viewController;


@end
