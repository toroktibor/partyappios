//
//  AddNewMenuItemView.h
//  bcsapat
//
//  Created by hallgato on 1/28/14.
//  Copyright (c) 2014 hallgato. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AddNewMenuItemView : UIViewController<UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *menuItemNameText;
@property (weak, nonatomic) IBOutlet UIButton *categoryButton;
@property (weak, nonatomic) IBOutlet UIButton *changeButton;
@property (weak, nonatomic) IBOutlet UITextField *unitText;
@property (weak, nonatomic) IBOutlet UITextField *priceText;
@property (weak, nonatomic) IBOutlet UISegmentedControl *currencySegmentControl;
@property (weak, nonatomic) IBOutlet UILabel *categroyLabel;
@property int sliderValue;
@property (weak, nonatomic) IBOutlet UILabel *discountLabel;

- (IBAction)sliderValueChange:(UISlider *)sender;
- (IBAction)addMenuItem:(id)sender;

@end
//menuItemNameText,categoryButton,changeButton,unitText,priceText,currencySegmentControl,categroyLabel,sliderValue,discountLabel;