//
//  List2ViewController.m
//  MK_EditableTableSample
//
//  Created by MurataKazuki on 2013/10/08.
//  Copyright (c) 2013年 MK. All rights reserved.
//

#import "List3ViewController.h"
#import "DetailViewController.h"

@interface List3ViewController (){
    
    NSMutableArray *users;
}

@end

@implementation List3ViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
        self.tabBarItem = [[UITabBarItem alloc] initWithTabBarSystemItem:UITabBarSystemItemFeatured tag:0];
        self.tabBarItem.title = @"C.userDefaultに保存";
        
        self.title = @"C.userDefaultに保存";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    /***********************/
    //  Bと異なっている箇所・・・画面のロード時に、まずuserDefaultsから読み出し
    /***********************/
    
    users = [[NSUserDefaults standardUserDefaults] objectForKey:@"users"];

    //取り出せない場合＝B同様に従来通り、usersの初期化＋テストデータ作成
    if (users == nil) {
        
        NSMutableDictionary *myself = [@{@"label":@"MySelf（自分）",@"users":[@[] mutableCopy]} mutableCopy];
        NSMutableDictionary *friends = [@{@"label":@"Friends（友達）",@"users":[@[] mutableCopy]} mutableCopy];
        NSMutableDictionary *family = [@{@"label":@"Family（家族）",@"users":[@[] mutableCopy]} mutableCopy];
        
        users = [NSMutableArray array];
        [users insertObject:myself atIndex:0];
        [users insertObject:friends atIndex:1];
        [users insertObject:family atIndex:2];
        
        //もちろん以下でも良い
        //users = [@[myself,friends,family] mutableCopy];
        
        
        //テスト用データ
        [users[0][@"users"] addObject:@{@"name":@"山田",@"age":@"20",@"sex":@"男性"}];
        [users[1][@"users"] addObject:@{@"name":@"田中",@"age":@"20",@"sex":@"男性"}];
        [users[1][@"users"] addObject:@{@"name":@"志村",@"age":@"20",@"sex":@"男性"}];
        [users[1][@"users"] addObject:@{@"name":@"氷室",@"age":@"20",@"sex":@"男性"}];
        [users[2][@"users"] addObject:@{@"name":@"たろう",@"age":@"20",@"sex":@"男性"}];
        [users[2][@"users"] addObject:@{@"name":@"ようこ",@"age":@"20",@"sex":@"男性"}];
        [users[2][@"users"] addObject:@{@"name":@"たけお",@"age":@"20",@"sex":@"男性"}];
        
        NSLog(@"%@",users);
    }
    
    self.clearsSelectionOnViewWillAppear = NO;
    self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCompose target:self action:@selector(insert)];
    self.navigationItem.leftBarButtonItem = leftItem;
}


/***********************/
//  Bと異なっている箇所・・・userDefaultsに保存する処理（insertやdelete時に呼び出される）
/***********************/
-(void)saveData{
    [[NSUserDefaults standardUserDefaults] setObject:users forKey:@"users"];
    [[NSUserDefaults standardUserDefaults] synchronize];
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
    number =  [users[section][@"users"] count];
    return number;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if(nil == cell){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    cell.textLabel.text = users[indexPath.section][@"users"][indexPath.row][@"name"];
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    NSString *headerTitle = @"";
    headerTitle = users[section][@"label"];
    return headerTitle;
}
-(void)insert{
    NSLog(@"insert");
    
    [self regist];
}

-(void)regist{
    NSLog(@"insert");
    
    //別画面で入力終了
    NSDictionary *newUser = @{@"name":@"XXX",@"age":@"100",@"sex":@"テスト"};
    NSString *newUserType = @"じぶん";
    
    NSMutableArray *targetArray = nil;
    int newUserSection = 0;
    
    //入力する情報を、文字列ではなく数値で入力するようにできれば、以下のコードも1行にすることもできる
    if ([newUserType isEqualToString:@"じぶん"]) {
        newUserSection = 0;
        targetArray = users[0][@"users"];
    }
    else if ([newUserType isEqualToString:@"ともだち"]) {
        newUserSection = 1;
        targetArray = users[1][@"users"];
    }
    else if ([newUserType isEqualToString:@"かぞく"]) {
        newUserSection = 2;
        targetArray = users[2][@"users"];
    }
    
    [targetArray addObject:newUser];
    
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:(targetArray.count -1 ) inSection:newUserSection];
    [self.tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
    
    
    /***********************/
    //  Bと異なっている箇所・・・データが変更されたのでuserDefaultsに保存させる
    /***********************/
   [self saveData];
}


// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [users[indexPath.section][@"users"] removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        
        /***********************/
        //  Bと異なっている箇所・・・データが変更されたのでuserDefaultsに保存させる
        /***********************/
        [self saveData];
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
    
    detailViewController.userdata = users[section][@"users"][rownumber];
    [self.navigationController pushViewController:detailViewController animated:YES];
}

@end
