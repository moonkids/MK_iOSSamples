//
//  ClassTableViewController.m
//  MK_CoreDataSchoolMember
//
//  Created by MurataKazuki on 2013/12/15.
//  Copyright (c) 2013年 MK. All rights reserved.
//

#import "ClassTableViewController.h"
#import "Classroom.h"
#import "CustomCell.h"
#import "StudentTableViewController.h"

@interface ClassTableViewController ()
{
    //TableView表示用データ（Classroomオブジェクトの配列）
    NSMutableArray *_dataArray;
    
    //***** CoreData用インスタンス変数指定 *****
    NSEntityDescription *_entityClassroom;
    NSSortDescriptor *_sortForName;
    NSSortDescriptor *_sortForCreateDate;
}

@end

@implementation ClassTableViewController
static NSString *CellIdentifier = @"Cell";

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"MySchool-CLASS";
    
    //バーの設定
    self.navigationItem.rightBarButtonItem
        = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd
                                                    target:self action:@selector(addItem)];

    //セルの登録
    [self.tableView registerClass:CustomCell.class forCellReuseIdentifier:CellIdentifier];
    
    //***** CoreData用のデータ取得（同じ情報を使いまわせるようにインスタンス変数に格納）*****
    //このアプリ上で使用するスキーマ情報（Entity）を取得（テーブル情報の読み出しのようなもの）
    _entityClassroom = [NSEntityDescription entityForName:@"Classroom"
                                                       inManagedObjectContext:self.managedObjectContext];
    //createDateキーによる並び順のSortDescriptor
    _sortForCreateDate = [[NSSortDescriptor alloc] initWithKey:@"createDate" ascending:NO];
    //nameキーによる並び順のSortDescriptor
    _sortForName = [[NSSortDescriptor alloc] initWithKey:@"name" ascending:NO];

    
    //***** CoreDataからのデータのロード *****
    //Requestを作成（条件を付ける場合にはPredicateの指定を追加）
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:_entityClassroom];
    [request setSortDescriptors: @[_sortForCreateDate]];
    
    //データのロード（Fetch）
    NSError *error = nil;
    NSMutableArray *mutableFetchResults = [[self.managedObjectContext
                                            executeFetchRequest:request error:&error] mutableCopy];
    if (mutableFetchResults == nil) {
        NSLog(@"fetch error");
    }

    //ロードしたデータをTableView表示データに格納（Classroomオブジェクトの一覧）
    _dataArray = mutableFetchResults;

}
-(void)viewWillAppear:(BOOL)animated{
    //ビューに戻ってきた時の再表示
    [self.tableView reloadData];
}

//新規クラス番号の取得（A,B,Cという連続番号を付けるための処理）
//CoreData内のデータを検索する例
-(NSString *)getNextClassroomName{
    //Requestを作成（現在のクラス名A,B,Cの最大値を取得）
    //nameでソートして取得数を1にする
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:_entityClassroom];
    [request setSortDescriptors:@[_sortForName]];
    [request setFetchLimit:1];
    
    NSError *error = nil;
    NSMutableArray *mutableFetchResults = [[self.managedObjectContext
                                            executeFetchRequest:request error:&error] mutableCopy];
    if (mutableFetchResults == nil){
        
        NSLog(@"fetch error");
    }
    NSString *nextClassroomName = nil;
    if (mutableFetchResults.count == 0) {
        //データなしならA
        nextClassroomName = @"A";
    } else {
        //現在の最大値に＋１した値（'A'+1 = 'B'となる）
        NSLog(@"%@",mutableFetchResults);
        NSString *lastClassName = [mutableFetchResults[0] name];
        nextClassroomName = [NSString stringWithFormat:@"%c",[lastClassName characterAtIndex:0] + 1];
    }
    NSLog(@"%@",nextClassroomName);
    return nextClassroomName;
}

//クラスルーム情報の追加メソッド
-(void)addItem
{
    //新規クラス番号の取得（A,B,Cという連続番号を付けるための処理）
    //CoreData内のデータを検索する例
    NSString *nextClassroomName = [self getNextClassroomName];

    //***** 新規クラスオブジェクトの作成 *****
    //（alloc,initで作成してはいけない。必ずCoreDataから新規オブジェクトを取得する）
    Classroom *newClassroom = (Classroom *)[NSEntityDescription insertNewObjectForEntityForName:@"Classroom"
                                                          inManagedObjectContext:self.managedObjectContext];
    //新規Classroomオブジェクトの値設定（学年、クラス名、作成日付のプロパティを設定）
    newClassroom.grade = @1;
    newClassroom.name = nextClassroomName;
    newClassroom.createDate = [NSDate date];
    
    //***** CoreData上にデータ反映 *****
    NSError *error = nil;
    if (![self.managedObjectContext save:&error]) {
        NSLog(@"save error");
    }
    
    //TableView上へのデータ反映
    [_dataArray insertObject:newClassroom atIndex:0];
    [self.tableView insertRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:0 inSection:0]]
                          withRowAnimation:UITableViewRowAnimationFade];
    [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]
                          atScrollPosition:UITableViewScrollPositionTop animated:YES];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [_dataArray count];
}

//TableViewのデータ表示
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];

    //表示データから取得したClassroomオブジェクトからプロパティ値を表示
    Classroom *classroom = (Classroom *)_dataArray[indexPath.row];
    
    cell.textLabel.text
        = [NSString stringWithFormat:@"%d年 %@組",[classroom.grade intValue],classroom.name];
    cell.detailTextLabel.text
        = [NSString stringWithFormat:@"%d件",classroom.students.count];
    
    return cell;
}

//TableViewのデータ削除
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {

        //***** 削除対象のClassroomオブジェクトを取得 *****
        Classroom *classroomToDelete = [_dataArray objectAtIndex:indexPath.row];
        //CoreData上のデータ削除
        [self.managedObjectContext deleteObject:classroomToDelete];

        //TableViewデータを更新
        [_dataArray removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:YES];

        //***** CoreData上にデータ反映 *****
        NSError *error = nil;
        if (![self.managedObjectContext save:&error]) {
            NSLog(@"save error");
        }
    }
}
//TableViewセル選択時の処理
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    //***** 表示対象のClassroomオブジェクトを取得 *****
    Classroom *selectedClassroom = _dataArray[indexPath.row];
    
    //Classroom内のStudents一覧表示用ViewControllerを準備
    StudentTableViewController *studentTVC = [[StudentTableViewController alloc] init];
    
    //***** CoreDataプロパティ引き継ぎ *****
    studentTVC.managedObjectContext = self.managedObjectContext;

    //Classroomオブジェクトの引き継ぎ
    studentTVC.classroom = selectedClassroom;
    
    //画面遷移
    [self.navigationController pushViewController:studentTVC animated:YES];
}

@end
