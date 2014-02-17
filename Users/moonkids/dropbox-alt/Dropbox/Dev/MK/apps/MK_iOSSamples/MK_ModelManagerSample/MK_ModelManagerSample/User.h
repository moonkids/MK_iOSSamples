//
//  User.h
//  MK_ModelManagerSample
//
//  Created by MurataKazuki on 2013/10/22.
//  Copyright (c) 2013年 MK. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface User : NSObject
//名前＝文字列
@property (strong,nonatomic) NSString *name;
//年齢＝数値（オブジェクト）
@property (strong,nonatomic) NSNumber *age;
//性別＝文字列
@property (strong,nonatomic) NSString *sex;


//@property (strong,nonatomic) NSArray *friends;

//Userインスタンスを作成する時の初期化メソッド
-(User *)initWithName:(NSString *)name age:(NSNumber *)age sex:(NSString *)sex;
@end
