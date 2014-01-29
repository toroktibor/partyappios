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
#import "Club.h"
#import "TQStarRatingView.h"

@interface InformationView : UIViewController <MFMailComposeViewControllerDelegate,UIActionSheetDelegate,StarRatingViewDelegate>

- (void)showActionSheet;


@property (nonatomic,strong)TQStarRatingView *starRatingView;

@property (weak, nonatomic) IBOutlet UITextField *ratingBackground;

@property (weak, nonatomic) IBOutlet UILabel *clubNameLabel;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UISlider *slider;
@property (weak, nonatomic) IBOutlet UITextView *descriptionView;

@property Club * club;

@property (weak, nonatomic) IBOutlet UITextField *addressField;
@property (weak, nonatomic) IBOutlet UITextField *phoneField;
@property (weak, nonatomic) IBOutlet UITextField *emailField;

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
- (IBAction)back:(id)sender;

-(void)like;


@property BOOL likeOrNot;
@property UIButton *firstButton;
@property UIBarButtonItem *likeButton;
@end
