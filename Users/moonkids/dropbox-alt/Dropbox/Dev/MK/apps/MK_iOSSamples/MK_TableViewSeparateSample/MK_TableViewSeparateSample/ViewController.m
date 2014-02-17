//
//  ViewController.m
//  MK_TableViewSeparateSample
//
//  Created by MurataKazuki on 2013/11/14.
//  Copyright (c) 2013年 MK. All rights reserved.
//

#import "ViewController.h"
#import "CustomTableView.h"

@interface ViewController (){
    CustomTableView *_tableView;
}

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    //となりのCustomTableViewクラスを作成
    _tableView = [[CustomTableView alloc] initWithFrame:CGRectMake(0, 100, 200, 400) style:UITableViewStylePlain];

    //delegateはこのクラス（＝ボタンを押した時の動作はこのクラスで処理）
    _tableView.delegate = self;

    //dataSourceはこのtableView自信（＝データの保持や表示はTableView側で行う）
    _tableView.dataSource = _tableView;

    //表示
    [self.view addSubview:_tableView];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    button.frame = CGRectMake(0,50,100,20);
    [button setTitle:@"シャッフル" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(pushed) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
    //TableViewで表示するデータ
    _tableView.data = @[@"あああ",@"いいい",@"ううう",@"えええ",@"おおお"];
    
}

//セルが選ばれた時のdelegateメソッド
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //どのセルが選ばれたかを確認
    NSLog(@"%@",_tableView.data[indexPath.row]);
}


-(void)pushed{
    //TableView内のデータ並べ替えメソッドを呼び出し（実際の処理はTableView側に実装）
    [_tableView shuffle];
}

@end
