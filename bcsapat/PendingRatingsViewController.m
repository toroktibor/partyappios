//
//  PendingRatingsViewController.m
//  bcsapat
//
//  Created by Remek Elek on 31/01/14.
//  Copyright (c) 2014 hallgato. All rights reserved.
//

#import "PendingRatingsViewController.h"
#import "Session.h"
#import "AdminRating.h"

@interface PendingRatingsViewController ()

@end

@implementation PendingRatingsViewController
@synthesize index;

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
    
    _RatingsArray = [[NSMutableArray alloc] init];
    
    _RatingsArray = [[[Session getInstance] getCommunication] getNotApprovedRatings];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [_RatingsArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"PendingRatingsCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    
    UIView *customColorView = [[UIView alloc] init];
    customColorView.backgroundColor = [UIColor colorWithRed:154/255.0
                                                      green:111/255.0
                                                       blue:189/255.0
                                                      alpha:0.5];
    
    UIView *design = [[UIView alloc] init];
    design.backgroundColor = [UIColor colorWithRed:60/255.0
                                             green:60/255.0
                                              blue:100/255.0
                                             alpha:0.5];
    
    
    cell.textLabel.lineBreakMode = NSLineBreakByWordWrapping; // Pre-iOS6 use UILineBreakModeWordWrap
    cell.textLabel.numberOfLines = 0;  // 0 means no max.
    
    cell.detailTextLabel.lineBreakMode = NSLineBreakByWordWrapping; // Pre-iOS6 use UILineBreakModeWordWrap
    cell.detailTextLabel.numberOfLines = 0;  // 0 means no max.
      
    cell.backgroundView = design;
    cell.selectedBackgroundView =  customColorView;
    
    cell.textLabel.textColor=[UIColor whiteColor];
    cell.detailTextLabel.textColor=[UIColor whiteColor];
    
    cell.textLabel.text=[[_RatingsArray objectAtIndex:indexPath.row] getuserName];
    cell.detailTextLabel.text=[[_RatingsArray objectAtIndex:indexPath.row] getComment];
    
    return cell;
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
    
    index=indexPath.row;
    
    UIAlertView *Notpermitted=[[UIAlertView alloc] initWithTitle:@"Jóváhagyás"
                                                         message:@"Biztosan jóváhagyod az értékelést?"
                                                        delegate:self cancelButtonTitle:@"Mégse"
                                               otherButtonTitles:@"Igen",@"Nem",nil];
    [Notpermitted show];
    
    
}


- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 0){
        NSLog(@"mégse");
    }
    else if(buttonIndex==1){
        NSLog(@"igen");
        [[[Session getInstance]getCommunication] acceptRatingWithUserId:[[_RatingsArray objectAtIndex:index] getUserId] andClubId:[[_RatingsArray objectAtIndex:index] getClubId]];
        [_RatingsArray removeObjectAtIndex:index];
        [self.tableView reloadData];
        [self.tableView setNeedsDisplay];
    }
    else if (buttonIndex==2){
        NSLog(@"nem");
        [[[Session getInstance]getCommunication] declineRatingWithUserId:[[_RatingsArray objectAtIndex:index]getUserId] andClubId:[[_RatingsArray objectAtIndex:index]getClubId]];
        [_RatingsArray removeObjectAtIndex:index];
        [self.tableView reloadData];
        [self.tableView setNeedsDisplay];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 150;
    
}

@end
