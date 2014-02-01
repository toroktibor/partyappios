//
//  DatePickerForEventsView.m
//  bcsapat
//
//  Created by hallgato on 1/29/14.
//  Copyright (c) 2014 hallgato. All rights reserved.
//

#import "DatePickerForEventsView.h"
#import "Session.h"

@interface DatePickerForEventsView ()

@end

@implementation DatePickerForEventsView
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
    
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bricskok.png"]];
	// Do any additional setup after loading the view.
    
    df = [[NSDateFormatter alloc] init];
    [df setDateFormat:@"yyyy-MM-dd HH:mm"];
    //df.dateStyle = NSDateFormatterFullStyle;
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)valueChanged:(id)sender {
	result =  [NSString stringWithFormat:@"%@",[df stringFromDate:[datePicker date]]];
	NSLog(@"%@",result);
    [[Session getInstance]setEventTime:result];
}
@end
