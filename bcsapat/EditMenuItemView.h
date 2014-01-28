//
//  EditMenuItemView.h
//  bcsapat
//
//  Created by hallgato on 1/28/14.
//  Copyright (c) 2014 hallgato. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EditMenuItemView : UIViewController<UITextFieldDelegate>

@property int sliderValue;

@property (weak, nonatomic) IBOutlet UITextField *menuItemNameText;
@property (weak, nonatomic) IBOutlet UIButton *categoryButton;

@property (weak, nonatomic) IBOutlet UITextField *priceText;
@property (weak, nonatomic) IBOutlet UITextField *unitText;

- (IBAction)changeMenuItem:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *changeButton;

@property (weak, nonatomic) IBOutlet UISegmentedControl *currencySegmentControl;
@property (weak, nonatomic) IBOutlet UILabel *categroyLabel;

- (IBAction)sliderChangeValue:(id)sender;
- (IBAction)sliderValueChange:(UISlider *)sender;
@end
