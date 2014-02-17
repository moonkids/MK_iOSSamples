//
//  StudentInputModal.m
//  MK_CoreDataSchoolMember
//
//  Created by MurataKazuki on 2013/12/17.
//  Copyright (c) 2013年 MK. All rights reserved.
//

#import "StudentInputModal.h"

@interface StudentInputModal (){
    //input情報の格納用インスタンス変数
    NSMutableDictionary *inputData;
}

//xibファイル上のUI部品をバインドするための変数
@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
@property (weak, nonatomic) IBOutlet UISegmentedControl *sexSegmentedControl;
@property (weak, nonatomic) IBOutlet UITextField *birthdayTextField;
@property (weak, nonatomic) IBOutlet UIDatePicker *birthdayDatePicker;
@property (weak, nonatomic) IBOutlet UIView *cancelView;

@end

@implementation StudentInputModal

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        inputData = [NSMutableDictionary dictionary];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    //画面の部品定義はすべてStudentInputModal.xib上で行っているため処理が無い
    //各部品の定義、操作イベント時に呼び出すメソッド、Delegate設定、ジェスチャーに対するコードなどxib上で定義されている
}

//各TextField入力開始時に呼び出されるメソッド
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    switch (textField.tag) {
        case 1:
            //birthdayの入力時、非表示になっているDatePicker、cancelViewを表示
            self.birthdayDatePicker.hidden = NO;
            self.cancelView.hidden = NO;
            //DatePickerで選択するため、TextFieldへの入力はキャンセル
            return NO;
            break;
        default:
            //nameの入力時、非表示になっているcancelViewを表示
            //（キーボード以外をタッチした時に入力終了にするため）
            self.cancelView.hidden = NO;
            return YES;
            break;
    }
}

//キーボードのリターンが押された時に呼ばれる（name入力の時のみ）
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    //キーボード以外のタッチを取得するcancelViewを非表示に
    self.cancelView.hidden = YES;
    //キーボードを隠す
    [self.view endEditing:YES];
    
    return YES;
}

//cancelViewをタッチした時の処理
- (IBAction)cancelViewTouched:(id)sender {
    self.cancelView.hidden = YES;
    if (self.birthdayDatePicker.hidden == NO) {
        //DatePicker表示時にタッチされた場合
        self.birthdayTextField.text = [self.birthdayDatePicker.date description];
        //DatePickerを隠す
        self.birthdayDatePicker.hidden = YES;
    } else {
        //name入力時にタッチされた場合
        //キーボードを隠す
        [self.view endEditing:YES];
    }
}
//Saveボタン押下時の処理
- (IBAction)saveButtonPushed:(id)sender {
    //部品上のデータを、input情報に格納（nilチェックあり）
    if (self.nameTextField.text != nil) inputData[@"name"] = self.nameTextField.text;
    inputData[@"sex"] = [NSNumber numberWithInt:self.sexSegmentedControl.selectedSegmentIndex];
    if (self.birthdayTextField.text != nil) inputData[@"birthday"] = self.birthdayDatePicker.date;
    
    //validateメソッドで、入力チェックと表示
    if ([self validate] == YES) {
        //validateの結果がYESの時のみDelegateメソッドを呼び出しモーダル閉じる
        [self.delegate modalInputFinished:inputData];
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

//入力チェックとエラー表示用のメソッド（入力欄を赤くする）
- (BOOL)validate{
    BOOL isValid = YES;

    //name入力文字列のチェック
    if (inputData[@"name"]== nil || [inputData[@"name"] length] == 0) {
        self.nameTextField.backgroundColor = [UIColor redColor];
        isValid = NO;
    } else {
        self.nameTextField.backgroundColor = [UIColor whiteColor];
    }
    
    //birthday未入力チェック
    if (inputData[@"birthday"] == nil) {
        self.birthdayTextField.backgroundColor = [UIColor redColor];
        isValid = NO;
    } else {
        self.birthdayTextField.backgroundColor = [UIColor whiteColor];
    }
    
    return isValid;
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)nameTextField:(id)sender {
}
@end
