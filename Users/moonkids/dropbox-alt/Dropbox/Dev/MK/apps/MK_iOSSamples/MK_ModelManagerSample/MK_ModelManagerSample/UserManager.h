//
//  UserManager.h
//  MK_ModelManagerSample
//
//  Created by MurataKazuki on 2013/10/22.
//  Copyright (c) 2013年 MK. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "User.h"

@interface UserManager : NSObject


//Userデータ初期化メソッド
-(void) loadUsers;
//Userデータ追加メソッド（未使用）
-(void) addUser:(User *)newUser sectionNumber:(int) sectionNum;

//Userデータ取得メソッド
-(User *) getUserWithRowNumber:(int) rowNum sectionNumber:(int)sectionNum ;
//Userデータ件数取得メソッド

-(int) getUserCountWithSectionNumber:(int)sectionNum ;
//Userデータセクション数取得メソッド
-(int) getSectionCount ;
//Userデータセクションヘッダー取得メソッド
-(NSString *) getSectionName:(int)sectionNum;
@end
