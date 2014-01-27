//
//  MusicTypePickerView.h
//  bcsapat
//
//  Created by hallgato on 1/27/14.
//  Copyright (c) 2014 hallgato. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MusicTypePickerView : UIViewController<UIPickerViewDataSource,UIPickerViewDelegate>


@property NSArray *types;
@property NSString * result;

@property (weak, nonatomic) IBOutlet UIPickerView *typePicker;
@end
