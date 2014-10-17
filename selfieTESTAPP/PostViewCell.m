//
//  PostViewCell.m
//  selfieTESTAPP
//
//  Created by Obi Omile on 10/16/14.
//  Copyright (c) 2014 Obi Omile. All rights reserved.
//

#import "PostViewCell.h"

@implementation PostViewCell {
    dispatch_queue_t secondaryQueue;
}

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.backgroundColor = [UIColor lightGrayColor];

        largeImg = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 140, 140)];
        [self.contentView addSubview:largeImg];
        
        medImg = [[UIImageView alloc] initWithFrame:CGRectMake(170, 10, 100, 100)];
        [self.contentView addSubview:medImg];
        
        smallImg = [[UIImageView alloc] initWithFrame:CGRectMake(280, 10, 70, 70)];
        [self.contentView addSubview:smallImg];
        
        profPict = [[UIImageView alloc] initWithFrame:CGRectMake(300, 140, 50, 50)];
        profPict.layer.cornerRadius = 25;
        profPict.layer.masksToBounds = YES;
        [self.contentView addSubview:profPict];
        
        username = [[UILabel alloc] initWithFrame:CGRectMake(140, 170, 150, 20)];
        [self.contentView addSubview:username];
    }
    
    return self;
}

- (void)awakeFromNib {
    // Initialization code
    


}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void) drawMyCell:(IGPost *)Post {
    
    @try {
        username.text = Post.username;
        
        if (!secondaryQueue) {
            secondaryQueue = dispatch_queue_create("com.secondaryQueue", NULL);
        }
        
        dispatch_async(secondaryQueue,
                       ^{
                           [self downloadImages:Post];
                           
                       });
    }
    @catch (NSException *exception) {
        NSLog(@"%@",exception.description);
    }
    @finally {
        return;
    }
  

   
}

-(void) downloadImages:(IGPost *)Post {
        
        NSData *smallIMGData = [NSData dataWithContentsOfURL:[NSURL URLWithString:Post.smallImage]];
        NSData *medIMGData = [NSData dataWithContentsOfURL:[NSURL URLWithString:Post.lowResImage]];
        NSData *largeIMGData = [NSData dataWithContentsOfURL:[NSURL URLWithString:Post.hiResImage]];
        NSData *profPic = [NSData dataWithContentsOfURL:[NSURL URLWithString:Post.profilePicture]];
    
    dispatch_async (dispatch_get_main_queue(), ^{
        largeImg.image = [UIImage imageWithData:largeIMGData];
        medImg.image = [UIImage imageWithData:medIMGData];
        smallImg.image = [UIImage imageWithData:smallIMGData];
        profPict.image = [UIImage imageWithData:profPic];
        
    });
    
}

@end
