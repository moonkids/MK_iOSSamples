//
//  AppDelegate.m
//  MK_CSVReader
//
//  Created by MurataKazuki on 2013/11/27.
//  Copyright (c) 2013年 MK. All rights reserved.
//

#import "AppDelegate.h"
@implementation AppDelegate

static NSString *plistName = @"data.plist";
static NSString *favoritesPlistName = @"favorites.plist";

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    NSArray *dirPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,
                                                            NSUserDomainMask,
                                                            YES);
    NSString *filePath = [dirPaths[0] stringByAppendingPathComponent:plistName];
    NSString *favoritesFilePath = [dirPaths[0] stringByAppendingPathComponent:favoritesPlistName];

    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];

    
    BOOL isCSVRead = [defaults boolForKey:@"isCSVRead"];
    if (isCSVRead == NO) {
        NSLog(@"CSV not yet read");
        self.dataArray = [[self readCSV:@"23AICHI2"] mutableCopy];
        
        [self.dataArray writeToFile:filePath atomically:YES];
        
        [defaults setBool:YES forKey:@"isCSVRead"];
        [defaults synchronize];
        
        //***************************************
        //初回に空のお気に入りファイルを作っておく
        //***************************************
        [@[] writeToFile:favoritesFilePath atomically:YES];

    } else {

        //csvを既に読み込んでいる場合には、plistからデータを読み込む
        self.dataArray = [NSArray arrayWithContentsOfFile:filePath];
    }
    
    //***************************************
    //ファイルからお気に入り一覧を読み込む
    //***************************************
    self.favoritesArray = [[NSArray arrayWithContentsOfFile:favoritesFilePath] mutableCopy];
    NSLog(@"favorites=%d,%@",[self.favoritesArray count],self.favoritesArray);
    
    //データ内のzipコードが、お気に入り一覧に存在していれば、チェック情報を付ける
    for (int i=0; i < [self.dataArray count]; i++) {
    
        //データ配列の1件のデータに、isFavoriteというYES,NOの値を設定しておく
        //（TableViewでチェックを付けるかどうかに利用）
        NSMutableDictionary *record = [self.dataArray[i] mutableCopy];
        if ([self.favoritesArray indexOfObject:record[@"zip"]] == NSNotFound) {
            record[@"isFavorite"] = @NO;
        } else {
            record[@"isFavorite"] = @YES;
        }
        //データに情報を入れなおす
        self.dataArray[i] = record;
    }
    
    return YES;
}

//***************************************
//お気に入り一覧をファイルに保存する
//***************************************
-(void)saveFavorites{
    NSArray *dirPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,
                                                            NSUserDomainMask,
                                                            YES);
    NSString *favoritesFilePath = [dirPaths[0] stringByAppendingPathComponent:favoritesPlistName];
    [self.favoritesArray writeToFile:favoritesFilePath atomically:YES];
    
}

//***************************************
//CSVから読み込むメソッド（ファイル名が引数＝.csvは不要）
//***************************************
-(NSArray *)readCSV:(NSString *)csvFileName{
    NSString *bundleFilePath = [[NSBundle mainBundle] pathForResource:csvFileName ofType:@"csv"];

    NSString *csvString = [NSString stringWithContentsOfFile:bundleFilePath encoding:NSUTF8StringEncoding error:nil];
    
    NSMutableArray *csvDataArray = [NSMutableArray arrayWithCapacity:0];

    NSArray *lines = [csvString componentsSeparatedByString:@"\r\n"];
    
    NSString *keyRow = [lines[0] stringByReplacingOccurrencesOfString:@"\"" withString:@""];
    NSArray *keyNames = [keyRow componentsSeparatedByString:@","];
    
    for (int rowNumber = 1; rowNumber < lines.count;rowNumber++) {
        NSString *row = lines[rowNumber];
        row = [row stringByReplacingOccurrencesOfString:@"\"" withString:@""];
        
        NSArray *items = [row componentsSeparatedByString:@","];

        NSDictionary *item = [[NSDictionary alloc] initWithObjects:items forKeys:keyNames];
        
        [csvDataArray addObject:item];
    }
    NSLog(@"csv count = %d",csvDataArray.count);
    
    return csvDataArray;
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
