//
//  User.m
//  MK_EnumPropertySample
//
//  Created by MurataKazuki on 2013/10/27.
//  Copyright (c) 2013年 MK. All rights reserved.
//

#import "User.h"

@implementation User
//初期化時に、引数をそのままプロパティの値として設定
-(User *)initWithName:(NSString *)name age:(NSNumber *)age category:(UserCategoryType)category{
    _name = name;
    _age = age;
    _category = category;
    return self;
}

@end
