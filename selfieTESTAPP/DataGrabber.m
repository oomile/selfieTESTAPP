//
//  DataGrabber.m
//  EarthQuakeApp
//
//  Created by Remote Tiger on 10/2/14.
//  Copyright (c) 2014 Stefan Ha. All rights reserved.
//

#import "DataGrabber.h"
#import "IGPost.h"
#define DATA_URL @"https://api.instagram.com/v1/tags/selfie/media/recent/?client_id=1221f53d4ac341e38c6cc1554e6e176f"

@implementation DataGrabber

NSOperationQueue *myQueue;


- (instancetype)init
{
    self = [super init];
    if (self) {
        self.instagramData = [[NSMutableData alloc] init];
    }
        return self;
}

-(void) getFreshData{
    
    [self getFreshData:DATA_URL];
}

- (void) getFreshData: (NSString *) myURL{
    
    [self.instagramData setLength:0];
    Reachability *reachability = [Reachability reachabilityForInternetConnection];
    NetworkStatus internetStatus = [reachability currentReachabilityStatus];
    if (internetStatus != NotReachable) {
        NSURL *theURL = [NSURL URLWithString:myURL];
        NSURLRequest *theRequest = [NSURLRequest requestWithURL:theURL];
        NSURLConnection *urlConnection = [[NSURLConnection alloc] initWithRequest:theRequest delegate:self];
        
    } else {
        [self.dataGrabberDelegate didFailWithError:@"No Internet Available"];
    }

}

- (NSDictionary *) fetchNewData{
    NSString *url = @"https://api.instagram.com/v1/tags/selfie/media/recent?client_id=1221f53d4ac341e38c6cc1554e6e176f&max_tag_id=1413563371060501";
    NSData *newData = [NSData dataWithContentsOfURL:[NSURL URLWithString:url]];
    NSError *error = nil;
    
    NSDictionary *newDictionary = [NSJSONSerialization JSONObjectWithData:newData options:0 error:&error];
    
    return newDictionary;
    
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data{
    [self.instagramData appendData:data];
}


- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    [connection cancel];
    
    NSError *error;
    NSDictionary *theJSONData = [NSJSONSerialization JSONObjectWithData:self.instagramData options:NSJSONReadingMutableContainers error:&error];
    if(!error) {
        NSArray *instaDataArray = [theJSONData objectForKey:@"data"];
        if([instaDataArray count] > 0) {
            
            NSMutableArray *dataArray = [[NSMutableArray alloc] init];
            
            for (NSDictionary *theData in instaDataArray) {
                
                NSString *username = [[theData objectForKey:@"user"] objectForKey:@"username"];
                NSString *largeImg = [[[theData objectForKey:@"images"] objectForKey:@"standard_resolution"] objectForKey:@"url"];
                NSString *medImg = [[[theData objectForKey:@"images"] objectForKey:@"low_resolution"] objectForKey:@"url"];
                NSString *smallimg = [[[theData objectForKey:@"images"] objectForKey:@"thumbnail"] objectForKey:@"url"];
                NSString *profilePic = [[theData objectForKey:@"user"] objectForKey:@"profile_picture"];
                NSString *caption = [theData objectForKey:@"caption"];

                IGPost *post = [[IGPost alloc] initWithUsername:username profilePicture:profilePic lowResImage:medImg hiResImage:largeImg smallImage:smallimg caption:caption];
                
                [dataArray addObject:post];
            }
            
            [self.dataGrabberDelegate provide:dataArray];
            
        } else {
            [self.dataGrabberDelegate didFailWithError:@"No Images Found"];
        }
        
    } else {
        [self.dataGrabberDelegate didFailWithError:[error description]];
    }
    
}



@end
