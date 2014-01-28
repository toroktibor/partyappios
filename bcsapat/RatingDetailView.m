//
//  RatingDetailView.m
//  bcsapat
//
//  Created by hallgato on 1/27/14.
//  Copyright (c) 2014 hallgato. All rights reserved.
//

#import "RatingDetailView.h"
#import "Club.h"
#import "Session.h"
#import "Rating.h"
#import "User.h"

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
    
    starRatingView = [[MovingStars alloc] initWithFrame:CGRectMake(50, 15, 230, 45)
                                                numberOfStar:5];
    starRatingView.delegate = self;
 
    [self.view addSubview:starRatingView];
    

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)starRatingView:(TQStarRatingView *)view score:(float)score{
    
    float myScore=((int)((score*10)+0.5))/2.0;
    NSLog(@"%f",myScore);
    
    //NSLog(@"%@,",[NSString stringWithFormat:@"%0.2f",score * 10 ]);
}

- (IBAction)addRating:(id)sender {
    
    User * user=[[Session getInstance]getActualUser];
    
    Rating * newRating=[[Rating alloc]initWithUserName:[user getName] andValue:4 andComment:@"Nagyon szar hely"];
    
    int selectedIndex=[[Session getInstance]getSelectedIndex];
    Club * club=[[Session getInstance]getSelectedClubAtIndex:selectedIndex];
    [club setRatings:newRating];
    
    
}

@end

