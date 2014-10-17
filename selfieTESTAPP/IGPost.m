//
//  IGPost.m
//  selfieTESTAPP
//
//  Created by Obi Omile on 10/16/14.
//  Copyright (c) 2014 Obi Omile. All rights reserved.
//

#import "IGPost.h"

@implementation IGPost

- (id) initWithUsername:(NSString *)aUsername profilePicture:(NSString *)aProfilePicture lowResImage:(NSString *)aLowResImage hiResImage:(NSString *)aHiResImage smallImage:(NSString *)aSmallImage caption:(NSString *)aCaption;

{
    
    self = [super init];
    if (self) {
        
        self.username = aUsername;
        self.profilePicture = aProfilePicture;
        self.lowResImage = aLowResImage;
        self.hiResImage = aHiResImage;
        self.caption = aCaption;
        self.smallImage = aSmallImage;
        
    }
    
    return self;
}

@end
