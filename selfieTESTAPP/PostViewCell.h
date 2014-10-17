//
//  PostViewCell.h
//  selfieTESTAPP
//
//  Created by Obi Omile on 10/16/14.
//  Copyright (c) 2014 Obi Omile. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IGPost.h"

@interface PostViewCell : UITableViewCell

{
    UIImageView *largeImg;
    UIImageView *medImg;
    UIImageView *smallImg;
    UIImageView *profPict;
    UILabel *username;
    
}
-(void) drawMyCell:(IGPost *) Post;

@end
