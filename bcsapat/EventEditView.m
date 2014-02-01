//
//  EventEditView.m
//  bcsapat
//
//  Created by hallgato on 1/27/14.
//  Copyright (c) 2014 hallgato. All rights reserved.
//

#import "EventEditView.h"
#import "Session.h"
#import "Event.h"
#import <QuartzCore/QuartzCore.h>

@interface EventEditView ()

@end

@implementation EventEditView
@synthesize musicTypeLabel,eventNameText,timeLabe,timeButton,typeButton,createButton,descriptionText;

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
    
    eventNameText.delegate=self;
    eventNameText.backgroundColor=[UIColor colorWithRed:(154/255.0) green:(111/255.0) blue:(189/255.0) alpha:0.5];
    
    descriptionText.delegate=self;
    descriptionText.scrollEnabled=NO;
    descriptionText.backgroundColor=[UIColor colorWithRed:(154/255.0) green:(111/255.0) blue:(189/255.0) alpha:0.5];
    descriptionText.layer.cornerRadius = 8;
    descriptionText.clipsToBounds = YES;
    
    
    musicTypeLabel.text=[[Session getInstance]getMusicType];
    timeLabe.text=[[Session getInstance]getEventTime];
    
    int selectedIndex=[[Session getInstance]getSelectedIndex];
    Club * club=[[Session getInstance]getSelectedClubAtIndex:selectedIndex];
    
    Event * event=[[club getEvents]objectAtIndex:[[Session getInstance]getSelectedEventIndex]];
    
    descriptionText.text=[event getDescription];
    eventNameText.text=[event getEventName];
    
    createButton.layer.cornerRadius = 8;
    createButton.clipsToBounds = YES;
    
    timeButton.layer.cornerRadius = 8;
    timeButton.clipsToBounds = YES;
    
    typeButton.layer.cornerRadius = 8;
    typeButton.clipsToBounds = YES;
    
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

- (IBAction)change:(id)sender {
    
    int selectedIndex=[[Session getInstance]getSelectedIndex];
    int seledtedEventIndex=[[Session getInstance]getSelectedEventIndex];
    
    Event * selectedEvent = [[[[Session getInstance]getSelectedClubAtIndex:selectedIndex]getEvents]objectAtIndex:seledtedEventIndex];
    
    [[[[[Session getInstance]getSelectedClubAtIndex:selectedIndex]getEvents]objectAtIndex:seledtedEventIndex]setEventName:eventNameText.text];
    [[[[[Session getInstance]getSelectedClubAtIndex:selectedIndex]getEvents]objectAtIndex:seledtedEventIndex]setStarDate:timeLabe.text];
    [[[[[Session getInstance]getSelectedClubAtIndex:selectedIndex]getEvents]objectAtIndex:seledtedEventIndex]setMusicType:musicTypeLabel.text];
    [selectedEvent setDescription:descriptionText.text];
    
    [[[Session getInstance] getCommunication] updateEventWithID:[selectedEvent getIdentifier] andName:[selectedEvent getEventName] andDescription:[selectedEvent getDescription] andStartDate:[selectedEvent getStartDate] andRowImage:@"" andType:[selectedEvent getMusicType]];
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Rendben!"
                                                    message:@"Az esemény módosítása megtörtént!"
                                                   delegate:nil
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles:nil];
    [alert show];
    
    [self.navigationController popViewControllerAnimated:YES];
}
@end
