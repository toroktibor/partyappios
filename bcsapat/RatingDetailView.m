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
#import <QuartzCore/QuartzCore.h>

@interface RatingDetailView ()

@end

@implementation RatingDetailView
@synthesize starRatingView,myScore,ratingText,ratingButton;

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
    
    starRatingView = [[MovingStars alloc] initWithFrame:CGRectMake(50, 15, 230, 45)
                                                numberOfStar:5];
    starRatingView.delegate = self;
 
    [self.view addSubview:starRatingView];
 
    ratingText.delegate=self;
    
    ratingButton.layer.cornerRadius = 8;

    ratingButton.clipsToBounds = YES;
    
    ratingText.backgroundColor=[UIColor colorWithRed:(154/255.0) green:(111/255.0) blue:(189/255.0) alpha:0.5];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)starRatingView:(TQStarRatingView *)view score:(float)score{
    
    myScore=((int)((score*10)+0.5))/2.0;
    //NSLog(@"%f",myScore);
    
    //NSLog(@"%@,",[NSString stringWithFormat:@"%0.2f",score * 10 ]);
}

- (IBAction)addRating:(id)sender {
    
    User * user=[[Session getInstance]getActualUser];
    
    //Rating * newRating=[[Rating alloc]initWithUserName:[user getName] andValue:myScore andComment:ratingText.text];
    
    int selectedIndex=[[Session getInstance]getSelectedIndex];
    Club * club=[[Session getInstance]getSelectedClubAtIndex:selectedIndex];
    //[club setRatings:newRating];
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Rendben!"
                                                    message:@"Az értékelésed hozzáadtuk!"
                                                   delegate:nil
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles:nil];
    [alert show];

    
}


- (BOOL) textFieldShouldReturn:(UITextField *)theTextField
{
    [ratingText resignFirstResponder];
    return YES;
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if([text isEqualToString:@"\n"])
    {
        [textView resignFirstResponder];
        return NO;
    }
    return YES;
}

@end

