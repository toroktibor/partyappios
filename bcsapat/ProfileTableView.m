//
//  ProfileTableView.m
//  bcsapat
//
//  Created by hallgato on 1/22/14.
//  Copyright (c) 2014 hallgato. All rights reserved.
//

#import "ProfileTableView.h"
#import "ChangePasswordView.h"
#import "EditProfileView.h"
#import "Session.h"

@interface ProfileTableView ()

@end

@implementation ProfileTableView
@synthesize nameLabel,emailLabel,birhdayLabel,sexLabel,tblTable;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    [nameLabel setText:[[[Session getInstance]getActualUser]getName]];
    [emailLabel setText:[[[Session getInstance]getActualUser]getEmail]];
    [birhdayLabel setText:[[[Session getInstance]getActualUser]getBirthday]];
    [emailLabel setText:[[[Session getInstance]getActualUser]getEmail]];
    
    if ([[[Session getInstance]getActualUser]getSex]==1) {
        [sexLabel setText:@"Férfi"];
    }
    else{
        [sexLabel setText:@"Nő"];
    }
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source




/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     */
}


-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 0) {
        
        EditProfileView *EditProfileView=
        [self.storyboard instantiateViewControllerWithIdentifier:@"EditProfileView"];
        [self.navigationController pushViewController:EditProfileView animated:YES];
        
    } else if (buttonIndex == 1) {
        ChangePasswordView *ChangePasswordView=
        [self.storyboard instantiateViewControllerWithIdentifier:@"ChangePasswordView"];
        [self.navigationController pushViewController:ChangePasswordView animated:YES];
        
    }
    
    else if (buttonIndex == 2) {
        NSLog(@"Mégse");
    }
}

-(void)viewWillAppear:(BOOL)animated{
    [nameLabel setText:[[[Session getInstance]getActualUser]getName]];
    [emailLabel setText:[[[Session getInstance]getActualUser]getEmail]];
    [birhdayLabel setText:[[[Session getInstance]getActualUser]getBirthday]];
    [emailLabel setText:[[[Session getInstance]getActualUser]getEmail]];
    
    [super viewWillAppear:animated];
    
    
}

- (IBAction)showActionSheet:(id)sender {
    
    UIActionSheet *popupQuery = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"Mégse"
                                              destructiveButtonTitle:nil otherButtonTitles:@"Szerkesztés", @"Jelszócsere", nil];
    
    popupQuery.actionSheetStyle = UIActionSheetStyleBlackOpaque;
    [popupQuery showInView:[UIApplication sharedApplication].keyWindow];
}
- (IBAction)back:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
