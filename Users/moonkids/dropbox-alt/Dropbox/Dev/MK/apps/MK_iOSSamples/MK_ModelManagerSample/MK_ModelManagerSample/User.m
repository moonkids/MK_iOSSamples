//
//  User.m
//  MK_ModelManagerSample
//
//  Created by MurataKazuki on 2013/10/22.
//  Copyright (c) 2013年 MK. All rights reserved.
//

#import "User.h"
@implementation User

//Userインスタンスを作成する時の初期化メソッド
-(User *)initWithName:(NSString *)name age:(NSNumber *)age sex:(NSString *)sex{
    _name = name;
    _age = age;
    _sex = sex;
    return self;
}
@end
