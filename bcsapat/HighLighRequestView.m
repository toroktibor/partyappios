//
//  HighLighRequestView.m
//  bcsapat
//
//  Created by hallgato on 1/31/14.
//  Copyright (c) 2014 hallgato. All rights reserved.
//

#import "HighLighRequestView.h"
#import "Session.h"
#import "Club.h"
#import <QuartzCore/QuartzCore.h>

@interface HighLighRequestView ()

@end

@implementation HighLighRequestView
@synthesize label,button,typePicker,types,result,a;

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
    
    types=[[NSMutableArray alloc] init];
    
    for (int i=1; i<=365; ++i) {
        [types addObject:[NSString stringWithFormat:@"%d",i]];
    }
    
    typePicker.delegate = self;
    typePicker.dataSource = self;
    typePicker.showsSelectionIndicator = YES;
    
    button.layer.cornerRadius = 8;
    button.clipsToBounds = YES;
   
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)addHighLight:(id)sender {
    
    UIAlertView *Notpermitted=[[UIAlertView alloc] initWithTitle:@"A kiemelés kérése megtörtént!"
                                                         message:nil
                                                        delegate:self cancelButtonTitle:@"Ok"
                                               otherButtonTitles:nil];
    [Notpermitted show];

}


//meg mondja hány oszlopból tudjunk választani
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}


//megmondja hány lehetőség közül lehet választani
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return types.count;
}

//pick a lehetőségek közül
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    NSString * picked = nil;
    
    for (int i=0; i<types.count; ++i) {
        if (i==row) {
            picked=[types objectAtIndex:i];
        }
    }
    
    return picked;
}

//a result válozóban elhelyezzük a pickelt lehetőséget
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    
    result = [types objectAtIndex:row];
    
}


- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    [self.a setContentSize:CGSizeMake(320, 300)];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 0){
        NSLog(@"mégse");
        int selectedIndex=[[Session getInstance]getSelectedIndex];
        Club *club=[[Session getInstance]getSelectedClubAtIndex:selectedIndex];
        
        [[[Session getInstance] getCommunication] setHighlightExpireWithClubId:[club getIdentifier] andDays:[result intValue]];
        
        [club setHighliteExpire:result];
        
        [self.navigationController popViewControllerAnimated:YES];
    } 
}

@end
