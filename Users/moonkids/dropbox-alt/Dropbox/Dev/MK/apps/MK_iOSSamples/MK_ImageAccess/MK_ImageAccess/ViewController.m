//
//  ViewController.m
//  MK_ImageAccess
//
//  Created by MurataKazuki on 2014/02/04.
//  Copyright (c) 2014年 MK. All rights reserved.
//

#import "ViewController.h"
#import <AssetsLibrary/AssetsLibrary.h>

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end

@implementation ViewController {
    //メンバー変数
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

-(void)viewDidAppear:(BOOL)animated{
    UIActionSheet *as = [[UIActionSheet alloc] init];
    
    as.title = @"選択してください。";
    [as addButtonWithTitle:@"フォトライブラリ"];
    [as addButtonWithTitle:@"カメラ"];
    [as addButtonWithTitle:@"キャンセル"];
    as.cancelButtonIndex = 2;
    as.destructiveButtonIndex = 0;
    
    as.delegate = self;
    [as showInView:self.view];

}

-(void)_showErrorMessageWithErrors:(NSDictionary *)message alertTitle:(NSString *)alertTitle buttonTitle:(NSString *)buttoTitle{
    NSLog(@"%@",message[@"message"]);
}


/*-----------------------------------------------------
 @アクションシートの項目が選択されると呼ばれる
 @param UIActionSheet actionSheet アクションシートのインスタンス
 @param NSInteger buttonIndex 選択されたメニューのインデックス値
 @return void
 ------------------------------------------------------*/

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
    switch (buttonIndex) {
            
            //写真ライブラリ
        case 0:
            
            if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
                
                
                [self _showErrorMessageWithErrors:@{@"message":@"ご利用の機種では利用出来ません"} alertTitle:@"" buttonTitle:@"OK"];
                
                return;
                
            }
            
            //imagePickerをアクセス権が許可されていれば立ち上げる
            [self launchImagePickerIfAuthorizeWithSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
            
            break;
            
            //カメラ撮影
        case 1:
            
            if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
                
                [self _showErrorMessageWithErrors:@{@"message":@"ご利用の機種では利用出来ません"} alertTitle:@"" buttonTitle:@"OK"];
                return;
                
            }
            
            //imagePickerをアクセス権が許可されていれば立ち上げる
            [self launchImagePickerIfAuthorizeWithSourceType:UIImagePickerControllerSourceTypeCamera];
            
            break;
            
            
        default:
            break;
            
    }
    
    
}



/*-----------------------------------------------------
 @ イメージピッカーをアクセス権があれば開く
 @ param UIImagePickerControllerSourceType sourceType UIIMagePickerのソースタイプ
 @ return void
 ------------------------------------------------------*/


- (void)launchImagePickerIfAuthorizeWithSourceType:(UIImagePickerControllerSourceType)sourceType
{
    
    ALAuthorizationStatus status = [ALAssetsLibrary authorizationStatus];
    
    switch (status) {
            
            //まだ許可されているかされていないか決まっていない場合
        case ALAuthorizationStatusNotDetermined:
            
            //とりあえずメソッドを実行してみる。
            [self _launchImagePickerWithSourceType:sourceType];
            
            break;
            
            //アクセスが制限されている場合
        case ALAuthorizationStatusRestricted:
            [self _showErrorMessageWithErrors:@{@"message":@"機能制限(ペアレンタルコントロール)で写真ライブラリへのアクセスが許可されておりません。"} alertTitle:@"" buttonTitle:@"OK"];
            break;
            
            //アクセスが拒否されている場合
        case ALAuthorizationStatusDenied:
            [self _showErrorMessageWithErrors:@{@"message":@"写真ライブラリへのアクセスが許可されておりません。\n"
                                                "iphoneの設定アプリを開き「プライバシー」 > 「写真」と順に選択し、このアプリのへ許可を「オン」にして下さい。"} alertTitle:@"" buttonTitle:@"OK"];
            [self _launchImagePickerWithSourceType:sourceType];

            break;
            
            
            //アクセスが承認されている場合
        case ALAuthorizationStatusAuthorized:
            
            //メソッドを実行する
            [self _launchImagePickerWithSourceType:sourceType];
            
            break;
            
        default:
            break;
    }
    
}


/*-----------------------------------------------------
 @ イメージピッカーを開く
 @ param UIImagePickerControllerSourceType sourceType UIIMagePickerのソースタイプ
 @ return void
 ------------------------------------------------------*/

- (void)_launchImagePickerWithSourceType:(UIImagePickerControllerSourceType)sourceType
{
    
    
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    
    picker.delegate = self;
    
    picker.sourceType = sourceType;
    picker.allowsEditing = YES;
    picker.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    
    [self presentViewController:picker animated:YES completion:nil];
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
