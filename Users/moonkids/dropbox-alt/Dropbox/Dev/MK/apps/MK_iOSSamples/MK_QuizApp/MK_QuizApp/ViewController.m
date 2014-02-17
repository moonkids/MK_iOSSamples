//
//  ViewController.m
//  MK_QuizApp
//
//  Created by MurataKazuki on 2013/12/18.
//  Copyright (c) 2013年 MK. All rights reserved.
//

#import "ViewController.h"
#import "QuizViewController.h"
@interface ViewController (){
    NSArray *quizData;
}

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    quizData = @[
                          @{@"question":@"今一番欲しいものは？",
                            @"choices":@[
                                    @{@"id":@"A",@"choice":@"お金",@"category":@"money",@"point":@"3"},
                                    @{@"id":@"B",@"choice":@"愛",@"category":@"love",@"point":@"2"},
                                    @{@"id":@"C",@"choice":@"知識",@"category":@"knowledge",@"point":@"3"}
                                ],
                            },
                          @{@"question":@"今一番欲しいものは？",
                            @"choices":@[
                                    @{@"id":@"A",@"choice":@"お金",@"category":@"money",@"point":@"3"},
                                    @{@"id":@"B",@"choice":@"愛",@"category":@"love",@"point":@"2"},
                                    @{@"id":@"C",@"choice":@"知識",@"category":@"knowledge",@"point":@"3"}
                                    ],
                            },
                          ];
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    //Segueの特定
    if ( [[segue identifier] isEqualToString:@"quiz"] ) {
        QuizViewController *nextViewController = [segue destinationViewController];
        //ここで遷移先ビューのクラスの変数receiveStringに値を渡している
        nextViewController.dataArray = quizData;
    }
}


@end
