//
//  AppDelegate.h
//  MK_ModelManagerSample
//
//  Created by MurataKazuki on 2013/10/22.
//  Copyright (c) 2013年 MK. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UserManager.h"
#import "UserManager2.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

//@property (strong, nonatomic) UserManager *um;
@property (strong, nonatomic) UserManager2 *um;
@property (strong, nonatomic) UIWindow *window;

@end
