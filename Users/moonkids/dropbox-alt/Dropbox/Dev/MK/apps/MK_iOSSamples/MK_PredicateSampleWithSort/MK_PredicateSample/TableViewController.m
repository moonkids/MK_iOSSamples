//
//  TableViewController.m
//  MK_PredicateSample
//
//  Created by MurataKazuki on 2013/11/30.
//  Copyright (c) 2013年 MK. All rights reserved.
//

#import "TableViewController.h"

@interface TableViewController (){
    //データ格納用のNSArray
    NSMutableArray *_objects;
    
    //表示用のNSArray
    NSArray *_disp_objects;
}

@end

@implementation TableViewController
- (void)viewDidLoad
{
    [super viewDidLoad];
    _objects = [NSMutableArray arrayWithCapacity:0];
    
    [_objects addObject:@{@"name":@"太郎",@"kana":@"たろう",@"age":@"18",@"grade":@"1"}];
    [_objects addObject:@{@"name":@"二郎",@"kana":@"じろう",@"age":@"20",@"grade":@"2"}];
    [_objects addObject:@{@"name":@"三郎",@"kana":@"さぶろう",@"age":@"18",@"grade":@"1"}];
    [_objects addObject:@{@"name":@"花子",@"kana":@"はなこ",@"age":@"20",@"grade":@"3"}];
    [_objects addObject:@{@"name":@"風子",@"kana":@"ふうこ",@"age":@"19",@"grade":@"2"}];
    [_objects addObject:@{@"name":@"光子",@"kana":@"みつこ",@"age":@"18",@"grade":@"1"}];
    [_objects addObject:@{@"name":@"一郎",@"kana":@"いちろう",@"age":@"50",@"grade":@"1"}];
    
    _disp_objects = _objects;
}

//iOS7以降のステータスバー非表示メソッド
- (BOOL)prefersStatusBarHidden
{
    return YES;
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_disp_objects count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    NSDictionary *record = _disp_objects[indexPath.row];
    
    //ソートの効果がわかりやすいように、表示内容を追加
    //データの"name"を表示
    cell.textLabel.text = [NSString stringWithFormat:@"%@（%@）",record[@"name"],record[@"kana"]];
    //データの"age"を表示
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%@歳（%@年生）",record[@"age"],record[@"grade"]];
    
    return cell;
}

//searchBarで検索ボタンをおした際に呼び出されるメソッド
- (void)searchBarSearchButtonClicked:(UISearchBar*)searchBar
{
    //searchBarからフォーカスを外す（＝キーボードが隠れる）
    [searchBar resignFirstResponder];

    //入力された文字でYoutube検索を行う
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"name contains %@",searchBar.text];
    _disp_objects = [_objects filteredArrayUsingPredicate:predicate];
    
    [self.tableView reloadData];
}
//searchBarでキャンセルボタンをおした際に呼び出されるメソッド
-(void)searchBarCancelButtonClicked:(UISearchBar *)searchBar{
    [searchBar resignFirstResponder];
    searchBar.text = @"";

    _disp_objects = _objects;
    [self.tableView reloadData];
}

//StoryBoardに追加したSegmentedControlの値が変化した時に呼び出されるメソッド
- (IBAction)sortValueChanged:(id)sender {
    UISegmentedControl *segmentControl = (UISegmentedControl *)sender;

    //ソートに用いられるNSSortDescriptor
    NSSortDescriptor *sortDiscriptor;
    switch (segmentControl.selectedSegmentIndex) {
        case 0:
            //各行のどのキーで並べ替えるかを指定（ascending=昇順）
            sortDiscriptor = [[NSSortDescriptor alloc] initWithKey:@"kana" ascending:YES];
            break;
        case 1:
            sortDiscriptor = [[NSSortDescriptor alloc] initWithKey:@"age" ascending:YES];
            break;
        case 2:
            sortDiscriptor = [[NSSortDescriptor alloc] initWithKey:@"grade" ascending:YES];
            break;
    }
    //現在表示中のデータを、NSSortDescriptorの設定で並べ替え
    _disp_objects = [_disp_objects sortedArrayUsingDescriptors:@[sortDiscriptor]];
    
    [self.tableView reloadData];
    
}
-(void)aa{
    NSSortDescriptor *sortDiscriptor1;
    NSSortDescriptor *sortDiscriptor2;
    sortDiscriptor1 = [[NSSortDescriptor alloc] initWithKey:@"kana" ascending:YES];
    sortDiscriptor2 = [[NSSortDescriptor alloc] initWithKey:@"age" ascending:YES];
    
    _disp_objects = [_disp_objects sortedArrayUsingDescriptors:@[sortDiscriptor1,sortDiscriptor2]];
    
}
@end
