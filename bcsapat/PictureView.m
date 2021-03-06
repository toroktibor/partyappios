//
//  PictureView.m
//  bcsapat
//
//  Created by hallgato on 1/21/14.
//  Copyright (c) 2014 hallgato. All rights reserved.
//

#import "PictureView.h"
#import "Session.h"

@interface PictureView (){
    UIBarButtonItem *nextButton;
    UIBarButtonItem *prevButton;
}

@end

@implementation PictureView
@synthesize image,imageView;

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
    
    
    /*image = [[Session getInstance]getImage];
    [imageView setImage:image];*/
    
    UIImage * nextImage=[UIImage imageNamed:@"ic_action_next_item.png"];
    UIImage * prevImage=[UIImage imageNamed:@"previous.png"];
    
    nextButton = [[UIBarButtonItem alloc] initWithImage:nextImage style:UIBarButtonItemStyleBordered target:self action:@selector(next)];
    prevButton = [[UIBarButtonItem alloc] initWithImage:prevImage style:UIBarButtonItemStyleBordered target:self action:@selector(back)];;

    
    //nextButton = [[UIBarButtonItem alloc] initWithTitle:@"Következő" style:UIBarButtonItemStyleBordered target:self action:@selector(next)];
    //prevButton = [[UIBarButtonItem alloc] initWithTitle:@"Előző" style:UIBarButtonItemStyleBordered target:self action:@selector(back)];
    
    
    
    NSArray *actionButtonItems = @[nextButton, prevButton];
    self.navigationItem.rightBarButtonItems = actionButtonItems;
    
    [imageView setContentMode:UIViewContentModeScaleAspectFit];
    [imageView setBackgroundColor:[UIColor blackColor]];
    
    [self changeImage:[[Session getInstance] getImage]];
   
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)handleSwipe:(UISwipeGestureRecognizer *)swipe {
    
    if (swipe.direction == UISwipeGestureRecognizerDirectionLeft) {
        NSLog(@"Left Swipe");
        
    }
    if (swipe.direction == UISwipeGestureRecognizerDirectionRight) {
        NSLog(@"Right Swipe");
        
    }
}

-(void)changeImage:(int)newid{
    //int currentImageIndex = [[Session getInstance] getImage];
    //int newImageIndex=currentImageIndex+1;
    int newImageIndex=newid;
    if( newImageIndex < 0 || newImageIndex > [[[[Session getInstance] getSelectedClubAtIndex: [[Session getInstance] getSelectedIndex]] getImages] count]-1){
        return;
    }
    if( newImageIndex==0 ){
        [prevButton setEnabled:false];
        [prevButton setTintColor:[UIColor colorWithRed:(40/255.0) green:(40/255.0) blue:(40/255.0) alpha:1]];
    }else{
        [prevButton setEnabled:true];
        [prevButton setTintColor:[UIColor colorWithRed:(60/255.0) green:(60/255.0) blue:(100/255.0) alpha:1]];
    }
    
    if( newImageIndex== [[[[Session getInstance] getSelectedClubAtIndex: [[Session getInstance] getSelectedIndex]] getImages] count]-1 ){
        [nextButton setEnabled:false];
        [nextButton setTintColor:[UIColor colorWithRed:(40/255.0) green:(40/255.0) blue:(40/255.0) alpha:1]];
    }else{
        [nextButton setEnabled:true];
        [nextButton setTintColor:[UIColor colorWithRed:(60/255.0) green:(60/255.0) blue:(100/255.0) alpha:1]];
    }
    
    [[Session getInstance] setImage:newImageIndex];
    
    GaleryImage * actualGaleryImage = [[[[Session getInstance] getSelectedClubAtIndex: [[Session getInstance] getSelectedIndex]] getImages] objectAtIndex:newImageIndex];
    
    if( actualGaleryImage.bitmap == nil)
        [actualGaleryImage downloadBitmap];
    
    
    [self.imageView setImage:[actualGaleryImage bitmap]];
}

-(void)slide:(int)position{
    [ self changeImage: [[Session getInstance] getImage]+position ];
}

-(void)next{
    [self slide:1];
}



-(void)back{
    [self slide:-1];
}


/*-(void)next{
    NSLog(@"next");
    
    PictureView *PicturesDetailView=
    [self.storyboard instantiateViewControllerWithIdentifier:@"PictureView"];
    
    int currentImageIndex = [[Session getInstance] getImage];
    int newImageIndex=currentImageIndex+1;
    if( newImageIndex < 0 || newImageIndex > [[[[Session getInstance] getSelectedClubAtIndex: [[Session getInstance] getSelectedIndex]] getImages] count]-1){
        return;
    }
    [[Session getInstance] setImage:newImageIndex];
    
    GaleryImage * actualGaleryImage = [[[[Session getInstance] getSelectedClubAtIndex: [[Session getInstance] getSelectedIndex]] getImages] objectAtIndex:newImageIndex];
        
    if( actualGaleryImage.bitmap == nil)
        [actualGaleryImage downloadBitmap];    
    
    
    [self.navigationController pushViewController:PicturesDetailView animated:YES];    
    [self.navigationController popViewControllerAnimated:true];
    
    [PicturesDetailView.imageView setImage:[actualGaleryImage bitmap]];
}



-(void)back{
    NSLog(@"back");
    
    PictureView *PicturesDetailView=
    [self.storyboard instantiateViewControllerWithIdentifier:@"PictureView"];
    
    int currentImageIndex = [[Session getInstance] getImage];
    int newImageIndex=currentImageIndex-1;
    if( newImageIndex < 0 || newImageIndex > [[[[Session getInstance] getSelectedClubAtIndex: [[Session getInstance] getSelectedIndex]] getImages] count]-1){
        return;
    }
    [[Session getInstance] setImage:newImageIndex];
    
    GaleryImage * actualGaleryImage = [[[[Session getInstance] getSelectedClubAtIndex: [[Session getInstance] getSelectedIndex]] getImages] objectAtIndex:newImageIndex];
    
    if( actualGaleryImage.bitmap == nil)
        [actualGaleryImage downloadBitmap];
    
    
    [self.navigationController pushViewController:PicturesDetailView animated:YES];
    [self.navigationController popViewControllerAnimated:true];
    
    [PicturesDetailView.imageView setImage:[actualGaleryImage bitmap]];
}
 */

@end
