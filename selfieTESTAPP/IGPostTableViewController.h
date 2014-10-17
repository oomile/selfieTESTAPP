//
//  IGPostTableViewController.h
//  selfieTESTAPP
//
//  Created by Obi Omile on 10/16/14.
//  Copyright (c) 2014 Obi Omile. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DataGrabber.h"

@interface IGPostTableViewController : UITableViewController <DataGrabberDelegate>

@property (nonatomic) BOOL loadingMoreTableViewData;


@end
