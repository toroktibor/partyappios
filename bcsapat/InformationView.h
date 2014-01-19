//
//  InformationView.h
//  bcsapat
//
//  Created by hallgato on 1/16/14.
//  Copyright (c) 2014 hallgato. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>

@interface InformationView : UIViewController <MFMailComposeViewControllerDelegate>

- (IBAction)showEmail:(id)sender;
- (IBAction)callButtonMethod:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *clubNameText;
@end
