//
//  StudentTableViewController.m
//  MK_CoreDataSchoolMember
//
//  Created by MurataKazuki on 2013/12/15.
//  Copyright (c) 2013年 MK. All rights reserved.
//

#import "StudentTableViewController.h"
#import "CustomCell.h"
#import "Student.h"
#import "ImageData.h"

@interface StudentTableViewController (){

    //TableView表示用データ（Classroomオブジェクトの配列）
    NSMutableArray *_dataArray;
}

@end

@implementation StudentTableViewController
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
    self.title = [NSString stringWithFormat:@"%@組",self.classroom.name];
    
    //バーの設定
    self.navigationItem.rightBarButtonItem
    = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd
                                                    target:self action:@selector(addItem)];
    
    //セルの登録
    [self.tableView registerClass:CustomCell.class forCellReuseIdentifier:CellIdentifier];
    
    //***** 引き継いだClassroomオブジェクト内のStudentsプロパティ ******
    //（リレーションにあるstudentオブジェクトがすべて入っている）
    //メンバーを追加できるように、mutableCopy
    _dataArray = [self.classroom.students.allObjects mutableCopy];
}
//クラスメンバー情報の追加メソッド
-(void)addItem
{
    //student入力用モーダルの準備
    StudentInputModal *modal = [[StudentInputModal alloc] init];
    //Delegateの設定
    modal.delegate = self;
    //モーダル表示
    [self presentViewController:modal animated:YES completion:nil];
}

//モーダル入力完了後のDelegateメソッド
//（引数のinputDataに入力された情報が格納されている）
-(void) modalInputFinished:(NSDictionary *)inputData{
    NSLog(@"%@",inputData);
    
    //***** 新規クラスオブジェクトの作成 *****
    //（alloc,initで作成してはいけない。必ずCoreDataから新規オブジェクトを取得する）
    Student *newStudent = (Student *)[NSEntityDescription insertNewObjectForEntityForName:@"Student"
                                                                   inManagedObjectContext:self.managedObjectContext];
    //新規Studentオブジェクトの値設定（名前、性別、誕生日のプロパティを設定）
    newStudent.name = inputData[@"name"];
    newStudent.sex = inputData[@"sex"];
    newStudent.birthday = inputData[@"birthday"];

    //生徒のイメージ画像を読み込み（フォトライブラリなどから読み込めるが、ここではサンプルの固定画像）
    ImageData *imageData = (ImageData *)[NSEntityDescription insertNewObjectForEntityForName:@"ImageData"
                                                                      inManagedObjectContext:self.managedObjectContext];
    imageData.data = [[NSData alloc] initWithData:UIImageJPEGRepresentation([UIImage imageNamed:@"cat.jpg"], 1.0)];
    
    //新規Studentオブジェクトの値設定（イメージ画像）
    newStudent.imageData = imageData;
    [self.classroom addStudentsObject:newStudent];
    
    //CoreData上のデータ反映
    NSError *error = nil;
    if (![self.managedObjectContext save:&error]) {
        NSLog(@"save error");
    }
    
    //TableView上へのデータ反映
    [_dataArray insertObject:newStudent atIndex:0];
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
static NSString *sexDescription[] = {@"男性",@"女性"};
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    //表示データから取得したStudentオブジェクトからプロパティ値を表示
    Student *student = (Student *)_dataArray[indexPath.row];
    cell.textLabel.text
        = [NSString stringWithFormat:@"%@ %@",student.name,sexDescription[[student.sex intValue]]];
    cell.detailTextLabel.text
        = [student.birthday description];
    cell.imageView.image = [UIImage imageWithData:student.imageData.data];
    
    return cell;
}
@end
