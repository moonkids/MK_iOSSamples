//
//  AppDelegate.m
//  MK_CSVReader
//
//  Created by MurataKazuki on 2013/11/27.
//  Copyright (c) 2013年 MK. All rights reserved.
//

#import "AppDelegate.h"
@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    //***************************************
    //アプリの起動時に、CSVファイルの内容を読み込む
    //***************************************

    //読み込んだNSArrayデータは、他のクラス（ViewConrtrollerなど）から参照できるように、.hのプロパティに格納
    self.dataArray = [self readCSV:@"23AICHI2"];
    
    return YES;
}

//***************************************
//CSVから読み込むメソッド（ファイル名が引数＝.csvは不要）
//***************************************
-(NSArray *)readCSV:(NSString *)csvFileName{
    //Bundleリソース上のファイルを参照する場合（読み込み専用）
    NSString *bundleFilePath = [[NSBundle mainBundle] pathForResource:csvFileName ofType:@"csv"];
    
    //ファイル内容をすべて、文字列として変数内に読み込む
    NSString *csvString = [NSString stringWithContentsOfFile:bundleFilePath encoding:NSUTF8StringEncoding error:nil];
    
    //読み込んだCSVデータを格納するためのNSArray（可変長で後からデータを追加できるように、最初は要素数0）
    NSMutableArray *csvDataArray = [NSMutableArray arrayWithCapacity:0];

    //読み込んだ文字列を、改行文字で区切って配列に格納する（ファイルの改行コードに合わせる必要がある）
    NSArray *lines = [csvString componentsSeparatedByString:@"\r\n"];
    
    //1行目にキーの名前を入れておくと、CSVを編集するだけでデータを増やせるようになる
    //CSVファイルは、ダブルクォーテーションでデータを囲うため、ダブルクォーテーションを取り除く（データ内にダブルクォーテーションがある場合には修正が必要）
    NSString *keyRow = [lines[0] stringByReplacingOccurrencesOfString:@"\"" withString:@""];
    //1行目の文字列を、カンマで区切ってキー名用の配列に格納しておく
    NSArray *keyNames = [keyRow componentsSeparatedByString:@","];
    
    //2行目から先を、順番に処理
    for (int rowNumber = 1; rowNumber < lines.count;rowNumber++) {
        //処理中の行の文字列を取得
        NSString *row = lines[rowNumber];
        //処理中の行の文字列からダブルクォーテーションを取り除く
        row = [row stringByReplacingOccurrencesOfString:@"\"" withString:@""];
        
        //処理中の行の文字列を、カンマで区切って1行分のデータ用の配列に格納する
        NSArray *items = [row componentsSeparatedByString:@","];

        //処理中の1行分のデータ配列を、キー名用の配列と組み合わせてNSDictionaryを作成
        NSDictionary *item = [[NSDictionary alloc] initWithObjects:items forKeys:keyNames];
        
        //CSVデータにNSDictionaryを追加
        [csvDataArray addObject:item];
    }
    NSLog(@"csv count = %d",csvDataArray.count);
    
    //完成したCSVデータを戻り値として返す
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
