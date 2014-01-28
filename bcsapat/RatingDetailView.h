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

@interface RatingDetailView : UIViewController<StarMovingDelegate,UITextViewDelegate>

@property (nonatomic,strong)MovingStars *starRatingView;
@property (strong, nonatomic) IBOutlet UITextView *ratingText;

-(void)starRatingView:(TQStarRatingView *)view score:(float)score;

@property float myScore;

- (IBAction)addRating:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *ratingButton;
@end
