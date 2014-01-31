//
//  HighLighRequestView.h
//  bcsapat
//
//  Created by hallgato on 1/31/14.
//  Copyright (c) 2014 hallgato. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HighLighRequestView : UIViewController<UIPickerViewDataSource,UIPickerViewDelegate,UIAlertViewDelegate>


@property (weak, nonatomic) IBOutlet UILabel *label;
@property (weak, nonatomic) IBOutlet UIPickerView *typePicker;
@property (weak, nonatomic) IBOutlet UIButton *button;
- (IBAction)addHighLight:(id)sender;

@property NSMutableArray * types;
@property NSString *result;
@property (weak, nonatomic) IBOutlet UIScrollView *a;
@end
