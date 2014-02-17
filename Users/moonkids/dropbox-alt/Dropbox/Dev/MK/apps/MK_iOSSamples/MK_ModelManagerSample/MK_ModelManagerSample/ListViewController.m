//
//  ListViewController.m
//  LifeTimer
//
//  Created by Hayato on 13/09/30.
//  Copyright (c) 2013年 Crazyonez. All rights reserved.
//

#import "ListViewController.h"
#import "AppDelegate.h"
#import "User.h"

@interface ListViewController (){
    AppDelegate *appDelegate;
}

@end

@implementation ListViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        
        //タブバーアイコンの設定
        self.tabBarItem = [[UITabBarItem alloc] initWithTabBarSystemItem:UITabBarSystemItemFeatured tag:0];
        self.tabBarItem.title = @"リスト";
        NSLog(@"init");
    }
    return self;
}




- (void)viewDidLoad
{
    [super viewDidLoad];
    appDelegate =(AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    /*----------------------------------------------------------------
                            ナビゲーションバーの設定
     -----------------------------------------------------------------*/
    
    NSLog(@"viewDidLoad");
    self.navigationItem.rightBarButtonItem = [self editButtonItem];
    
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCompose target:self action:@selector(foo)];
    self.navigationItem.leftBarButtonItem = leftItem;

    self.navigationController.navigationBar.tintColor = [UIColor redColor];
    self.navigationItem.title = @"リスト";
}

-(void)foo{
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

//セクションの数を返す
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    NSLog(@"%d",[appDelegate.um getSectionCount]);
    return [appDelegate.um getSectionCount];
}

//セクション毎の行数を返す
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [appDelegate.um getUserCountWithSectionNumber:section];
}

//セクション毎のヘッダー文字列を返す
-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    
    
    return [appDelegate.um getSectionName:section];
}


//indexPathで指定された箇所のセルを作る
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if(nil == cell){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    
    //UserManagerから対象のUserオブジェクトを取得
    User *targetUser = [appDelegate.um getUserWithRowNumber:indexPath.row sectionNumber:indexPath.section];
    
    NSLog(@"%@",targetUser);
    
    //Userオブジェクトのプロパティ情報をListに表示
    cell.textLabel.text = targetUser.name;
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%d歳",[targetUser.age intValue]];

    return cell;
}





/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/



- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
//    if (editingStyle == UITableViewCellEditingStyleDelete) {
//
//        [_users[indexPath.section][@"users"] removeObjectAtIndex:indexPath.row];
//        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
//        
//        [_application saveData];
//    }
//    else if (editingStyle == UITableViewCellEditingStyleInsert) {
//        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
//    }
}





#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
//    
//    DetailViewController *detailViewController = [[DetailViewController alloc] init];
//    detailViewController.data = _users[indexPath.section][@"users"][indexPath.row];
//    
//    [self.navigationController pushViewController:detailViewController animated:YES];
//    
}




@end
