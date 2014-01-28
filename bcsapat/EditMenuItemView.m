//
//  EditMenuItemView.m
//  bcsapat
//
//  Created by hallgato on 1/28/14.
//  Copyright (c) 2014 hallgato. All rights reserved.
//

#import "EditMenuItemView.h"
#import "Club.h"
#import "MenuItem.h"
#import "Session.h"

@interface EditMenuItemView ()

@end

@implementation EditMenuItemView
@synthesize menuItemNameText,categoryButton,changeButton,unitText,priceText,currencySegmentControl,categroyLabel,sliderValue;


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
    
    
    menuItemNameText.delegate=self;
    unitText.delegate=self;
    priceText.delegate=self;
    
    NSMutableArray * menuItemsArray=[[NSMutableArray alloc]init];
    
    int selectedIndex=[[Session getInstance]getSelectedIndex];
    Club * club=[[Session getInstance]getSelectedClubAtIndex:selectedIndex];
    
    menuItemsArray=[club getMenuItems];
    
    int itemIndex=[[Session getInstance]getMenuItemIndex];
    
    MenuItem *item=[menuItemsArray objectAtIndex:itemIndex];
    
    menuItemNameText.text=item.getMenuItemName;
    unitText.text=item.getUnit;
    priceText.text=[NSString stringWithFormat:@"%d",item.getPrice];
    
    
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)changeMenuItem:(id)sender {
    
    int selectedIndex=[[Session getInstance]getSelectedIndex];
    int itemIndex=[[Session getInstance]getMenuItemIndex];
    
    [[[[[Session getInstance]getSelectedClubAtIndex:selectedIndex]getMenuItems]objectAtIndex:itemIndex]setMenuItemName:menuItemNameText.text];

    NSString *price=priceText.text;
    [[[[[Session getInstance]getSelectedClubAtIndex:selectedIndex]getMenuItems]objectAtIndex:itemIndex]setMenuItemPrice:[price intValue]];
    
    [[[[[Session getInstance]getSelectedClubAtIndex:selectedIndex]getMenuItems]objectAtIndex:itemIndex]setMenuItemUnit:unitText.text];
    
    [[[[[Session getInstance]getSelectedClubAtIndex:selectedIndex]getMenuItems]objectAtIndex:itemIndex]setMenuItemCategory:categroyLabel.text];
    
    [[[[[Session getInstance]getSelectedClubAtIndex:selectedIndex]getMenuItems]objectAtIndex:itemIndex]setMenuItemDiscount:sliderValue];
    
}



- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}



- (IBAction)sliderValueChange:(UISlider *)sender {
    
    sliderValue=(int)sender.value;
}
@end
