//
//  RatingTableViewViewController.m
//  bcsapat
//
//  Created by hallgato on 1/23/14.
//  Copyright (c) 2014 hallgato. All rights reserved.
//

#import "RatingTableViewViewController.h"
#import "Session.h"
#import "Club.h"
#import "Rating.h"
#import "TQStarRatingView.h"
#import "RatingDetailUsersView.h"



@interface RatingTableViewViewController ()

@end

@implementation RatingTableViewViewController
@synthesize starRatingView;

@synthesize ratningsArray;

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
    
    ratningsArray = [[NSMutableArray alloc]init];
    
    int selectedIndex=[[Session getInstance]getSelectedIndex];
    Club * club=[[Session getInstance]getSelectedClubAtIndex:selectedIndex];
    
    ratningsArray=[club getRatings];
    
    
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bricskok.png"]];
    self.tableView.backgroundView = imageView;
    
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
    return [ratningsArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"RatingCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    
    
    UIView *customColorView = [[UIView alloc] init];
    customColorView.backgroundColor = [UIColor colorWithRed:154/255.0
                                                      green:111/255.0
                                                       blue:189/255.0
                                                      alpha:0.5];
    cell.selectedBackgroundView =  customColorView;
    
    
    cell.textLabel.textColor=[UIColor whiteColor];
    cell.detailTextLabel.textColor=[UIColor whiteColor];
    
    
    Rating * actualRating=[ratningsArray objectAtIndex:indexPath.row];
    
    cell.textLabel.text=[actualRating getuserName];
    cell.detailTextLabel.text=[actualRating getComment];
    
    starRatingView = [[TQStarRatingView alloc] initWithFrame:CGRectMake(0, 0, 67, 12)
                                                numberOfStar:5];
    starRatingView.delegate = self;
    
    [starRatingView setScore:[actualRating getValue]/10 withAnimation:NO];
    
    cell.accessoryView=starRatingView;
    
    // Configure the cell...
    
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
    [[Session getInstance]setSelectedRatingIndex:indexPath.row];
    
    
    RatingDetailUsersView *RatingDetailUsersView=
    [self.storyboard instantiateViewControllerWithIdentifier:@"RatingDetailUsersView"];
    [self.navigationController pushViewController:RatingDetailUsersView animated:YES];
    
    
}

-(void)viewWillAppear:(BOOL)animated{
    ratningsArray = [[NSMutableArray alloc]init];
    
    int selectedIndex=[[Session getInstance]getSelectedIndex];
    Club * club=[[Session getInstance]getSelectedClubAtIndex:selectedIndex];
    
    ratningsArray=[club getRatings];
    
    [self.tableView reloadData];
    
    [super viewDidAppear:animated];
}



@end
