//
//  FoodsAndDrinksTableView.m
//  bcsapat
//
//  Created by hallgato on 1/22/14.
//  Copyright (c) 2014 hallgato. All rights reserved.
//

#import "FoodsAndDrinksTableView.h"
#import "Session.h"
#import "Club.h"
#import "MenuItem.h"
#import "DrinkOrFoodView.h"
#import "User.h"

@interface FoodsAndDrinksTableView ()

@end

@implementation FoodsAndDrinksTableView
@synthesize menuItemsArray,addNewMenuItem;

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
    
    menuItemsArray=[[NSMutableArray alloc]init];
    
    int selectedIndex=[[Session getInstance]getSelectedIndex];
    Club * club=[[Session getInstance]getSelectedClubAtIndex:selectedIndex];
    
    menuItemsArray=[club getMenuItems];
    
    //jobb felső sarokban hozzáadás gomb elrejtése, adminra van vizsgálva, majd átt kell írni user-ra
    if ([[[Session getInstance]getActualUser]getType]==0) {
        self.navigationItem.rightBarButtonItem=nil;
    }
    
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
    return [menuItemsArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"MenuItemCell";
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
    
    UIImage *accessoryImage = [UIImage imageNamed:@"ic_action_next_item.png"];
    UIImageView *accImageView = [[UIImageView alloc] initWithImage:accessoryImage];
    accImageView.userInteractionEnabled = YES;
    [accImageView setFrame:CGRectMake(0, 0, 28.0, 28.0)];
    cell.accessoryView = accImageView;
    
    
    cell.textLabel.textColor=[UIColor whiteColor];
    cell.detailTextLabel.textColor=[UIColor whiteColor];

   cell.textLabel.text=[[menuItemsArray objectAtIndex:indexPath.row]getMenuItemName];
   
    int price=[[menuItemsArray objectAtIndex:indexPath.row]getPrice];
    NSString * unit=[[menuItemsArray objectAtIndex:indexPath.row]getUnit];
    NSString * currency=[[menuItemsArray objectAtIndex:indexPath.row]getCurrency];
    
    cell.detailTextLabel.text=[NSString stringWithFormat:@"%d%@/%@",price,currency,unit];
    
    
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
    
    [[Session getInstance]setMenuItemIndex:indexPath.row];
    
    DrinkOrFoodView *DrinkOrFoodView =
    [self.storyboard instantiateViewControllerWithIdentifier:@"DrinkOrFoodView"];
    [self.navigationController pushViewController:DrinkOrFoodView animated:YES];
}

@end
