//
//  ListViewController.m
//  MK_EditableTableSample
//
//  Created by MurataKazuki on 2013/10/08.
//  Copyright (c) 2013年 MK. All rights reserved.
//

#import "ListViewController.h"
#import "DetailViewController.h"

@interface ListViewController (){
    NSMutableDictionary *myself;
    NSMutableDictionary *friends;
    NSMutableDictionary *family;
}

@end

@implementation ListViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
        self.tabBarItem = [[UITabBarItem alloc] initWithTabBarSystemItem:UITabBarSystemItemFeatured tag:0];
        self.tabBarItem.title = @"A.配列を分けて管理";

        self.title = @"A.配列を分けて管理";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    myself = [@{@"label":@"MySelf（自分）",@"users":[@[] mutableCopy]} mutableCopy];
    friends = [@{@"label":@"Friends（友達）",@"users":[@[] mutableCopy]} mutableCopy];
    family = [@{@"label":@"Family（家族）",@"users":[@[] mutableCopy]} mutableCopy];
    
    //テスト用データ
    [myself[@"users"] addObject:@{@"name":@"山田",@"age":@"20",@"sex":@"男性"}];
    [friends[@"users"] addObject:@{@"name":@"田中",@"age":@"20",@"sex":@"男性"}];
    [friends[@"users"] addObject:@{@"name":@"志村",@"age":@"20",@"sex":@"男性"}];
    [friends[@"users"] addObject:@{@"name":@"氷室",@"age":@"20",@"sex":@"男性"}];
    [family[@"users"] addObject:@{@"name":@"たろう",@"age":@"20",@"sex":@"男性"}];
    [family[@"users"] addObject:@{@"name":@"ようこ",@"age":@"20",@"sex":@"男性"}];
    [family[@"users"] addObject:@{@"name":@"たけお",@"age":@"20",@"sex":@"男性"}];

    self.clearsSelectionOnViewWillAppear = NO;
    self.navigationItem.rightBarButtonItem = self.editButtonItem;

    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCompose target:self action:@selector(insert)];
    self.navigationItem.leftBarButtonItem = leftItem;
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    int number = 0;
    switch (section) {
        case 0:
            //表示対象のセクションが、0ならmyselfのusers配列の要素数が、セクションの行数となる
            number =  [myself[@"users"] count];
            break;
        case 1:
            //表示対象のセクションが、1ならfriendsのusers配列の要素数が、セクションの行数となる
            number =  [friends[@"users"] count];
            break;
        case 2:
            //表示対象のセクションが、2ならfamilyのusers配列の要素数が、セクションの行数となる
            number =  [family[@"users"] count];
            break;
    }
    return number;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if(nil == cell){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    switch (indexPath.section) {
        case 0:
            //表示対象のセルのセクションが、0ならmyselfのusers配列からデータを表示
            cell.textLabel.text = myself[@"users"][indexPath.row][@"name"];
            break;
        case 1:
            //表示対象のセルのセクションが、1ならfriendsのusers配列からデータを表示
            cell.textLabel.text = friends[@"users"][indexPath.row][@"name"];
            break;
        case 2:
            //表示対象のセルのセクションが、1ならfamilyのusers配列からデータを表示
            cell.textLabel.text = family[@"users"][indexPath.row][@"name"];
            break;
    }
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    NSString *headerTitle = @"";
    switch (section) {
        case 0:
            //表示対象のセクションが、0ならmyselfのlabelの値がヘッダー文字列となる
            headerTitle = myself[@"label"];
            break;
        case 1:
            //表示対象のセクションが、1ならfriendsのlabelの値がヘッダー文字列となる
            headerTitle = friends[@"label"];
            break;
        case 2:
            //表示対象のセクションが、2ならfamilyのlabelの値がヘッダー文字列となる
            headerTitle = family[@"label"];
            break;
    }
    return headerTitle;
}
-(void)insert{
    NSLog(@"insert");
    //別画面で入力
    
    [self regist];
}

-(void)regist{
    NSLog(@"insert");
    
    //別画面で入力終了
    NSDictionary *newUser = @{@"name":@"XXX",@"age":@"100",@"sex":@"テスト"};
    NSString *newUserType = @"じぶん"; //テスト用なので、別画面で追加先の種類を選ばせる（文字列の場合）
    
    NSMutableArray *targetArray = nil;
    int newUserSection = 0;
    
    //挿入データの挿入先が「じぶん」「ともだち」「かぞく」のどれかなので、どの配列にデータを入れるかを特定
    if ([newUserType isEqualToString:@"じぶん"]) {
        //じぶんのデータの時には、myselfのusers配列をデータの追加対象とする
        //じぶんのデータの時には、セクション0に対して行を追加する（アニメーション用）
        newUserSection = 0;
        targetArray = myself[@"users"];
    }
    else if ([newUserType isEqualToString:@"ともだち"]) {
        //ともだちのデータの時には、friendsのusers配列をデータの追加対象とする
        //ともだちのデータの時には、セクション1に対して行を追加する（アニメーション用）
        newUserSection = 1;
        targetArray = friends[@"users"];
    }
    else if ([newUserType isEqualToString:@"かぞく"]) {
        //かぞくのデータの時には、familyのusers配列をデータの追加対象とする
        //かぞくのデータの時には、セクション2に対して行を追加する（アニメーション用）
        newUserSection = 2;
        targetArray = family[@"users"];
    }
    //対象の配列に、新しいユーザデータを追加
    [targetArray addObject:newUser];
    
    //アニメーション用に、どのセクションの、何行目にデータを追加したのかを特定
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:(targetArray.count -1 ) inSection:newUserSection];
    //アニメーション動作
    [self.tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
}


// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        switch (indexPath.section) {
            case 0:
                //削除対象のセクションが、0ならmyselfのusers配列に対して削除処理を行う
                [myself[@"users"] removeObjectAtIndex:indexPath.row];
                break;
            case 1:
                //削除対象のセクションが、1ならfriendsのusers配列に対して削除処理を行う
                [friends[@"users"] removeObjectAtIndex:indexPath.row];
                break;
            case 2:
                //削除対象のセクションが、2ならfamilyのusers配列に対して削除処理を行う
                [family[@"users"] removeObjectAtIndex:indexPath.row];
                break;
        }
        //アニメーション動作
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    DetailViewController *detailViewController = [[DetailViewController alloc] init];
    
    int rownumber = indexPath.row;
    int section = indexPath.section;
    NSLog(@"%d,%d",rownumber,section);
    
    switch (section) {
        case 0:
            //詳細画面に表示するデータのセクションが、0ならmyselfのusers配列からデータを取り出して、詳細画面のプロパティにセット
            detailViewController.userdata = myself[@"users"][rownumber];
            break;
        case 1:
            //詳細画面に表示するデータのセクションが、1ならfriendsのusers配列からデータを取り出して、詳細画面のプロパティにセット
            detailViewController.userdata = friends[@"users"][rownumber];
            break;
        case 2:
            //詳細画面に表示するデータのセクションが、2ならfriendsのusers配列からデータを取り出して、詳細画面のプロパティにセット
            detailViewController.userdata = family[@"users"][rownumber];
            break;
    }
    [self.navigationController pushViewController:detailViewController animated:YES];
    
}

@end
