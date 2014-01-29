//
//  EventDetailView.m
//  bcsapat
//
//  Created by hallgato on 1/26/14.
//  Copyright (c) 2014 hallgato. All rights reserved.
//

#import "EventDetailView.h"
#import "Session.h"
#import "Club.h"
#import "Event.h"

@interface EventDetailView ()

@end

@implementation EventDetailView
@synthesize eventDateLabel,descriptionText,musicTypeLabel,ventNameLabel;

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
    
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bricskok.png"]];
	// Do any additional setup after loading the view.
    
    descriptionText.editable=NO;
    descriptionText.scrollEnabled=NO;
    descriptionText.backgroundColor=[UIColor colorWithRed:(154/255.0) green:(111/255.0) blue:(189/255.0) alpha:0];
    descriptionText.textColor=[UIColor whiteColor];
    
    
    int selectedIndex=[[Session getInstance]getSelectedIndex];
    Club * club=[[Session getInstance]getSelectedClubAtIndex:selectedIndex];
    
    Event * event=[[club getEvents]objectAtIndex:[[Session getInstance]getSelectedEventIndex]];
    
    eventDateLabel.text=[event getStartDate];
    descriptionText.text=[event getDescription];
    musicTypeLabel.text=[event getMusicType];
    ventNameLabel.text=[event getEventName];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated{
    
    int selectedIndex=[[Session getInstance]getSelectedIndex];
    Club * club=[[Session getInstance]getSelectedClubAtIndex:selectedIndex];
    
    Event * event=[[club getEvents]objectAtIndex:[[Session getInstance]getSelectedEventIndex]];
    
    eventDateLabel.text=[event getStartDate];
    descriptionText.text=[event getDescription];
    musicTypeLabel.text=[event getMusicType];
    ventNameLabel.text=[event getEventName];
    
}

@end
