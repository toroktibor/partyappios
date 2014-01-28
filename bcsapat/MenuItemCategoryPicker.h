//
//  MenuItemCategoryPicker.h
//  bcsapat
//
//  Created by hallgato on 1/28/14.
//  Copyright (c) 2014 hallgato. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MenuItemCategoryPicker : UIViewController<UIPickerViewDataSource,UIPickerViewDelegate>

@property NSArray *types;
@property NSString * result;

@property (weak, nonatomic) IBOutlet UIPickerView *typePicker;
@end
