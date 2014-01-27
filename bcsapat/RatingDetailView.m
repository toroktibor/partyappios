//
//  RatingDetailView.m
//  bcsapat
//
//  Created by hallgato on 1/27/14.
//  Copyright (c) 2014 hallgato. All rights reserved.
//

#import "RatingDetailView.h"

@interface RatingDetailView ()

@end

@implementation RatingDetailView
@synthesize starRatingView;

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
    
    starRatingView = [[MovingStars alloc] initWithFrame:CGRectMake(35, 65, 250, 50)
                                                numberOfStar:5];
    starRatingView.delegate = self;
 
    [self.view addSubview:starRatingView];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

