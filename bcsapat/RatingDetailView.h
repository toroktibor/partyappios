//
//  RatingDetailView.h
//  bcsapat
//
//  Created by hallgato on 1/27/14.
//  Copyright (c) 2014 hallgato. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TQStarRatingView.h"
#import "MovingStars.h"

@interface RatingDetailView : UIViewController<StarMovingDelegate>

@property (nonatomic,strong)MovingStars *starRatingView;

-(void)starRatingView:(TQStarRatingView *)view score:(float)score;

- (IBAction)addRating:(id)sender;
@end
