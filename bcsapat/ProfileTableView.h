//
//  ProfileTableView.h
//  bcsapat
//
//  Created by hallgato on 1/22/14.
//  Copyright (c) 2014 hallgato. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProfileTableView : UITableViewController<UIActionSheetDelegate>{
    
}

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *emailLabel;
@property (weak, nonatomic) IBOutlet UILabel *birhdayLabel;

@property(nonatomic, retain) UITableView *tblTable;


- (IBAction)back:(id)sender;

@end
