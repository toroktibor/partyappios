//
//  DatePickerForEventsView.h
//  bcsapat
//
//  Created by hallgato on 1/29/14.
//  Copyright (c) 2014 hallgato. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DatePickerForEventsView : UIViewController
@property (weak, nonatomic) IBOutlet UIDatePicker *datePicker;
@property NSDateFormatter *df;
@property NSString * result;

- (IBAction)valueChanged:(id)sender;
@end
