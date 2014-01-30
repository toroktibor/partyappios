//
//  PictureView.m
//  bcsapat
//
//  Created by hallgato on 1/21/14.
//  Copyright (c) 2014 hallgato. All rights reserved.
//

#import "PictureView.h"
#import "Session.h"

@interface PictureView ()

@end

@implementation PictureView
@synthesize image,imageView;

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
    
    
    image = [[Session getInstance]getImage];
    [imageView setImage:image];
    
    UIBarButtonItem *nextButton = [[UIBarButtonItem alloc] initWithTitle:@"Következő" style:UIBarButtonItemStyleBordered target:self action:@selector(next)];
    UIBarButtonItem *prevButton = [[UIBarButtonItem alloc] initWithTitle:@"Előző" style:UIBarButtonItemStyleBordered target:self action:@selector(back)];
    
    
    
    NSArray *actionButtonItems = @[nextButton, prevButton];
    self.navigationItem.rightBarButtonItems = actionButtonItems;
   
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)handleSwipe:(UISwipeGestureRecognizer *)swipe {
    
    if (swipe.direction == UISwipeGestureRecognizerDirectionLeft) {
        NSLog(@"Left Swipe");
        
    }
    if (swipe.direction == UISwipeGestureRecognizerDirectionRight) {
        NSLog(@"Right Swipe");
        
    }
}


-(void)next{
    NSLog(@"next");
}



-(void)back{
    NSLog(@"back");
}

@end
