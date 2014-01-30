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
    
    
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bricskok.png"]];
    
    self.tableView.backgroundView = imageView;
    
    
    [[[self navigationController] navigationBar] setTintColor:[UIColor colorWithRed:(60/255.0) green:(60/255.0) blue:(100/255.0) alpha:1.0]];
    
    [nameLabel setText:[[[Session getInstance]getActualUser]getName]];
    [emailLabel setText:[[[Session getInstance]getActualUser]getEmail]];
    [birhdayLabel setText:[[[Session getInstance]getActualUser]getBirthday]];
    [emailLabel setText:[[[Session getInstance]getActualUser]getEmail]];
    
    if ([[[Session getInstance]getActualUser]getSex]==0) {
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


- (UIView *) tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.bounds.size.width, 40)];
    UILabel *titleLabel = [ [UILabel alloc] initWithFrame:CGRectMake(0, 0, 300, 30)];
    
    if (section==0) {
        titleLabel.text = @"Név";
        
        titleLabel.textColor = [UIColor whiteColor];
        
        titleLabel.backgroundColor = [UIColor colorWithRed:154.0 green:111.0 blue:189.0 alpha:0];
        
        [headerView addSubview:titleLabel];
    }
    if (section==1) {
        titleLabel.text = @"Email";
        
        titleLabel.textColor = [UIColor whiteColor];
        
        titleLabel.backgroundColor = [UIColor colorWithRed:154.0 green:111.0 blue:189.0 alpha:0];
        
        [headerView addSubview:titleLabel];
    }
    if (section==2) {
        titleLabel.text = @"Születési dátum";
        
        titleLabel.textColor = [UIColor whiteColor];
        
        titleLabel.backgroundColor = [UIColor colorWithRed:154.0 green:111.0 blue:189.0 alpha:0];
        
        [headerView addSubview:titleLabel];
    }
    if (section==3) {
        titleLabel.text = @"Nem";
        
        titleLabel.textColor = [UIColor whiteColor];
        
        titleLabel.backgroundColor = [UIColor colorWithRed:154.0 green:111.0 blue:189.0 alpha:0];
        
        [headerView addSubview:titleLabel];
    }
    
    return headerView;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    cell.backgroundColor = [UIColor colorWithRed:(154/255.0) green:(111/255.0) blue:(189/255.0) alpha:0.5];
    //cell.backgroundColor = [UIColor colorWithRed:(47/255.0) green:(50/255.0) blue:(66/255.0) alpha:0.5];
    //cell.backgroundColor = [UIColor colorWithRed:(190/255.) green:(190/255.0) blue:(190/255.0) alpha:0.5];
}





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
                                              destructiveButtonTitle:nil otherButtonTitles:@"Szerkesztés", @"Jelszó megváltoztatása", nil];
    
    popupQuery.actionSheetStyle = UIActionSheetStyleBlackOpaque;
    [popupQuery showInView:[UIApplication sharedApplication].keyWindow];
}
- (IBAction)back:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
