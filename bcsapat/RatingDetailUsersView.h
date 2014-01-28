//
//  RatingDetailUsersView.h
//  bcsapat
//
//  Created by hallgato on 1/28/14.
//  Copyright (c) 2014 hallgato. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TQStarRatingView.h"

@interface RatingDetailUsersView : UIViewController<StarRatingViewDelegate>

@property (nonatomic,strong)TQStarRatingView *starRatingView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

@property (weak, nonatomic) IBOutlet UITextView *ratingText;
@end
