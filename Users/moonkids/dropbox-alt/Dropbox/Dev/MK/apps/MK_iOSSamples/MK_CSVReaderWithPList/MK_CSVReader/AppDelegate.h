//
//  AppDelegate.h
//  MK_CSVReader
//
//  Created by MurataKazuki on 2013/11/27.
//  Copyright (c) 2013年 MK. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

//他のクラスから参照できるように、CSVデータを保持するプロパティを作成
@property (strong, nonatomic) NSArray *dataArray;

@end
