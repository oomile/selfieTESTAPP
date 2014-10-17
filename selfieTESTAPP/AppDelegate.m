//
//  AppDelegate.m
//  selfieTESTAPP
//
//  Created by Obi Omile on 10/16/14.
//  Copyright (c) 2014 Obi Omile. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    [self setupAppearance];
    return YES;
}

- (void) setupAppearance{
    UINavigationBar *navigationBarAppearance = [UINavigationBar appearance];
    //color from sketch file
    navigationBarAppearance.barTintColor = [UIColor colorWithRed:63.0/255.0 green:114.0/255.0 blue:155.0/255.0 alpha:1.0];
    navigationBarAppearance.tintColor = [UIColor whiteColor];
    navigationBarAppearance.titleTextAttributes = @{NSForegroundColorAttributeName: [UIColor whiteColor],
                                                    NSFontAttributeName: [UIFont fontWithName:@"HoeflerText-Italic" size:21.0]};
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    
    
}


@end
