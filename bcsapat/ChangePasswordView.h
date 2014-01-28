//
//  ChangePasswordView.h
//  bcsapat
//
//  Created by hallgato on 1/17/14.
//  Copyright (c) 2014 hallgato. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ChangePasswordView : UIViewController<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *oldPasswordTextField;
@property (weak, nonatomic) IBOutlet UITextField *actualPasswordTextField;
@property (weak, nonatomic) IBOutlet UITextField *actualPasswordAgaingTextField;

- (IBAction)changePassword:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *changeButton;
@end
