//
//  ModifyClubPickerView.h
//  bcsapat
//
//  Created by hallgato on 2/2/14.
//  Copyright (c) 2014 hallgato. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ModifyClubPickerView : UIViewController<UIPickerViewDataSource,UIPickerViewDelegate>
@property (strong, nonatomic) IBOutlet UIPickerView *typePicker;
@property NSArray *types;
@property NSString * result;

@end
