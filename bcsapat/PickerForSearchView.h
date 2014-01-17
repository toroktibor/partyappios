//
//  PickerForSearchView.h
//  bcsapat
//
//  Created by hallgato on 1/17/14.
//  Copyright (c) 2014 hallgato. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PickerForSearchView : UIViewController<UIPickerViewDataSource,UIPickerViewDelegate>

@property (weak, nonatomic) IBOutlet UIPickerView *typePicker;
@property NSArray *types;
@property NSString * result;

- (IBAction)ok:(id)sender;
@end
