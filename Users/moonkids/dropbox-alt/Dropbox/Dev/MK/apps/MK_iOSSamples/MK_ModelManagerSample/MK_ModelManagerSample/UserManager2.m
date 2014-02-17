//
//  UserManager.m
//  MK_ModelManagerSample
//
//  Created by MurataKazuki on 2013/10/22.
//  Copyright (c) 2013年 MK. All rights reserved.
//

#import "UserManager2.h"

@interface UserManager2(){
}
@property (strong,nonatomic) NSMutableArray *users;
@end

@implementation UserManager2
//
//
//
//UserManager2 *umOrg = nil;
//
//
//
//+(UserManager2 *)getUserManager{
//    if (umOrg == nil) {
//        umOrg = [[UserManager2 alloc] init];
//    }
//    return umOrg;
//}
//
//
//+(void)load{
//    NSLog(@"load");
//}
//

-(void)loadUsers{
    //このままでは、オリジナルクラスUserの配列usersはNSUserDefaults内に保存できないため、
    //UserクラスにNSCodingプロトコルを実装し、NSKeyedArchiverで読み書きする方法を記述する必要がある
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSArray *users = [userDefaults objectForKey:@"users"];
    if (users == nil) {
        
        User *user1 = [[User alloc] initWithName:@"わたし" age:@20 sex:@"男性"];
        User *user2 = [[User alloc] initWithName:@"たろう" age:@20 sex:@"男性"];
        User *user3 = [[User alloc] initWithName:@"はなこ" age:@20 sex:@"女性"];
        User *user4 = [[User alloc] initWithName:@"山田" age:@20 sex:@"女性"];
        User *user5 = [[User alloc] initWithName:@"加藤" age:@20 sex:@"男性"];
        users = @[
                  @[user1],
                  @[user2,user3],
                  @[user4,user5]
        ];
        
        //self.users内がオリジナルクラスなので、DeepCopyが使えないため、MutableCopyが必要
        self.users = [users mutableCopy];
    }
//    self.users = (NSMutableArray*)CFBridgingRelease(
//                                                    CFPropertyListCreateDeepCopy(NULL,
//                                                                                 (CFArrayRef)users,                                                                                     kCFPropertyListMutableContainersAndLeaves));
    
    NSLog(@"UserManager:loadusers:%@",[self.users isKindOfClass:NSMutableArray.class]?@"YES":@"NO");
}




-(void)addUser:(User *)newUser sectionNumber:(int) sectionNum{
    [self.users[sectionNum] addObject:newUser];
}



-(User *) getUserWithRowNumber:(int) rowNum sectionNumber:(int)sectionNum {
    //Userは、usersから直接取得可能
    User *targetUser = self.users[sectionNum][rowNum];
    return targetUser;
}




-(int) getUserCountWithSectionNumber:(int)sectionNum{
    return [self.users[sectionNum] count];
}
//Managerクラスがあれば、ラベルの文字はUserデータとは分けて所持しても問題ない
-(NSString *) getSectionName:(int)sectionNum{
    NSArray *labels = @[@"自分",@"家族",@"友達"];
    //セクションごとのラベルは、別に所持した配列からでも良い
    return labels[sectionNum];
}

-(NSString *) getSectionNameDiscriotion:(int)sectionNum{
    NSArray *labels = @[@"自分のプロフィール",@"家族のユーザ情報",@"友達ユーザ情報"];
    //セクションごとのラベルは、別に所持した配列からでも良い
    return labels[sectionNum];
}

-(int) getSectionCount{
    return [self.users count];
}

@end
