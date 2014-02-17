//
//  ViewController.m
//  MK_CSVReader
//
//  Created by MurataKazuki on 2013/11/27.
//  Copyright (c) 2013年 MK. All rights reserved.
//

#import "ViewController.h"
#import "AppDelegate.h"

@interface ViewController (){
    NSArray *_dataArray;
    
    //AppDelegateを追加
    AppDelegate *_ad;

    //お気に入りデータを追加
    NSMutableArray *_favoitesArray;
}

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //AppDelegateの情報を引き継ぎ
    _ad = [[UIApplication sharedApplication] delegate];
    _dataArray = [_ad dataArray];
    _favoitesArray = [_ad favoritesArray];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [_dataArray count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];

    cell.detailTextLabel.text =
        [NSString stringWithFormat:@"%@ %@",_dataArray[indexPath.row][@"city"],_dataArray[indexPath.row][@"town"]];
    cell.textLabel.text = _dataArray[indexPath.row][@"zip"];

    //***************************************
    //データのチェックを元に、チェックマークを切り替え
    //***************************************
    if ([_dataArray[indexPath.row][@"isFavorite"] boolValue] == YES){
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    } else {
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    //***************************************
    //セルタッチ時にデータのチェックを入れ替え、お気に入り一覧を編集する
    //***************************************
    if ([_dataArray[indexPath.row][@"isFavorite"] boolValue] == YES){
        _dataArray[indexPath.row][@"isFavorite"] = @NO;
        [_favoitesArray removeObject:_dataArray[indexPath.row][@"zip"]];
    } else {
        _dataArray[indexPath.row][@"isFavorite"] = @YES;
        [_favoitesArray addObject:_dataArray[indexPath.row][@"zip"]];
    }
    NSLog(@"%d,%@",_favoitesArray.count,_favoitesArray);
    
    //ファイルへの保存
    [_ad saveFavorites];
    
    [tableView reloadData];
}

@end
