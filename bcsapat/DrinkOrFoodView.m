//
//  DrinkOrFoodView.m
//  bcsapat
//
//  Created by hallgato on 1/23/14.
//  Copyright (c) 2014 hallgato. All rights reserved.
//

#import "DrinkOrFoodView.h"
#import "Session.h"
#import "Club.h"
#import "MenuItem.h"
#import "EditMenuItemView.h"

@interface DrinkOrFoodView ()

@end

@implementation DrinkOrFoodView
@synthesize nameLabel,categoryLabel,priceLabel,currencyLabel,unitLabel,discountLabel;

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
    
    UIBarButtonItem *Szerk = [[UIBarButtonItem alloc] initWithTitle:@"Szerk." style:UIBarButtonItemStyleBordered target:self action:@selector(edit)];
    UIBarButtonItem *delete = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemTrash target:self action:@selector(moveToTrash)];
    
    
    
    NSArray *actionButtonItems = @[Szerk, delete];
    self.navigationItem.rightBarButtonItems = actionButtonItems;
    
    
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bricskok.png"]];
    
    self.tableView.backgroundView = imageView;
    
    NSMutableArray * menuItemsArray=[[NSMutableArray alloc]init];
    
    int selectedIndex=[[Session getInstance]getSelectedIndex];
    Club * club=[[Session getInstance]getSelectedClubAtIndex:selectedIndex];
    
    
    User * user=[[Session getInstance]getActualUser];
    
    if (!([user isThisUserOwnerOfClub:[club getIdentifier]] || [user getType]==1))
        
        if ([[[Session getInstance]getActualUser]getType]==0) {
            self.navigationItem.rightBarButtonItems=nil;
        }
    
    
    menuItemsArray=[club getMenuItems];
    
    int itemIndex=[[Session getInstance]getMenuItemIndex];
    
    MenuItem *item=[menuItemsArray objectAtIndex:itemIndex];
    
    nameLabel.text=[item getMenuItemName];
    categoryLabel.text=[item getMenuItemCategory];
    currencyLabel.text=[item getCurrency];
    priceLabel.text=[NSString stringWithFormat:@"%d",[item getPrice]];
    unitLabel.text=[item getUnit];
    discountLabel.text=[NSString stringWithFormat:@"%d%%",[item getDiscount]];
    
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
        titleLabel.text = @"Tétel neve";
        
        titleLabel.textColor = [UIColor whiteColor];
        
        titleLabel.backgroundColor = [UIColor colorWithRed:154.0 green:111.0 blue:189.0 alpha:0];
        
        [headerView addSubview:titleLabel];
    }
    if (section==1) {
        titleLabel.text = @"Kategória";
        
        titleLabel.textColor = [UIColor whiteColor];
        
        titleLabel.backgroundColor = [UIColor colorWithRed:154.0 green:111.0 blue:189.0 alpha:0];
        
        [headerView addSubview:titleLabel];
    }
    if (section==2) {
        titleLabel.text = @"Ár";
        
        titleLabel.textColor = [UIColor whiteColor];
        
        titleLabel.backgroundColor = [UIColor colorWithRed:154.0 green:111.0 blue:189.0 alpha:0];
        
        [headerView addSubview:titleLabel];
    }
    if (section==3) {
        titleLabel.text = @"Mennyiség";
        
        titleLabel.textColor = [UIColor whiteColor];
        
        titleLabel.backgroundColor = [UIColor colorWithRed:154.0 green:111.0 blue:189.0 alpha:0];
        
        [headerView addSubview:titleLabel];
    }
    if (section==4) {
        titleLabel.text = @"Kedvezmény";
        
        titleLabel.textColor = [UIColor whiteColor];
        
        titleLabel.backgroundColor = [UIColor colorWithRed:154.0 green:111.0 blue:189.0 alpha:0];
        
        [headerView addSubview:titleLabel];
    }
    
    return headerView;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    //cell.backgroundColor = [UIColor colorWithRed:(47/255.0) green:(50/255.0) blue:(66/255.0) alpha:0.5];
    //cell.backgroundColor = [UIColor colorWithRed:(190/255.) green:(190/255.0) blue:(190/255.0) alpha:0.5];
    cell.backgroundColor = [UIColor colorWithRed:(154/255.0) green:(111/255.0) blue:(189/255.0) alpha:0.5];
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


-(void)viewWillAppear:(BOOL)animated{
    NSMutableArray * menuItemsArray=[[NSMutableArray alloc]init];
    
    int selectedIndex=[[Session getInstance]getSelectedIndex];
    Club * club=[[Session getInstance]getSelectedClubAtIndex:selectedIndex];
    
    menuItemsArray=[club getMenuItems];
    
    int itemIndex=[[Session getInstance]getMenuItemIndex];
    
    MenuItem *item=[menuItemsArray objectAtIndex:itemIndex];
    
    nameLabel.text=[item getMenuItemName];
    categoryLabel.text=[item getMenuItemCategory];
    currencyLabel.text=[item getCurrency];
    priceLabel.text=[NSString stringWithFormat:@"%d",[item getPrice]];
    unitLabel.text=[item getUnit];
    discountLabel.text=[NSString stringWithFormat:@"%d%%",[item getDiscount]];

    
    [super viewWillAppear:animated];
}


-(void)edit{
    EditMenuItemView *EditMenuItemView =
    [self.storyboard instantiateViewControllerWithIdentifier:@"EditMenuItemView"];
    [self.navigationController pushViewController:EditMenuItemView  animated:YES];
}

-(void)moveToTrash{
 
    UIAlertView * alertview = [[UIAlertView alloc] initWithTitle:@"Biztos hogy törölni akarod?"
                                                         message:nil
                                                        delegate:self
                                               cancelButtonTitle:@"Nem"
                                               otherButtonTitles:@"Igen", nil];
    [alertview show];

}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 0){
        NSLog(@"mégse");
    }
    else if(buttonIndex==1){
        NSLog(@"trash");
        NSMutableArray * menuItemsArray=[[NSMutableArray alloc]init];
        int selectedIndex=[[Session getInstance]getSelectedIndex];
        Club * club=[[Session getInstance]getSelectedClubAtIndex:selectedIndex];
        menuItemsArray=[club getMenuItems];
        
        int itemIndex=[[Session getInstance]getMenuItemIndex];
        
        MenuItem *item=[menuItemsArray objectAtIndex:itemIndex];
        
        
        [[[Session getInstance]getCommunication] removeEMenuItemWithMenuId:[item getIdentifier]];
        
        [menuItemsArray removeObjectAtIndex:itemIndex];
        
        [self.navigationController popViewControllerAnimated:YES];
    }
     
}



@end
