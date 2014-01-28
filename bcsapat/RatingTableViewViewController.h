//
//  RatingTableViewViewController.h
//  bcsapat
//
//  Created by hallgato on 1/23/14.
//  Copyright (c) 2014 hallgato. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Session.h"
#import "Club.h"
#import "Rating.h"
#import "TQStarRatingView.h"

@interface RatingTableViewViewController : UITableViewController<StarRatingViewDelegate>

@property NSMutableArray * ratningsArray;

@property (nonatomic,strong)TQStarRatingView *starRatingView;

@end
