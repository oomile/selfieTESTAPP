//
//  IGPost.h
//  selfieTESTAPP
//
//  Created by Obi Omile on 10/16/14.
//  Copyright (c) 2014 Obi Omile. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface IGPost : NSObject

@property (nonatomic, strong) NSString *lowResImage;
@property (nonatomic, strong) NSString *hiResImage;
@property (nonatomic, strong) NSString *smallImage;
@property (nonatomic, strong) NSString *username;
@property (nonatomic, strong) NSString *profilePicture;
@property (nonatomic, strong) NSString *caption;


- (id) initWithUsername:(NSString *)aUsername profilePicture: (NSString *)aProfilePicture lowResImage: (NSString *) aLowResImage hiResImage:(NSString *)aHiResImage smallImage:(NSString*)aSmallImage caption:(NSString *)aCaption;

@end
