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
#import <QuartzCore/QuartzCore.h>
#import "EventEditView.h"

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
    
    UIBarButtonItem *Szerk = [[UIBarButtonItem alloc] initWithTitle:@"Szerk." style:UIBarButtonItemStyleBordered target:self action:@selector(edit)];
    UIBarButtonItem *delete = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemTrash target:self action:@selector(moveToTrash)];
    
    NSArray *actionButtonItems = @[Szerk, delete];
    self.navigationItem.rightBarButtonItems = actionButtonItems;
    
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bricskok.png"]];
	// Do any additional setup after loading the view.
    
    descriptionText.editable=NO;
    descriptionText.scrollEnabled=NO;
    descriptionText.backgroundColor=[UIColor colorWithRed:(154/255.0) green:(111/255.0) blue:(189/255.0) alpha:0.5];
    descriptionText.textColor=[UIColor whiteColor];
    
    
    int selectedIndex=[[Session getInstance]getSelectedIndex];
    Club * club=[[Session getInstance]getSelectedClubAtIndex:selectedIndex];
    
    Event * event=[[club getEvents]objectAtIndex:[[Session getInstance]getSelectedEventIndex]];
    
    User * user=[[Session getInstance]getActualUser];
    
    if (!([user isThisUserOwnerOfClub:[club getIdentifier]] || [user getType]==1))
        
        if ([[[Session getInstance]getActualUser]getType]==0) {
            self.navigationItem.rightBarButtonItems=nil;
        }
    
    
    eventDateLabel.text=[event getStartDate];
    eventDateLabel.backgroundColor=[UIColor colorWithRed:(154/255.0) green:(111/255.0) blue:(189/255.0) alpha:0.5];
    eventDateLabel.layer.cornerRadius=8;
    eventDateLabel.clipsToBounds=YES;
    
    descriptionText.text=[event getDescription];
    descriptionText.layer.cornerRadius=8;
    descriptionText.clipsToBounds = YES;
    
    
    musicTypeLabel.text=[event getMusicType];
    musicTypeLabel.backgroundColor=[UIColor colorWithRed:(154/255.0) green:(111/255.0) blue:(189/255.0) alpha:0.5];
    musicTypeLabel.layer.cornerRadius=8;
    musicTypeLabel.clipsToBounds=YES;
    
    ventNameLabel.text=[event getEventName];
    /*ventNameLabel.backgroundColor=[UIColor colorWithRed:(154/255.0) green:(111/255.0) blue:(189/255.0) alpha:0.5];
    ventNameLabel.layer.cornerRadius=8;
    ventNameLabel.clipsToBounds=YES;*/
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

-(void)edit{
    
    EventEditView *EventEditView=
    [self.storyboard instantiateViewControllerWithIdentifier:@"EventEditView"];
    [self.navigationController pushViewController:EventEditView animated:YES];
}


-(void)moveToTrash{
    
    UIAlertView * alertview = [[UIAlertView alloc] initWithTitle:@"Biztos, hogy törölni akarod?"
                                                         message:nil
                                                        delegate:self
                                               cancelButtonTitle:@"Nem"
                                               otherButtonTitles:@"Igen", nil];
    [alertview show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 0){
        NSLog(@"mégse");
    }
    else if(buttonIndex==1){
        /*NSLog(@"trash");
        NSMutableArray * menuItemsArray=[[NSMutableArray alloc]init];
        int selectedIndex=[[Session getInstance]getSelectedIndex];
        Club * club=[[Session getInstance]getSelectedClubAtIndex:selectedIndex];
        menuItemsArray=[club getMenuItems];
        
        int itemIndex=[[Session getInstance]getMenuItemIndex];
        
        MenuItem *item=[menuItemsArray objectAtIndex:itemIndex];
        
        
        [[[Session getInstance]getCommunication] removeEMenuItemWithMenuId:[item getIdentifier]];
        
        [menuItemsArray removeObjectAtIndex:itemIndex];
        
        [self.navigationController popViewControllerAnimated:YES];*/
        NSLog(@"trash");
        
        NSMutableArray * eventsArray=[[NSMutableArray alloc]init];
        int selectedIndex=[[Session getInstance]getSelectedIndex];
        Club * club=[[Session getInstance]getSelectedClubAtIndex:selectedIndex];
        
        
        eventsArray=[club getEvents];
        
        int eventIndex=[[Session getInstance]getSelectedEventIndex];
        
        Event * event=[eventsArray objectAtIndex:eventIndex];
        
        [[[Session getInstance]getCommunication]deleteEventWithID:[event getIdentifier]];
        
        [eventsArray removeObjectAtIndex:eventIndex];
        
        [self.navigationController popViewControllerAnimated:YES];
    }
    
}

@end
