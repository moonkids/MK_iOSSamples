//
//  ModelViewController.m
//  MK_QuizSample
//
//  Created by MurataKazuki on 2013/09/29.
//  Copyright (c) 2013年 MK. All rights reserved.
//

#import "ModelViewController.h"
#import "DataViewController.h"

@interface ModelViewController (){
    //ページに表示するデータを格納
    NSArray *pageData;
    int currentPage;
}
@end

//Quiz用のページめくり用ビューコントローラ
@implementation ModelViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    NSLog(@"viewDidLoad");
    
    //各ページに表示するデータ
    pageData = @[@"1問目",@"2問目",@"3問目",@"4問目",@"5問目"];
    
    //最初に表示する1ページ目を設定
    DataViewController *startingViewController = [self viewControllerAtIndex:0 storyboard:self.storyboard];
    NSArray *viewControllers = @[startingViewController];
    
    [self setViewControllers:viewControllers direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:NULL];
    
    //データ表示を担当するクラスを指定（自分のクラス内で処理）
    self.dataSource = self;
    self.delegate = self;
    
    currentPage = 0;
}

//ページのインスタンスを生成するメソッド。ページ移動した時などに自動的に呼び出される
- (DataViewController *)viewControllerAtIndex:(NSUInteger)index storyboard:(UIStoryboard *)storyboard
{
    //indexの値がページ情報の件数と整合性が取れてる時だけ
    if (([pageData count] == 0) || (index >= [pageData count])) {
        return nil;
    }
    
    //ページのインスタンスを生成。ここでinitで保持しておいたページ情報を受け渡す
    //これでDataViewControllerの内容がUIPageViewController上に表示される
    DataViewController *dataViewController = [storyboard instantiateViewControllerWithIdentifier:@"DataViewController"];
    dataViewController.dataObject = pageData[index];
    
    NSLog(@"%@",!(currentPage == [pageData count] - 1 )?@"YES":@"NO");
    dataViewController.dispResultButton = !(currentPage == [pageData count] - 1 );
    return dataViewController;
}
//表示しているページのページ番号を調べる
- (NSUInteger)indexOfViewController:(DataViewController *)viewController
{
    return [pageData indexOfObject:viewController.dataObject];
}

//ページを先に進めた時の処理（nilをリターンした場合には、ページは移動しない）
- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController
{
    NSUInteger index = [self indexOfViewController:(DataViewController *)viewController];
    if (index == NSNotFound) {
        return nil;
    }
    
    index++;
    if (index == [pageData count]) {
        return nil;
    }
    currentPage++;
    return [self viewControllerAtIndex:index storyboard:viewController.storyboard];
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController
{
    NSUInteger index = [self indexOfViewController:(DataViewController *)viewController];
    if ((index == 0) || (index == NSNotFound)) {
        return nil;
    }
    
    index--;
    currentPage--;
    return [self viewControllerAtIndex:index storyboard:viewController.storyboard];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
