//
//  ModifyClubInfoView.h
//  bcsapat
//
//  Created by hallgato on 2/1/14.
//  Copyright (c) 2014 hallgato. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ModifyClubInfoView : UITableViewController<UITextFieldDelegate,UITextViewDelegate>
- (IBAction)back:(id)sender;

@property (weak, nonatomic) IBOutlet UITextField *nameText;
@property (weak, nonatomic) IBOutlet UITextField *addressText;
@property (weak, nonatomic) IBOutlet UILabel *typeLabel;
@property (strong, nonatomic) IBOutlet UITextField *emailText;
@property (strong, nonatomic) IBOutlet UITextField *phoneText;
@property (strong, nonatomic) IBOutlet UITextView *descriptionText;


@property BOOL liveMusicSelected;
@property BOOL sportBroadcastSelected;
@property BOOL snookerSelected;
@property BOOL danceSelected;
@property BOOL wifiSelected;
@property BOOL BowlingSelected;
@property BOOL DartsSelected;
@property BOOL DjSelected;
@property BOOL FoodSelected;
@property BOOL coctailBarSelected;


@end

