//
//  InformationView.h
//  bcsapat
//
//  Created by hallgato on 1/16/14.
//  Copyright (c) 2014 hallgato. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MFMailComposeViewController.h>
#import <MessageUI/MessageUI.h>

@interface InformationView : UIViewController <MFMailComposeViewControllerDelegate,UIActionSheetDelegate>


- (IBAction)showActionSheet:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *clubNameText;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UISlider *slider;
@property (weak, nonatomic) IBOutlet UILabel *addressLabel;
@property (weak, nonatomic) IBOutlet UILabel *phonenumberLabel;
@property (weak, nonatomic) IBOutlet UILabel *emailLabel;
@property (weak, nonatomic) IBOutlet UITextView *descriptionView;


- (IBAction)back:(id)sender;
@end
