//
//  MenuSearchClass.h
//  bcsapat
//
//  Created by hallgato on 1/9/14.
//  Copyright (c) 2014 hallgato. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MenuSearchView : UIViewController<UIActionSheetDelegate>{

}
- (IBAction)isChecked:(id)sender;

- (IBAction)showActionSheet:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *checkButton;
@property (weak, nonatomic) IBOutlet UILabel *clubType;
@property BOOL checkBoxSelected;

@end
