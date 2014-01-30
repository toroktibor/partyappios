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

@synthesize index;


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
    Club * actualClub = [[Session getInstance] getSelectedClubAtIndex: [[Session getInstance] getSelectedIndex]];
    NSLog(@"Dddd: %@",[actualClub getClubName]);
    
    NSLog(@"Dddd: %d",[[actualClub getImages] count]);
    return [[actualClub getImages] count];
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier = @"PicturesCell";
    
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    
    UIImageView *recipeImageView = (UIImageView *)[cell viewWithTag:100];
    
    
    Club * actualClub = [[Session getInstance] getSelectedClubAtIndex: [[Session getInstance] getSelectedIndex]];
    recipeImageView.image = [[[actualClub getImages] objectAtIndex:indexPath.row] bitmap_thumbnail];
    [recipeImageView setContentMode:UIViewContentModeScaleAspectFill];
    
    return cell;
}


-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    index=indexPath.row;
    
    // [[Session getInstance]setImage:[recipePhotos objectAtIndex:index]];

    PictureView *PicturesDetailView=
    [self.storyboard instantiateViewControllerWithIdentifier:@"PictureView"];
    
    GaleryImage * actualGaleryImage = [[[[Session getInstance] getSelectedClubAtIndex: [[Session getInstance] getSelectedIndex]] getImages] objectAtIndex:indexPath.row];
    
   
    if( actualGaleryImage.bitmap == nil)
        [actualGaleryImage downloadBitmap];
    
    [self.navigationController pushViewController:PicturesDetailView animated:YES];
    
    
    [PicturesDetailView.imageView setImage:[actualGaleryImage bitmap]];
    [PicturesDetailView.imageView setContentMode:UIViewContentModeScaleAspectFit];
    [PicturesDetailView.imageView setBackgroundColor:[UIColor blackColor]];

    
}



- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    NSLog(@"kép kiválasztva");
    UIImage * cameraImage  = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
    //UIImage * cameraImage  = [[[[[Session getInstance] getSelectedClubAtIndex: [[Session getInstance] getSelectedIndex]] getImages] objectAtIndex:0] bitmap_thumbnail];
    Club * actualClub = [[Session getInstance] getSelectedClubAtIndex: [[Session getInstance] getSelectedIndex]];
    
    NSData * imageData = UIImageJPEGRepresentation(cameraImage, 0.3);
    NSString * encodedImageData = [Base64 encode:imageData];

    //NSLog(@"azadat:%@",encodedImageData);
    NSLog(@"keszitett meret:%d",encodedImageData.length);
    
    // feltöltés helye
    int newImageID=[[[Session getInstance] getCommunication] uploadAnImageWithClubId:[actualClub getIdentifier] andRowImage:encodedImageData andRotate:0];
    NSLog(@"A feltoltott kep id-je: %d",newImageID);
    UIImage * newThumbnail = [[UIImage alloc] initWithData:[Base64 decode: [[[Session getInstance] getCommunication] downLoadAnImageThumbnailWithImageId:newImageID]]];

    
    GaleryImage * newGaleryImage = [[GaleryImage alloc] initWithId:newImageID andBitmap_thumbnail:newThumbnail];
    

    [[actualClub getImages] addObject:newGaleryImage];
    

    
    
    
    
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
