//
//  AppDelegate.m
//  MK_EditableTableSample
//
//  Created by MurataKazuki on 2013/10/08.
//  Copyright (c) 2013年 MK. All rights reserved.
//

#import "AppDelegate.h"
#import "ListViewController.h"
#import "List2ViewController.h"
#import "List3ViewController.h"

@interface AppDelegate(){
    UITabBarController *tabBarController;
}

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor whiteColor];
    
    tabBarController = [[UITabBarController alloc] init];
    
    ListViewController *tab1 = [[ListViewController alloc] init];
    //    ListViewController *tab2 = [[ListViewController alloc] init];
    List2ViewController *tab2 = [[List2ViewController alloc] init];
    List3ViewController *tab3 = [[List3ViewController alloc] init];
    
    //タブ1つ1つにナビゲーションコントローラを設定
    NSArray *tabs = @[[[UINavigationController alloc] initWithRootViewController:tab1]
                      , [[UINavigationController alloc] initWithRootViewController:tab2]
                      , [[UINavigationController alloc] initWithRootViewController:tab3]];
    
    [tabBarController setViewControllers:tabs];
    
    //windowに、tabBarControllerをRootViewControllerとして設定
    self.window.rootViewController = tabBarController;
    //windowには、tabBarControllerを設定
    [self.window addSubview:tabBarController.view];
    
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
