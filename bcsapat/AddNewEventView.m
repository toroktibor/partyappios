//
//  AddNewEventView.m
//  bcsapat
//
//  Created by hallgato on 1/27/14.
//  Copyright (c) 2014 hallgato. All rights reserved.
//

#import "AddNewEventView.h"
#import "Session.h"
#import "Event.h"
#import "Club.h"
#import <QuartzCore/QuartzCore.h>

@interface AddNewEventView ()

@end

@implementation AddNewEventView
@synthesize musicTypeLabel,descriptionText,eventNameText,timeLabe,timeButton,typeButton,createButton;

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
    
    eventNameText.delegate=self;
    eventNameText.backgroundColor=[UIColor colorWithRed:(154/255.0) green:(111/255.0) blue:(189/255.0) alpha:0.5];
    
    descriptionText.delegate=self;
    descriptionText.scrollEnabled=NO;
    descriptionText.backgroundColor=[UIColor colorWithRed:(154/255.0) green:(111/255.0) blue:(189/255.0) alpha:0.5];
    descriptionText.layer.cornerRadius = 8;
    descriptionText.clipsToBounds = YES;
    
    musicTypeLabel.text=[[Session getInstance]getMusicType];
    timeLabe.text=[[Session getInstance]getEventTime];
    
    typeButton.layer.cornerRadius = 8;
    typeButton.clipsToBounds = YES;
    
    createButton.layer.cornerRadius = 8;
    createButton.clipsToBounds = YES;
    
    timeButton.layer.cornerRadius = 8;
    timeButton.clipsToBounds = YES;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated{
    musicTypeLabel.text=[[Session getInstance]getMusicType];
    timeLabe.text=[[Session getInstance]getEventTime];
    [super viewWillAppear:animated];
}

- (IBAction)create:(id)sender {
    
    int selectedIndex=[[Session getInstance]getSelectedIndex];
    Club * club=[[Session getInstance]getSelectedClubAtIndex:selectedIndex];
    
    Event *event=[[Event alloc]initWithId:100 andName:eventNameText.text andDescription:descriptionText.text andStartDate:timeLabe.text andMusic_type:musicTypeLabel.text andApproved:1];
    
    int eventId = [[[Session getInstance] getCommunication] addEventWithClubID:[club getIdentifier] andName:[event getEventName] andDescription:[event getDescription] andStartDate:[event getStartDate] andRowImage:@"" andType:[event getMusicType]];
    
    [event setIdentifier:eventId];
    
    [club addEvent:event];
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Rendben!"
                                                    message:@"Az esemény hozzáadása megtörtént!"
                                                   delegate:nil
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles:nil];
    [alert show];
    
    [self.navigationController popViewControllerAnimated:YES];
}


- (BOOL) textFieldShouldReturn:(UITextField *)theTextField
{
    [eventNameText resignFirstResponder];
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
