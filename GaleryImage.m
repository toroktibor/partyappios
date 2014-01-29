//
//  GaleryImage.m
//  bcsapat
//
//  Created by hallgato on 1/29/14.
//  Copyright (c) 2014 hallgato. All rights reserved.
//

#import "GaleryImage.h"
#import "Session.h"

@implementation GaleryImage
@synthesize bitmap,bitmap_thumbnail,identifier;

-(id)initWithId:(int)identifier_ andBitmap_thumbnail:(UIImage *)bitmap_thumbnail_{
   
    self = [super init];
    if(self)
    {
        self.bitmap_thumbnail=bitmap_thumbnail_;
        self.identifier=identifier_;
    }
    return self;
}

-(void)downloadBitmap{

}


@end
