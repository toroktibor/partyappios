//
//  PicturesCollectionView.m
//  bcsapat
//
//  Created by hallgato on 1/21/14.
//  Copyright (c) 2014 hallgato. All rights reserved.
//

#import "PicturesCollectionView.h"
#import "PictureView.h"
#import "Session.h"

@interface PicturesCollectionView ()

@end

@implementation PicturesCollectionView

@synthesize index,recipePhotos;


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
    
    [[[self navigationController] navigationBar] setTintColor:[UIColor colorWithRed:(60/255.0) green:(60/255.0) blue:(100/255.0) alpha:1.0]];

    recipePhotos=[[NSMutableArray alloc]init];
    
   UIImage * image = [UIImage imageNamed: @"2050-halloween-debrecen-halloween-napok-az-erdospuszta-club-hotelben.jpg"];
   UIImage * image2 = [UIImage imageNamed: @"Nightclub-theme.jpg"];
    UIImage *image3 = [UIImage imageNamed: @"Bar.jpg"];
    UIImage *image4 = [UIImage imageNamed: @"The-Sun-City-Hotel-photos-Restaurant-Restaurant.jpg"];
    
    [recipePhotos addObject:image];
    [recipePhotos addObject:image2];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


/*-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
    
}*/

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return recipePhotos.count;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier = @"PicturesCell";
    
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    
    UIImageView *recipeImageView = (UIImageView *)[cell viewWithTag:100];
    recipeImageView.image = [recipePhotos objectAtIndex:indexPath.row];
    
    return cell;
}


-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    index=indexPath.row;
    
    [[Session getInstance]setImage:[recipePhotos objectAtIndex:index]];

    PictureView *PicturesDetailView=
    [self.storyboard instantiateViewControllerWithIdentifier:@"PictureView"];
    [self.navigationController pushViewController:PicturesDetailView animated:YES];
    //[PicturesDetailView.imageView setImage:[recipePhotos objectAtIndex:index]];
        
}



- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    NSLog(@"kép kiválasztva");
    UIImage * cameraImage  = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
    [recipePhotos addObject:cameraImage];
    [self.collectionView reloadData];
    [picker dismissViewControllerAnimated:YES completion:nil];
    
}


-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 0) {
        UIImagePickerController *imgpicker=[[UIImagePickerController alloc]init];
        [imgpicker setDelegate: self];
        [imgpicker setSourceType:UIImagePickerControllerSourceTypeCamera];
        [self presentViewController:imgpicker animated:YES completion:^{
            
        }];
    }
    
    if (buttonIndex == 1) {
        
        UIImagePickerController *imgpicker=[[UIImagePickerController alloc]init];
        [imgpicker setDelegate: self];
        [imgpicker setSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
        [self presentViewController:imgpicker animated:YES completion:^{
            
        }];
        
    }
    if (buttonIndex == 2) {
        
    }
}
- (IBAction)showActionSheet:(id)sender {
    UIActionSheet *popupQuery = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"Mégse"
                                              destructiveButtonTitle:nil otherButtonTitles:@"Kamera",@"Galéria", nil];
    
    popupQuery.actionSheetStyle = UIActionSheetStyleBlackOpaque;
    [popupQuery showInView:[UIApplication sharedApplication].keyWindow];
    popupQuery.frame = CGRectMake(0, [UIScreen mainScreen].bounds.size.height-popupQuery.frame.size.height, [UIScreen mainScreen].bounds.size.width, popupQuery.frame.size.height);
}


- (IBAction)back:(id)sender {
    UITabBarController *tabBar = [[UIStoryboard storyboardWithName:@"MainStoryboard_iPhone" bundle:nil] instantiateViewControllerWithIdentifier:@"mainMenuTabBar"];
    
    
    tabBar.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    [self presentViewController: tabBar animated: YES completion:nil];
}
@end
