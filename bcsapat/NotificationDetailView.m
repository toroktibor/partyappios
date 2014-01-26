//
//  NotificationDetailView.m
//  bcsapat
//
//  Created by hallgato on 1/26/14.
//  Copyright (c) 2014 hallgato. All rights reserved.
//

#import "NotificationDetailView.h"

@interface NotificationDetailView ()

@end

@implementation NotificationDetailView

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
    
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"website-background-1024x576.jpg"]];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
