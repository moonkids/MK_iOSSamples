//
//  AppDelegate.m
//  MK_EnumPropertySample
//
//  Created by MurataKazuki on 2013/10/27.
//  Copyright (c) 2013年 MK. All rights reserved.
//

#import "AppDelegate.h"
#import "User.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    
    //ユーザ作成時に、カテゴリのEnum値を使用
    User *user1 = [[User alloc] initWithName:@"taro" age:@20 category:UserCategoryTypeFriends];
    NSLog(@"%@",user1.name);
    NSLog(@"%@",user1.age);
    
    //カテゴリのEnum値で条件分岐（NSInteger＝数値型なのでSwitch文が使える）
    switch (user1.category) {
        case UserCategoryTypeMyself:
            NSLog(@"カテゴリは　UserCategoryTypeMyself=%d　です",user1.category);
            break;
        case UserCategoryTypeFamily:
            NSLog(@"カテゴリは　UserCategoryTypeFamily=%d　です",user1.category);
            break;
        case UserCategoryTypeFriends:
            NSLog(@"カテゴリは　UserCategoryTypeFriends=%d　です",user1.category);
            break;
    }
    
    //カテゴリ値を使って文字列を選択（数値型なのでArrayのインデックスに使える）
    NSArray *labels = @[@"自分",@"家族",@"友達"];
    NSLog(@"ラベルの文字列は、[%@]",labels[user1.category]);
    
    
    self.window.backgroundColor = [UIColor whiteColor];
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
