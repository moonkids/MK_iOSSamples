//
//  AppDelegate.m
//  MK_CSVLoad
//
//  Created by MurataKazuki on 2014/02/04.
//  Copyright (c) 2014年 MK. All rights reserved.
//

#import "AppDelegate.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    [self readQuestionData];
    return YES;
}

-(void)readQuestionData{
    //リターンするplist用配列を用意
    NSMutableArray *csvArray = [@[] mutableCopy];
    
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"question" ofType:@"csv"];
    NSString *csvString = [NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:nil];
    
    NSArray *csvLines = [csvString componentsSeparatedByString:@"\n"];
    
    //plistのkeyとなるものをcsvの一行目の列からカンマ区切りで配列に格納
    NSArray *keys = [csvLines[1] componentsSeparatedByString:@","];
    
    //行数分、辞書化してからplistArrayに格納
    //見出し２行分を飛ばすためにiは2からスタート
    for (int i = 2; i < [csvLines count]; i++) {
        
        //一行データをカンマ区切りで配列に格納
        NSArray *items = [csvLines[i] componentsSeparatedByString:@","];
        
        //最後にリターンする配列に格納する辞書をkeyの数分、作成し追加
        NSMutableDictionary *item = [@{} mutableCopy];
        
        for (int i = 0; i < [keys count]; i++) {
            NSString *value = items[i];
            [item setValue:value forKey:keys[i]];
        }
        
        [csvArray addObject:item];
    }
    self.questionData = csvArray;
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
