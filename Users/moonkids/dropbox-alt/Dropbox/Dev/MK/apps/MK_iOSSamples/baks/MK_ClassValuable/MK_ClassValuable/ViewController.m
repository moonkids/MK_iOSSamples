//
//  ViewController.m
//  MK_ClassValuable
//
//  Created by MurataKazuki on 2014/01/30.
//  Copyright (c) 2014年 MK. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (weak, nonatomic) IBOutlet UITextView *textView;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.

  _name = @"aa";
  
  NSString *ret = ViewController.name;
  NSLog(@"%@",ret);
  
  _textField.text = @"http://www.yahoo.co.jp/";
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


static NSString *_name;

+(NSString *)name{
  return _name;
}


- (NSString*)getHTMLContentAsynchronouslyWithURL:(NSString*)url
{
  
  NSURL *targetURL = [NSURL URLWithString:url];
  NSURLRequest *request = [NSURLRequest requestWithURL:targetURL];
  
  [NSURLConnection sendAsynchronousRequest:request
                                     queue:[NSOperationQueue mainQueue]
                         completionHandler:^(NSURLResponse *res, NSData *data, NSError *err)
   {
     NSString *result;
     result = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
     
     NSLog(@"%@",result);
     
     //読み込みが終了したメソッドを実行する（Delegateメソッドの呼び出しのような考え方）
     [self loadFinished:result];
     
   }];
  return nil;
}


-(BOOL)textFieldShouldReturn:(UITextField *)textField{
  NSString *urlString = _textField.text;
  
  
  //非同期取得の呼び出し
  [self getHTMLContentAsynchronouslyWithURL:urlString];
  
  //非同期なので、ここでは結果を待てない
  
  _textView.text = @"呼び出し終了";
  return YES;
}

//アクセス結果を取得した時に実行したい処理
- (void)loadFinished:(NSString *)resultHTMLString{
  _textView.text = resultHTMLString;
  NSLog(@"%@",resultHTMLString);
}


@end
