//
//  RatingDetailUsersView.m
//  bcsapat
//
//  Created by hallgato on 1/28/14.
//  Copyright (c) 2014 hallgato. All rights reserved.
//

#import "RatingDetailUsersView.h"
#import "Session.h"
#import "Club.h"
#import "Rating.h"
#import <QuartzCore/QuartzCore.h>

@interface RatingDetailUsersView ()

@end

@implementation RatingDetailUsersView
@synthesize starRatingView,nameLabel,ratingText;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bricskok.png"]];
    
    int selectedIndex=[[Session getInstance]getSelectedIndex];
    Club * club=[[Session getInstance]getSelectedClubAtIndex:selectedIndex];
    
    NSMutableArray * ratningsArray=[club getRatings];
    
    Rating * rating=[ratningsArray objectAtIndex:[[Session getInstance]getSelectedRatingIndex]];
    
    nameLabel.text=[NSString stringWithFormat:@"%@ értékelése",rating.getuserName];
    ratingText.text=rating.getComment;
    ratingText.backgroundColor=[UIColor colorWithRed:(154/255.0) green:(111/255.0) blue:(189/255.0) alpha:0.5];
    ratingText.editable=NO;
    ratingText.layer.cornerRadius = 8;
    ratingText.clipsToBounds = YES;
    
    starRatingView = [[TQStarRatingView alloc] initWithFrame:CGRectMake(45, 65, 230, 45)
                                                numberOfStar:5];
    starRatingView.delegate = self;
    
    [starRatingView setScore:[rating getValue]/10.0 withAnimation:NO];
    [self.view addSubview:starRatingView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
