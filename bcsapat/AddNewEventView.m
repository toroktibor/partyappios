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
	// Do any additional setup after loading the view.
    
    eventNameText.delegate=self;
    descriptionText.delegate=self;
    
    musicTypeLabel.text=[[Session getInstance]getMusicType];
    timeLabe.text=[[Session getInstance]getEventTime];
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
    
    Event *event=[[Event alloc]initWithId:100 andName:eventNameText.text andDescription:descriptionText.text andStartDate:timeLabe.text andMusic_type:musicTypeLabel.text];
    
    [club addEvent:event];
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Rendben!"
                                                    message:@"Az esemény hozzáadása megtörtént!"
                                                   delegate:nil
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles:nil];
    [alert show];
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
