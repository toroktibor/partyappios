//
//  DatePickerForEditProfileView.m
//  bcsapat
//
//  Created by hallgato on 1/30/14.
//  Copyright (c) 2014 hallgato. All rights reserved.
//

#import "DatePickerForEditProfileView.h"
#import "Session.h"

@interface DatePickerForEditProfileView ()

@end

@implementation DatePickerForEditProfileView
@synthesize datePicker,df,result;

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
    
    df = [[NSDateFormatter alloc] init];
    [df setDateFormat:@"yyyy-MM-dd"];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)changeDate:(id)sender {
    
    result =  [NSString stringWithFormat:@"%@",[df stringFromDate:[datePicker date]]];
	NSLog(@"%@",result);
    [[[Session getInstance]getActualUser]setBirthday:result];
}
@end
