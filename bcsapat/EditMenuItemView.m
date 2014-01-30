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
#import <QuartzCore/QuartzCore.h>

@interface EditMenuItemView ()

@end

@implementation EditMenuItemView
@synthesize menuItemNameText,categoryButton,changeButton,unitText,priceText,currencySegmentControl,categroyLabel,sliderValue,discountLabel;


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
    
    
    UIImage *thumbImage = [UIImage imageNamed:@"thumb.png"];
    [[UISlider appearance] setThumbImage:thumbImage
                                forState:UIControlStateNormal];
    
    
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"website-background-1024x576.jpg"]];
    
    changeButton.layer.cornerRadius = 8;
    changeButton.clipsToBounds = YES;
    
    categoryButton.layer.cornerRadius = 8;
    categoryButton.clipsToBounds = YES;
    
    menuItemNameText.backgroundColor=[UIColor colorWithRed:(154/255.0) green:(111/255.0) blue:(189/255.0) alpha:0.5];
    menuItemNameText.textColor=[UIColor whiteColor];
    
    unitText.backgroundColor=[UIColor colorWithRed:(154/255.0) green:(111/255.0) blue:(189/255.0) alpha:0.5];
    unitText.textColor=[UIColor whiteColor];
    
    priceText.backgroundColor=[UIColor colorWithRed:(154/255.0) green:(111/255.0) blue:(189/255.0) alpha:0.5];
    priceText.textColor=[UIColor whiteColor];
    
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
    categroyLabel.text=[[Session getInstance]getMenuItemCategory];
    
    
    
    
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
    
    if ([currencySegmentControl selectedSegmentIndex]==0) {
        [[[[[Session getInstance]getSelectedClubAtIndex:selectedIndex]getMenuItems]objectAtIndex:itemIndex]setMenuItemCurreny:@"HUF"];
    }
    else{
        [[[[[Session getInstance]getSelectedClubAtIndex:selectedIndex]getMenuItems]objectAtIndex:itemIndex]setMenuItemCurreny:@"EUR"];
    }
    
    MenuItem * modifyMenuItem = [[[[Session getInstance]getSelectedClubAtIndex:selectedIndex]getMenuItems]objectAtIndex:itemIndex];
    [[[Session getInstance] getCommunication] updateAMenuItemWithMenuItem:modifyMenuItem];
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Rendben!"
                                                    message:@"A tétel adatinak a frissítése megtörtént!"
                                                   delegate:nil
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles:nil];
    [alert show];

    
}



- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}



- (IBAction)sliderValueChange:(UISlider *)sender {
    
    discountLabel.text=[NSString stringWithFormat:@"%d%%",(int)sender.value];
    sliderValue=(int)sender.value;
}


-(void)viewWillAppear:(BOOL)animated{
    
    categroyLabel.text=[[Session getInstance]getMenuItemCategory];
    [super viewWillAppear:animated];
}

@end
