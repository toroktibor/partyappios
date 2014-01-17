//
//  ProfileFirstView.m
//  bcsapat
//
//  Created by hallgato on 1/10/14.
//  Copyright (c) 2014 hallgato. All rights reserved.
//

#import "ProfileFirstView.h"
#import "EditProfileView.h"
#import "ChangePasswordView.h"

@interface ProfileFirstView ()

@end

@implementation ProfileFirstView

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)showActionSheet:(id)sender {
    UIActionSheet *popupQuery = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"Mégse"
                                              destructiveButtonTitle:nil otherButtonTitles:@"Szerkesztés", @"Jelszócsere", nil];
    
    popupQuery.actionSheetStyle = UIActionSheetStyleBlackOpaque;
    [popupQuery showInView:[UIApplication sharedApplication].keyWindow];
   // popupQuery.frame = CGRectMake(0, [UIScreen mainScreen].bounds.size.height-popupQuery.frame.size.height, [UIScreen mainScreen].bounds.size.width, popupQuery.frame.size.height);
}

-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 0) {
        
        EditProfileView *EditProfileView=
        [self.storyboard instantiateViewControllerWithIdentifier:@"EditProfileView"];
        [self presentViewController:EditProfileView animated:YES completion:nil];
        
    } else if (buttonIndex == 1) {
        ChangePasswordView *ChangePasswordView=
        [self.storyboard instantiateViewControllerWithIdentifier:@"ChangePasswordView"];
         [self presentViewController:ChangePasswordView animated:YES completion:nil];
 
    }
    
    else if (buttonIndex == 2) {
        NSLog(@"Mégse");
    }
}

@end
