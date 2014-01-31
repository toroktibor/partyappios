//
//  AddNewClubTableView.m
//  bcsapat
//
//  Created by hallgato on 1/23/14.
//  Copyright (c) 2014 hallgato. All rights reserved.
//

#import "AddNewClubTableView.h"
#import "NewTypePickerView.h"
#import "Session.h"

@interface AddNewClubTableView ()

@end

@implementation AddNewClubTableView
@synthesize nameText,addressText,typeLabel,danceSelected,snookerSelected,liveMusicSelected,sportBroadcastSelected,coctailBarSelected,wifiSelected,DartsSelected,
BowlingSelected,DjSelected,FoodSelected;

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
    
    
    [[[self navigationController] navigationBar] setTintColor:[UIColor colorWithRed:(60/255.0) green:(60/255.0) blue:(100/255.0) alpha:1.0]];
    
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bricskok.png"]];
    
    self.tableView.backgroundView = imageView;

    
    
    addressText.delegate=self;
    nameText.delegate=self;
    
    
    danceSelected=NO;
    liveMusicSelected=NO;
    sportBroadcastSelected=NO;
    snookerSelected=NO;
    FoodSelected=NO;
    DjSelected=NO;
    BowlingSelected=NO;
    DartsSelected=NO;
    wifiSelected=NO;
    coctailBarSelected=NO;
    
    [[ Session getInstance] setClubTypeForPicer:@"Válassz"];
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
        titleLabel.text = @"Cím";
        
        titleLabel.textColor = [UIColor whiteColor];
        
        titleLabel.backgroundColor = [UIColor colorWithRed:154.0 green:111.0 blue:189.0 alpha:0];
        
        [headerView addSubview:titleLabel];
    }
    if (section==2) {
        titleLabel.text = @"Típus";
        
        titleLabel.textColor = [UIColor whiteColor];
        
        titleLabel.backgroundColor = [UIColor colorWithRed:154.0 green:111.0 blue:189.0 alpha:0];
        
        [headerView addSubview:titleLabel];
    }
    if (section==3) {
        titleLabel.text = @"Szolgáltatások";
        
        titleLabel.textColor = [UIColor whiteColor];
        
        titleLabel.backgroundColor = [UIColor colorWithRed:154.0 green:111.0 blue:189.0 alpha:0];
        
        [headerView addSubview:titleLabel];
    }
    
    return headerView;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    UIImage *accessoryImage_next = [UIImage imageNamed:@"ic_action_next_item.png"];
    UIImageView *accImageView_next = [[UIImageView alloc] initWithImage:accessoryImage_next];
    accImageView_next.userInteractionEnabled = YES;
    [accImageView_next setFrame:CGRectMake(0, 0, 28.0, 28.0)];
    //NSLog(@"ITT VAGYOK");
    if (indexPath.section==2 && indexPath.row==0) {
        cell.accessoryView = accImageView_next;
    }
    
    
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
    
    UIImage *accessoryImage_accept = [UIImage imageNamed:@"ic_action_accept.png"];
    UIImageView *accImageView_accept = [[UIImageView alloc] initWithImage:accessoryImage_accept];
    accImageView_accept.userInteractionEnabled = YES;
    [accImageView_accept setFrame:CGRectMake(0, 0, 28.0, 28.0)];
    
    
    if (indexPath.section==2 && indexPath.row==0) {
        //picker megnyitása
        NewTypePickerView *NewTypePickerView=
        [self.storyboard instantiateViewControllerWithIdentifier:@"NewTypePickerView"];
        [self.navigationController pushViewController:NewTypePickerView animated:YES];
    }
    else if (indexPath.section==3 && indexPath.row==0){
        if (sportBroadcastSelected==NO) {
            UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
            //cell.accessoryType=UITableViewCellAccessoryCheckmark;
            cell.accessoryView = accImageView_accept;
            [self.tableView reloadData];
            sportBroadcastSelected=YES;
        }
        else{
            UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
            cell.accessoryView=nil;
            //cell.accessoryType=UITableViewCellAccessoryNone;
            [self.tableView reloadData];
            sportBroadcastSelected=NO;
        }
    }
    else if (indexPath.section==3 && indexPath.row==1){
        if (liveMusicSelected==NO) {
            UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
            //cell.accessoryType=UITableViewCellAccessoryCheckmark;
            cell.accessoryView = accImageView_accept;
            [self.tableView reloadData];
            liveMusicSelected=YES;
        }
        else{
            UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
            cell.accessoryView=nil;
            //cell.accessoryType=UITableViewCellAccessoryNone;
            [self.tableView reloadData];
            liveMusicSelected=NO;
        }
    }
    else if (indexPath.section==3 && indexPath.row==2){
        if (snookerSelected==NO) {
            UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
            //cell.accessoryType=UITableViewCellAccessoryCheckmark;
            cell.accessoryView = accImageView_accept;
            [self.tableView reloadData];
            snookerSelected=YES;
        }
        else{
            UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
            cell.accessoryView=nil;
            //cell.accessoryType=UITableViewCellAccessoryNone;
            [self.tableView reloadData];
            snookerSelected=NO;
        }
    }
    else if (indexPath.section==3 && indexPath.row==3){
        if (FoodSelected==NO) {
            UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
            //cell.accessoryType=UITableViewCellAccessoryCheckmark;
            cell.accessoryView = accImageView_accept;
            [self.tableView reloadData];
            FoodSelected=YES;
        }
        else{
            UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
            cell.accessoryView=nil;
            //cell.accessoryType=UITableViewCellAccessoryNone;
            [self.tableView reloadData];
            FoodSelected=NO;
        }
    }
    else if (indexPath.section==3 && indexPath.row==4){
        if (DjSelected==NO) {
            UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
            //cell.accessoryType=UITableViewCellAccessoryCheckmark;
            cell.accessoryView = accImageView_accept;
            [self.tableView reloadData];
            DjSelected=YES;
        }
        else{
            UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
            cell.accessoryView=nil;
            // cell.accessoryType=UITableViewCellAccessoryNone;
            [self.tableView reloadData];
            DjSelected=NO;
        }
    }
    else if (indexPath.section==3 && indexPath.row==5){
        if (DartsSelected==NO) {
            UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
            //cell.accessoryType=UITableViewCellAccessoryCheckmark;
            cell.accessoryView = accImageView_accept;
            [self.tableView reloadData];
            DartsSelected=YES;
        }
        else{
            UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
            cell.accessoryView=nil;
            //cell.accessoryType=UITableViewCellAccessoryNone;
            [self.tableView reloadData];
            DartsSelected=NO;
        }
    }
    else if (indexPath.section==3 && indexPath.row==6){
        if (BowlingSelected==NO) {
            UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
            //cell.accessoryType=UITableViewCellAccessoryCheckmark;
            cell.accessoryView = accImageView_accept;
            [self.tableView reloadData];
            BowlingSelected=YES;
        }
        else{
            UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
            cell.accessoryView=nil;
            //cell.accessoryType=UITableViewCellAccessoryNone;
            [self.tableView reloadData];
            BowlingSelected=NO;
        }
    }
    else if (indexPath.section==3 && indexPath.row==7){
        if (wifiSelected==NO) {
            UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
            //cell.accessoryType=UITableViewCellAccessoryCheckmark;
            cell.accessoryView = accImageView_accept;
            [self.tableView reloadData];
            wifiSelected=YES;
        }
        else{
            UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
            cell.accessoryView=nil;
            //cell.accessoryType=UITableViewCellAccessoryNone;
            [self.tableView reloadData];
            wifiSelected=NO;
        }
    }
    else if (indexPath.section==3 && indexPath.row==8){
        if (coctailBarSelected==NO) {
            UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
            //cell.accessoryType=UITableViewCellAccessoryCheckmark;
            cell.accessoryView = accImageView_accept;
            [self.tableView reloadData];
            coctailBarSelected=YES;
        }
        else{
            UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
            cell.accessoryView=nil;
            //cell.accessoryType=UITableViewCellAccessoryNone;
            [self.tableView reloadData];
            coctailBarSelected=NO;
        }
    }
    else if (indexPath.section==3 && indexPath.row==9){
        if (DartsSelected==NO) {
            UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
            //cell.accessoryType=UITableViewCellAccessoryCheckmark;
            cell.accessoryView = accImageView_accept;
            [self.tableView reloadData];
            DartsSelected=YES;
        }
        else{
            UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
            cell.accessoryView=nil;
            //cell.accessoryType=UITableViewCellAccessoryNone;
            [self.tableView reloadData];
            DartsSelected=NO;
        }
    }
    else if (indexPath.section==4 && indexPath.row==0){
        NSLog(@"Hozzáadás gomb");
        
        if( [[nameText text] isEqual:@""] ){
            [[[UIAlertView alloc] initWithTitle:@"Hiba" message:@"Nem adtál meg nevet!" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles: nil] show];
            return;
        }
        
        if( [[addressText text] isEqual:@""] ){
            [[[UIAlertView alloc] initWithTitle:@"Hiba" message:@"Nem adtál meg címet!" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles: nil] show];
            return;
        }
        
        if( [[typeLabel text] isEqual: @"Bármelyik"] ){
            [[[UIAlertView alloc] initWithTitle:@"Hiba" message:@"Nem válaszottál típust!" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles: nil] show];
                return;
        }
        
        NSMutableString *services = [[NSMutableString alloc]init];
        if (danceSelected ==YES) {
            if (![services isEqual: @""]) [services appendString:@","];
            [services appendString:@"dance"];
        }
        if (liveMusicSelected ==YES) {
            if (![services isEqual: @""]) [services appendString:@","];
            [services appendString:@"livemusic"];
        }
        if (sportBroadcastSelected ==YES) {
            if (![services isEqual: @""]) [services appendString:@","];
            [services appendString:@"sporttv"];
        }
        if (snookerSelected ==YES) {
            if (![services isEqual: @""]) [services appendString:@","];
            [services appendString:@"billiard"];
        }
        if (FoodSelected ==YES) {
            if (![services isEqual: @""]) [services appendString:@","];
            [services appendString:@"menu"];
        }
        if (DjSelected ==YES) {
            if (![services isEqual: @""]) [services appendString:@","];
            [services appendString:@"dj"];
        }
        if (BowlingSelected ==YES) {
            if (![services isEqual: @""]) [services appendString:@","];
            [services appendString:@"bowling"];
        }
        if (DartsSelected ==YES) {
            if (![services isEqual: @""]) [services appendString:@","];
            [services appendString:@"darts"];
        }
        if (wifiSelected ==YES) {
            if (![services isEqual: @""]) [services appendString:@","];
            [services appendString:@"wifi"];
        }
        if(coctailBarSelected ==YES){
            if (![services isEqual: @""]) [services appendString:@","];
            [services appendString:@"coctailbar"];
        }
        
        [[[Session getInstance] getCommunication] sendANewClubRequestWithClubname:[nameText text] andAddress:[addressText text] andType:[typeLabel text] andOwnerUserId:-1 andServices:services];
        
        [[ Session getInstance] setClubTypeForPicer:@"Bármelyik"]; // Picker visszaállítása a keresőhöz
        
        [self dismissViewControllerAnimated:YES completion:nil];
        
        [[[UIAlertView alloc] initWithTitle:@"Siker" message:@"A hely hozzá lett adva, várj, míg egy moderátor elfogadja!" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles: nil] show];

    }
}

- (IBAction)back:(id)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
}



- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

-(void)viewWillAppear:(BOOL)animated{
    typeLabel.text=[[Session getInstance]getClubTypeForPicker];
    [super viewWillAppear:animated];
}

-(void)viewWillDisappear:(BOOL)animated{
    [[ Session getInstance] setClubTypeForPicer:@"Bármelyik"]; // picker visszaállítása a keresőhöz
}


@end
