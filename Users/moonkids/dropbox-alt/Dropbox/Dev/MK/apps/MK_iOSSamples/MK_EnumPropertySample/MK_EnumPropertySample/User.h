//
//  User.h
//  MK_EnumPropertySample
//
//  Created by MurataKazuki on 2013/10/27.
//  Copyright (c) 2013年 MK. All rights reserved.
//

#import <Foundation/Foundation.h>

//enumを宣言（「UserCategoryType」をEnumの型名として扱う）
typedef enum : NSInteger{
    UserCategoryTypeMyself = 0,
    UserCategoryTypeFamily = 1,
    UserCategoryTypeFriends = 2
}UserCategoryType;

@interface User : NSObject
@property (nonatomic,strong) NSString *name;
@property (nonatomic,strong) NSNumber *age;
//カテゴリプロパティをUserCategoryType型で宣言
@property (assign) UserCategoryType category;

//初期化時の引数もUserCategoryType型で宣言
-(User *)initWithName:(NSString *)name age:(NSNumber *)age category:(UserCategoryType)category;
@end
