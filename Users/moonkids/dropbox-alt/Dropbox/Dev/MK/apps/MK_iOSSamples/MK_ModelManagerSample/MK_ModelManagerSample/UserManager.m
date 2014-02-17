//
//  UserManager.m
//  MK_ModelManagerSample
//
//  Created by MurataKazuki on 2013/10/22.
//  Copyright (c) 2013年 MK. All rights reserved.
//

#import "UserManager.h"

@interface UserManager()
@property (strong,nonatomic) NSMutableArray *users;
@end

@implementation UserManager

-(void)loadUsers{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSArray *users = [userDefaults objectForKey:@"users"];
    if (users == nil) {
        
        NSDictionary *myself = @{@"label":@"自分", @"users":@[@{@"name":@"わたし",@"age":@20,@"sex":@"男性"}]};
        NSDictionary *family = @{@"label":@"家族", @"users":@[@{@"name":@"たろう",@"age":@20,@"sex":@"男性"},@{@"name":@"はなこ",@"age":@20,@"sex":@"女性"}]};
        NSDictionary *friends = @{@"label":@"友達", @"users":@[@{@"name":@"山田",@"age":@20,@"sex":@"女性"},@{@"name":@"加藤",@"age":@20,@"sex":@"男性"}]};
        
        users = @[myself, family, friends];
    }
    //UserDefaultsから読んでも、初期化してもどちらもNSArrayなので、NSMutableArrayに変換
    self.users = (NSMutableArray*)CFBridgingRelease(
                                                    CFPropertyListCreateDeepCopy(NULL,
                                                                                 (CFArrayRef)users,                                                                                     kCFPropertyListMutableContainersAndLeaves));

    NSLog(@"UserManager:loadusers:%@",[self.users isKindOfClass:NSMutableArray.class]?@"YES":@"NO");
}




-(void)addUser:(User *)newUser sectionNumber:(int) sectionNum{
    [self.users[sectionNum][@"users"] addObject:newUser];
}



-(User *) getUserWithRowNumber:(int) rowNum sectionNumber:(int)sectionNum {
    //NSArray+NSDictionaryのユーザデータ内から、該当する一件のユーザ情報を取得
    //Dictionaryとして取り出される
    NSDictionary *targetDic = self.users[sectionNum][@"users"][rowNum];
    
    User *targetUser = [[User alloc] init];
    targetUser.name = targetDic[@"name"];
    targetUser.age = targetDic[@"age"];
    targetUser.sex = targetDic[@"sex"];
    return targetUser;
}







-(int) getUserCountWithSectionNumber:(int)sectionNum{
    return [self.users[sectionNum][@"users"] count];
}
-(NSString *) getSectionName:(int)sectionNum{
    return self.users[sectionNum][@"label"];
}

-(int) getSectionCount{
    return [self.users count];
}

@end
