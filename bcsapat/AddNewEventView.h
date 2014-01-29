//
//  AddNewEventView.h
//  bcsapat
//
//  Created by hallgato on 1/27/14.
//  Copyright (c) 2014 hallgato. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AddNewEventView : UIViewController<UITextFieldDelegate,UITextViewDelegate>
@property (weak, nonatomic) IBOutlet UILabel *musicTypeLabel;
@property (strong, nonatomic) IBOutlet UITextView *descriptionText;
@property (weak, nonatomic) IBOutlet UITextField *eventNameText;
@property (weak, nonatomic) IBOutlet UILabel *timeLabe;

@property (weak, nonatomic) IBOutlet UIButton *timeButton;
@property (weak, nonatomic) IBOutlet UIButton *typeButton;
@property (weak, nonatomic) IBOutlet UIButton *createButton;


- (IBAction)create:(id)sender;
@end
