//
//  DatePickerForRegisterView.h
//  bcsapat
//
//  Created by hallgato on 1/30/14.
//  Copyright (c) 2014 hallgato. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DatePickerForRegisterView : UIViewController
- (IBAction)valueChange:(id)sender;

- (IBAction)back:(id)sender;
@property (weak, nonatomic) IBOutlet UIDatePicker *datePicker;
@property (weak, nonatomic) IBOutlet UIButton *okButton;
@property NSDateFormatter *df;
@property NSString * result;
/*@property (weak, nonatomic) IBOutlet UIButton *okButton;

- (IBAction)back:(id)sender;
@property (weak, nonatomic) IBOutlet UIDatePicker *datePicker;
- (IBAction)valueChange:(id)sender;*/
@end
