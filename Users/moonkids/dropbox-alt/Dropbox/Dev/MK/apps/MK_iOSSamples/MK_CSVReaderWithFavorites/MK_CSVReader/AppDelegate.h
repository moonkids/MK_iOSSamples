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

//変更可能なように、MutableArrayにしておく
@property (strong, nonatomic) NSMutableArray *dataArray;
@property (strong, nonatomic) NSMutableArray *favoritesArray;

-(void)saveFavorites;
@end
