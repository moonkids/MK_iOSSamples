//
//  DataViewController.m
//  MK_QuizSample
//
//  Created by MurataKazuki on 2013/09/29.
//  Copyright (c) 2013年 MK. All rights reserved.
//

#import "DataViewController.h"

@interface DataViewController ()
@property (weak, nonatomic) IBOutlet UILabel *pageLabel;
@property (weak, nonatomic) IBOutlet UIButton *resultButton;
- (IBAction)goTop:(id)sender;

@end

@implementation DataViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

//画面に表示される際に、ModelViewControllerから受け渡されたデータを画面に反映
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.pageLabel.text = _dataObject;

    //判定画面へのボタンは、最後の問題のときだけ表示
    self.resultButton.hidden = self.dispResultButton;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//トップページ戻る処理
- (IBAction)goTop:(id)sender {
    [self.navigationController popToRootViewControllerAnimated:YES];
}
@end
