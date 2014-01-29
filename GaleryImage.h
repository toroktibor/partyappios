//
//  GaleryImage.h
//  bcsapat
//
//  Created by hallgato on 1/29/14.
//  Copyright (c) 2014 hallgato. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GaleryImage : NSObject

@property UIImage * bitmap;
@property UIImage * bitmap_thumbnail;
@property int identifier;

- (id)initWithId:(int) identifier_ andBitmap_thumbnail:(UIImage *)bitmap_thumbnail_;

-(void)downloadBitmap;


@end







/*public class GaleryImage {
    private Bitmap bitmap;
    private Bitmap bitmap_thumbnail;
    private int id;
    
    public GaleryImage(int id, Bitmap bitmap_thumbnail) {
        this.id = id;
        this.bitmap_thumbnail = bitmap_thumbnail;
    }
    
    public Bitmap getBitmap() {
        return bitmap;
    }
    
    public void setBitmap(Bitmap bitmap) {
        this.bitmap = bitmap;
    }
    
    public Bitmap getBitmap_thumbnail() {
        return bitmap_thumbnail;
    }
    
    public void setBitmap_thumbnail(Bitmap bitmap_thumbnail) {
        this.bitmap_thumbnail = bitmap_thumbnail;
    }
    
    public void downloadBitmap(){
        this.bitmap = ImageUtils.StringToBitMap( Session.getInstance().getActualCommunicationInterface().DownLoadAnImage(this.id));
    }
}*/