//
//  InfoAboutTheApplicationView.m
//  bcsapat
//
//  Created by hallgato on 1/23/14.
//  Copyright (c) 2014 hallgato. All rights reserved.
//

#import "InfoAboutTheApplicationView.h"

@interface InfoAboutTheApplicationView ()

@end

@implementation InfoAboutTheApplicationView
@synthesize informationText;

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
    
    informationText.editable=NO;
    informationText.backgroundColor=[UIColor colorWithRed:(154/255.0) green:(111/255.0) blue:(189/255.0) alpha:0];
    informationText.textColor=[UIColor whiteColor];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)back:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
