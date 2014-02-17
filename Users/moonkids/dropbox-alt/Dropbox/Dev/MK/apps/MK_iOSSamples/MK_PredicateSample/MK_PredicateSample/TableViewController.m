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
    [_objects addObject:@{@"name":@"二郎",@"kana":@"じろう",@"age":@"18",@"grade":@"1"}];
    [_objects addObject:@{@"name":@"三郎",@"kana":@"さぶろう",@"age":@"18",@"grade":@"1"}];
    [_objects addObject:@{@"name":@"花子",@"kana":@"はなこ",@"age":@"20",@"grade":@"3"}];
    [_objects addObject:@{@"name":@"風子",@"kana":@"ふうこ",@"age":@"20",@"grade":@"3"}];
    [_objects addObject:@{@"name":@"光子",@"kana":@"みつこ",@"age":@"20",@"grade":@"3"}];
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
    
    //データの"name"を表示
    cell.textLabel.text = record[@"name"];
    //データの"age"を表示
    cell.detailTextLabel.text = record[@"age"];
    
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
@end
