//
//  PictureView.h
//  bcsapat
//
//  Created by hallgato on 1/21/14.
//  Copyright (c) 2014 hallgato. All rights reserved.
//

#import "ViewController.h"

@interface PictureView : ViewController

@property UIImage * image;

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@end
