//
//  BCParseContactList.m
//  BalloonClean
//
//  Created by Sean Wertheim on 6/18/14.
//  Copyright (c) 2014 Sean Wertheim. All rights reserved.
//

#import "BCParseContactList.h"
#import <Parse/PFObject+Subclass.h>

@implementation BCParseContactList

@dynamic name;
@dynamic users;
@dynamic visible;
@dynamic photo;

+(NSString*)parseClassName{
    return @"ContactList";
}

-(void)setListPhotoWithImage:(UIImage *)listImage{
    NSData *imageData = UIImagePNGRepresentation(listImage);
    PFFile *imageFile = [PFFile fileWithName:@"listImage.png" data:imageData];
    self.photo = imageFile;
}

@end
