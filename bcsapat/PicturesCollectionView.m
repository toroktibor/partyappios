//
//  PicturesCollectionView.m
//  bcsapat
//
//  Created by hallgato on 1/21/14.
//  Copyright (c) 2014 hallgato. All rights reserved.
//

#import "PicturesCollectionView.h"

@interface PicturesCollectionView ()

@end

@implementation PicturesCollectionView{
    NSArray *recipePhotos;
}


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
    
    recipePhotos = [NSArray arrayWithObjects:@"2050-halloween-debrecen-halloween-napok-az-erdospuszta-club-hotelben.jpg", @"2050-halloween-debrecen-halloween-napok-az-erdospuszta-club-hotelben.jpg", nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return recipePhotos.count;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier = @"PicturesCell";
    
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    
    UIImageView *recipeImageView = (UIImageView *)[cell viewWithTag:100];
    recipeImageView.image = [UIImage imageNamed:[recipePhotos objectAtIndex:indexPath.row]];
    
    return cell;
}


- (IBAction)showActionSheet:(id)sender {
    
    UIActionSheet *popupQuery = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"Mégse"
                                              destructiveButtonTitle:nil otherButtonTitles:@"Kamera",@"Galéria", nil];
    
    popupQuery.actionSheetStyle = UIActionSheetStyleBlackOpaque;
    [popupQuery showInView:[UIApplication sharedApplication].keyWindow];
    popupQuery.frame = CGRectMake(0, [UIScreen mainScreen].bounds.size.height-popupQuery.frame.size.height, [UIScreen mainScreen].bounds.size.width, popupQuery.frame.size.height);
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
@end
