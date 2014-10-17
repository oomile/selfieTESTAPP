//
//  DataGrabber.h
//  EarthQuakeApp
//
//  Created by Remote Tiger on 10/2/14.
//  Copyright (c) 2014 Stefan Ha. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Reachability.h"

@protocol DataGrabberDelegate <NSObject>
@optional
-(void) provide:(NSArray *)freshData;
-(void) didFailWithError:(NSString *)theErrorString;
@end

@interface DataGrabber : NSObject <NSURLConnectionDataDelegate>

@property (nonatomic, assign) id <DataGrabberDelegate> dataGrabberDelegate;
@property (nonatomic, strong) NSMutableData *instagramData;

-(void) getFreshData;

- (NSDictionary *) fetchNewData;

@end

