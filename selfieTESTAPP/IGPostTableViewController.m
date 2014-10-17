//
//  IGPostTableViewController.m
//  selfieTESTAPP
//
//  Created by Obi Omile on 10/16/14.
//  Copyright (c) 2014 Obi Omile. All rights reserved.
//

#import "IGPostTableViewController.h"
#import "PostViewCell.h"
#import "IGPost.h"


@interface IGPostTableViewController () {

NSMutableArray *IGpostArray;
DataGrabber *dataGrabber;
UIRefreshControl *refreshControl;
    
}

@end

@implementation IGPostTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    [self.tableView registerClass:[PostViewCell class] forCellReuseIdentifier:@"Cell"];
    [self.tableView registerClass:[PostViewCell class] forCellReuseIdentifier:@"cell"];

    
    IGpostArray = [[NSMutableArray alloc] init];
    dataGrabber = [[DataGrabber alloc] init];
    dataGrabber.dataGrabberDelegate = self;
    [dataGrabber getFreshData];


    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh target:self action:@selector(getNewData)];
    
    refreshControl = [[UIRefreshControl alloc] init];
    [refreshControl addTarget:self action:@selector(getNewData) forControlEvents:UIControlEventValueChanged];
    [self.tableView addSubview:refreshControl];

}

-(void) getNewData {
    [dataGrabber getFreshData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return [IGpostArray count];
}

-(void) provide:(NSArray *)freshData{
    [refreshControl endRefreshing];
    [IGpostArray removeAllObjects];//try
    [IGpostArray addObjectsFromArray:freshData];
    [self.tableView reloadData];
    
}

-(void) didFailWithError:(NSString *)theErrorString{
    UIAlertView *theAlert = [[UIAlertView alloc] initWithTitle:@"Download Error" message:theErrorString delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
    [theAlert show];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    PostViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    IGPost *Post = [IGpostArray objectAtIndex:indexPath.row];
    
    // Configure the cell...
    if (!cell) {
        cell =(PostViewCell *)[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        
    }
    
    [cell drawMyCell:Post];
    
    
    if (!self.loadingMoreTableViewData) {
            self.loadingMoreTableViewData = YES;
            [self performSelector:@selector(addSomeMoreEntriesToTableView) withObject:nil afterDelay:0];
        }
    
    return cell;
}

- (void)addSomeMoreEntriesToTableView {
    
    NSDictionary * dict = [dataGrabber fetchNewData];
    NSArray *array = [dict objectForKey:@"data"];
    for (NSDictionary *dictionary in array) {
        
        NSString *username = [[dictionary objectForKey:@"user"] objectForKey:@"username"];
        NSString *largeImg = [[[dictionary objectForKey:@"images"] objectForKey:@"standard_resolution"] objectForKey:@"url"];
        NSString *medImg = [[[dictionary objectForKey:@"images"] objectForKey:@"low_resolution"] objectForKey:@"url"];
        NSString *smallimg = [[[dictionary objectForKey:@"images"] objectForKey:@"thumbnail"] objectForKey:@"url"];
        NSString *profilePic = [[dictionary objectForKey:@"user"] objectForKey:@"profile_picture"];
        NSString *caption = [dictionary objectForKey:@"caption"];
        
        IGPost *post = [[IGPost alloc] initWithUsername:username profilePicture:profilePic lowResImage:medImg hiResImage:largeImg smallImage:smallimg caption:caption];
        
        [IGpostArray addObject:post];
    }
    
    self.loadingMoreTableViewData = NO;
    [self.tableView reloadData];
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 200;
}



@end
