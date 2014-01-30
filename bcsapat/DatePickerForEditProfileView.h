//
//  DatePickerForEditProfileView.h
//  bcsapat
//
//  Created by hallgato on 1/30/14.
//  Copyright (c) 2014 hallgato. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DatePickerForEditProfileView : UIViewController

@property (weak, nonatomic) IBOutlet UIDatePicker *datePicker;
- (IBAction)changeDate:(id)sender;

@property NSDateFormatter *df;
@property NSString * result;
@end
