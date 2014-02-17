//
//  ViewController.m
//  MK_ImageResize
//
//  Created by MurataKazuki on 2014/02/06.
//  Copyright (c) 2014年 MK. All rights reserved.
//

#import "ViewController.h"

@interface ViewController (){
    __weak IBOutlet UIImageView *originalImageView;
    __weak IBOutlet UIImageView *newImageView;
}

@end

@implementation ViewController
- (IBAction)pushed:(id)sender {
//    CGImageRef imageRef = [originalImageView.image CGImage];
//    size_t w = CGImageGetWidth(imageRef);
//    size_t h = CGImageGetHeight(imageRef);
//    size_t resize_w, resize_h;
//    
//    if (w>h) {
//        resize_w = 120;
//        resize_h = h * resize_w / w;
//    } else {
//        resize_h = 80;
//        resize_w = w * resize_h / h;
//    }
//    
//    UIGraphicsBeginImageContext(CGSizeMake(resize_w, resize_h));
//    [originalImageView.image drawInRect:CGRectMake(0, 0, resize_w, resize_h)];
//    newImageView.image = UIGraphicsGetImageFromCurrentImageContext();
//    UIGraphicsEndImageContext();
//    CGImageRelease(imageRef);
    [self pushed];
}

- (IBAction)pushed2:(id)sender{
    // CIImageを作成する
    CIImage *sourceImage = [[CIImage alloc] initWithCGImage:originalImageView.image.CGImage];
    
    // 新しい画像サイズ
    CGSize newSize = CGSizeMake(120, 80);
    
    // ソーズ画像のサイズと、新しいサイズの比率計算
    CGRect imageRect = [sourceImage extent];
    CGPoint scale = CGPointMake(newSize.width/imageRect.size.width,
                                newSize.height/imageRect.size.height);
    
    // AffineTransformでサイズを変更し、切り抜く
    CIImage *filteredImage = [sourceImage imageByApplyingTransform:CGAffineTransformMakeScale(scale.x,scale.y)];
    filteredImage = [filteredImage imageByCroppingToRect:CGRectMake(0, 0, newSize.width,newSize.height)];
    
    // CIImageに変換する
    CIContext *ciContext = [CIContext contextWithOptions:[NSDictionary dictionaryWithObject:[NSNumber numberWithBool:NO]
                                                                                     forKey:kCIContextUseSoftwareRenderer]];

    //　さらに色補正などのフィルターをかけられる
    CIFilter *ciFilter = [CIFilter filterWithName:@"CISepiaTone" //フィルター名
                                    keysAndValues:kCIInputImageKey, filteredImage,
                          @"inputIntensity", [NSNumber numberWithFloat:0.8], //パラメータ
                          nil
                          ];

    // CGImageに変換する
    CGImageRef imageRef = [ciContext createCGImage:[ciFilter outputImage] fromRect:[[ciFilter outputImage] extent]];
    
    // UIImageに変換する
    newImageView.image  = [UIImage imageWithCGImage:imageRef scale:1.0f orientation:UIImageOrientationUp];
    CGImageRelease(imageRef);
}
-(void)pushed{
    //オリジナルの画像からNSDataを取り出す
    //（はやともさんの使いたい条件がNSDataからの描画でしたので合わせているだけです）
    NSData  *imgData = [[NSData alloc] initWithData:UIImagePNGRepresentation( originalImageView.image )];
    

    //nilじゃなければリサイズしてクロップする
    if (imgData != nil) {
        
        // ???: CGImageRef からの描画だと、上下が反転してしまうようなので、一旦NSDataをUIImageに変換してからの方が良いようです
        UIImage *originalImage = [UIImage imageWithData:imgData];
        
//        CFDataRef imgDataRef = (CFDataRef)CFBridgingRetain(imgData);
//        CGDataProviderRef imgDataProvider = CGDataProviderCreateWithCFData (imgDataRef);
//        
//        //CGImageに変換
//        CGImageRef imageRef = CGImageCreateWithPNGDataProvider(imgDataProvider, NULL, true, kCGRenderingIntentDefault);
        
        //CGImageのサイズを取得
        size_t originalWidth = CGImageGetWidth(originalImage.CGImage);
        size_t originalHeight = CGImageGetHeight(originalImage.CGImage);
        
        size_t resizedWidth, resizedHeight;
        
        //元の横幅が元の縦幅より小さい場合
        // ???: 縦横75,75で切り抜くのであれば、最小値が75になるべきなので、originalWidth > originalHeightではなく逆になります
        if (originalWidth < originalHeight) {
            resizedWidth = 75;
            resizedHeight = originalHeight * resizedWidth / originalWidth;
            
            //元の縦幅が元の横幅より大きい場合
        } else {
            resizedHeight = 75;
            resizedWidth = originalWidth * resizedHeight / originalHeight;
        }
        
        
        //ここで画像中央を起点に75*75にクロップ
        UIGraphicsBeginImageContext(CGSizeMake(resizedWidth, resizedHeight));
        
        //コンテキストへの描画を開始（UIImageからならば前回と同様でコンテキスト内に描画できます）
        [originalImage drawInRect:CGRectMake(0, 0, resizedWidth, resizedHeight)];
        
        //リサイズされたコンテキスト内の画像を一旦CGImageRefとして参照してから、
        CGImageRef resizedRef = CGBitmapContextCreateImage(UIGraphicsGetCurrentContext());
        UIGraphicsEndImageContext();

        //リサイズされた画像から、任意の位置からのRectを切り抜いて別のCGImageRefを取り出します
        //これは横長の場合の切り抜きなので、縦長の場合には、CGRectMakeの2番めの引数に(resizedHeight - 75)/2を指定することになります
        CGImageRef croppedRef = CGImageCreateWithImageInRect(resizedRef, CGRectMake((resizedWidth - 75)/2, 0, 75, 75));
        
        newImageView.image = [UIImage imageWithCGImage:croppedRef];
    }
    
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
