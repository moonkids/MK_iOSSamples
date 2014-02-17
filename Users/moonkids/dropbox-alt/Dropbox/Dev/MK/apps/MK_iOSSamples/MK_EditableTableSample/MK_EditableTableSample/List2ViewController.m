//
//  List2ViewController.m
//  MK_EditableTableSample
//
//  Created by MurataKazuki on 2013/10/08.
//  Copyright (c) 2013年 MK. All rights reserved.
//

#import "List2ViewController.h"
#import "DetailViewController.h"

@interface List2ViewController (){
    
    /***********************/
    //  Aと異なっている箇所・・・インスタンス変数は3種類のDictionaryを入れる配列1つだけ
    /***********************/
    NSMutableArray *users;
}

@end

@implementation List2ViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
        self.tabBarItem = [[UITabBarItem alloc] initWithTabBarSystemItem:UITabBarSystemItemFeatured tag:0];
        self.tabBarItem.title = @"B.セクションで配列化";
        
        self.title = @"B.セクションで配列化";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    /***********************/
    //  Aと異なっている箇所・・・インスタンス変数は3種類のDictionaryを入れる配列だけ
    /***********************/
    NSMutableDictionary *myself = [@{@"label":@"MySelf（自分）",@"users":[@[] mutableCopy]} mutableCopy];
    NSMutableDictionary *friends = [@{@"label":@"Friends（友達）",@"users":[@[] mutableCopy]} mutableCopy];
    NSMutableDictionary *family = [@{@"label":@"Family（家族）",@"users":[@[] mutableCopy]} mutableCopy];

    /***********************/
    //  Aと異なっている箇所・・・usersが配列なので、0番目がmyself用、1番目がfriends用、2番目がfamily用
    /***********************/
    users = [NSMutableArray array];
    [users insertObject:myself atIndex:0];
    [users insertObject:friends atIndex:1];
    [users insertObject:family atIndex:2];
    
    //もちろん以下でも良い
    //users = [@[myself,friends,family] mutableCopy];
    

    //テスト用データ
    /***********************/
    //  Aと異なっている箇所・・・usersが配列なので、0番目がmyself用、1番目がfriends用、2番目がfamily用
    /***********************/
    [users[0][@"users"] addObject:@{@"name":@"山田",@"age":@"20",@"sex":@"男性"}];
    [users[1][@"users"] addObject:@{@"name":@"田中",@"age":@"20",@"sex":@"男性"}];
    [users[1][@"users"] addObject:@{@"name":@"志村",@"age":@"20",@"sex":@"男性"}];
    [users[1][@"users"] addObject:@{@"name":@"氷室",@"age":@"20",@"sex":@"男性"}];
    [users[2][@"users"] addObject:@{@"name":@"たろう",@"age":@"20",@"sex":@"男性"}];
    [users[2][@"users"] addObject:@{@"name":@"ようこ",@"age":@"20",@"sex":@"男性"}];
    [users[2][@"users"] addObject:@{@"name":@"たけお",@"age":@"20",@"sex":@"男性"}];
    
    NSLog(@"%@",users);

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
    /***********************/
    //  Aと異なっている箇所・・・データの種類により配列を選ぶ必要がなくなり、そのままセクションの値で行数を特適できるようになる
    /***********************/
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
    /***********************/
    //  Aと異なっている箇所・・・データの種類により配列を選ぶ必要がなくなり、そのままセクションの値で表示データを特適できるようになる
    /***********************/
    cell.textLabel.text = users[indexPath.section][@"users"][indexPath.row][@"name"];
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    NSString *headerTitle = @"";
    /***********************/
    //  Aと異なっている箇所・・・データの種類により配列を選ぶ必要がなくなり、そのままセクションの値でセクションヘッダーを特適できるようになる
    /***********************/
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
}


// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        /***********************/
        //  Aと異なっている箇所・・・データの種類により配列を選ぶ必要がなくなり、そのままセクションの値で削除するデータを特適できるようになる
        /***********************/
        [users[indexPath.section][@"users"] removeObjectAtIndex:indexPath.row];
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
    
    detailViewController.userdata = users[section][@"users"][rownumber];
    [self.navigationController pushViewController:detailViewController animated:YES];
}

@end
