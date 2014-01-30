//
//  DatePickerForRegisterView.m
//  bcsapat
//
//  Created by hallgato on 1/30/14.
//  Copyright (c) 2014 hallgato. All rights reserved.
//

#import "DatePickerForRegisterView.h"
#import "Session.h"
#import <QuartzCore/QuartzCore.h>

@interface DatePickerForRegisterView ()

@end

@implementation DatePickerForRegisterView
@synthesize df,datePicker,result,okButton;

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
    
    okButton.layer.cornerRadius = 8;
    okButton.clipsToBounds = YES;
    
    df = [[NSDateFormatter alloc] init];
    [df setDateFormat:@"yyyy-MM-dd"];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (IBAction)valueChange:(id)sender {
    result =  [NSString stringWithFormat:@"%@",[df stringFromDate:[datePicker date]]];
	NSLog(@"%@",result);
    [[Session getInstance]setBirthDay:result];
}

- (IBAction)back:(id)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
