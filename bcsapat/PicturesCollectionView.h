//
//  PicturesCollectionView.h
//  bcsapat
//
//  Created by hallgato on 1/21/14.
//  Copyright (c) 2014 hallgato. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PicturesCollectionView : UICollectionViewController<UIActionSheetDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate>

- (IBAction)showActionSheet:(id)sender;
@property int index;
@property NSMutableArray *recipePhotos;

- (IBAction)back:(id)sender;
@end