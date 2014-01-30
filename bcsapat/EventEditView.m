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
    
    eventNameText.delegate=self;
    descriptionText.delegate=self;
    
    musicTypeLabel.text=[[Session getInstance]getMusicType];
    timeLabe.text=[[Session getInstance]getEventTime];
    
    int selectedIndex=[[Session getInstance]getSelectedIndex];
    Club * club=[[Session getInstance]getSelectedClubAtIndex:selectedIndex];
    
    Event * event=[[club getEvents]objectAtIndex:[[Session getInstance]getSelectedEventIndex]];
    
    descriptionText.text=[event getDescription];
    eventNameText.text=[event getEventName];
    
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
    
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Rendben!"
                                                    message:@"Az esemény módosítása megtörtént!"
                                                   delegate:nil
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles:nil];
    [alert show];
}
@end
