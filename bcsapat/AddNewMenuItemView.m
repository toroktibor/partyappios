//
//  AddNewMenuItemView.m
//  bcsapat
//
//  Created by hallgato on 1/28/14.
//  Copyright (c) 2014 hallgato. All rights reserved.
//

#import "AddNewMenuItemView.h"
#import <QuartzCore/QuartzCore.h>
#import "Session.h"
#import "Club.h"
#import "MenuItem.h"

@interface AddNewMenuItemView ()

@end

@implementation AddNewMenuItemView
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
    
    
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bricskok.png"]];
    
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
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}



-(void)viewWillAppear:(BOOL)animated{
    
    categroyLabel.text=[[Session getInstance]getMenuItemCategory];
    [super viewWillAppear:animated];
}

- (IBAction)sliderValueChange:(UISlider *)sender {
    
    discountLabel.text=[NSString stringWithFormat:@"%d%%",(int)sender.value];
    sliderValue=(int)sender.value;
}

- (IBAction)addMenuItem:(id)sender {
    
    int selectedIndex=[[Session getInstance]getSelectedIndex];
    Club * club=[[Session getInstance]getSelectedClubAtIndex:selectedIndex];
    
    NSString *price=priceText.text;
    
    MenuItem * menuItem;
    
    if ([currencySegmentControl selectedSegmentIndex]==0) {
        menuItem=[[MenuItem alloc]initWithId:100 andName:menuItemNameText.text andPrice:[price intValue]
                                 andCurrency:@"HUF" andUnit:unitText.text andDiscount:sliderValue andMenuCategory:categroyLabel.text andMenuSort:1];
        
    }
    else{
        menuItem=[[MenuItem alloc]initWithId:100 andName:menuItemNameText.text andPrice:[price intValue]
                                 andCurrency:@"EUR" andUnit:unitText.text andDiscount:sliderValue andMenuCategory:categroyLabel.text andMenuSort:1];
    }
    
    int menuItemId = [[[Session getInstance] getCommunication] addANewMenuItemWithClubId:[club getIdentifier] andMenuItem:menuItem];
    
    NSLog(@"%d menu item id",menuItemId);
    
    [menuItem setIdentifier:menuItemId];
    
    [club addMenuItem:menuItem];
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Rendben!"
                                                    message:@"A tétel hozzáadása megtörtént!"
                                                   delegate:nil
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles:nil];
    [alert show];
}
@end
