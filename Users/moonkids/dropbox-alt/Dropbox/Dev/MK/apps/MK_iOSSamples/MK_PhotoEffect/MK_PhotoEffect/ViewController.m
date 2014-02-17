//
//  ViewController.m
//  MK_PhotoEffect
//
//  Created by MurataKazuki on 2013/12/01.
//  Copyright (c) 2013年 MK. All rights reserved.
//

#import "ViewController.h"
#import <CoreImage/CoreImage.h>

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end

@implementation ViewController

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
- (IBAction)clearEffect:(id)sender {
    self.imageView.image = [UIImage imageNamed:@"images.jpeg"];
    return;
}
- (IBAction)addEffect:(id)sender {

    //オリジナル画像をCIImageに変換
    CIImage *ciImage = [[CIImage alloc] initWithImage:self.imageView.image];
    

    //フィルターを使って変換した画像を描画する領域
    CIContext *ciContext = [CIContext contextWithOptions:nil];
    CGImageRef cgimg;

    //作成するフィルター
    CIFilter *ciFilter;

    switch ([sender tag]) {
        case 1:
            //Sepiaフィルターを適用した画像を描画
            ciFilter = [CIFilter filterWithName:@"CISepiaTone"
                                                 keysAndValues:kCIInputImageKey, ciImage,
                                       @"inputIntensity", @0.8,nil];
            break;
        case 2:
            ciFilter = [CIFilter filterWithName:@"CIColorMonochrome"
                                                      keysAndValues:kCIInputImageKey, ciImage,
                                            @"inputColor", [CIColor colorWithRed:0.75 green:0.75 blue:0.75],
                                            @"inputIntensity", @1.0,nil];
            break;
        case 3:
            ciFilter = [CIFilter filterWithName:@"CIToneCurve"
                                                     keysAndValues:kCIInputImageKey, ciImage,
                                           @"inputPoint0", [CIVector vectorWithX:0.0 Y:0.0],
                                           @"inputPoint1", [CIVector vectorWithX:0.25 Y:0.1],
                                           @"inputPoint2", [CIVector vectorWithX:0.5 Y:0.5],
                                           @"inputPoint3", [CIVector vectorWithX:0.75 Y:0.9],
                                           @"inputPoint4", [CIVector vectorWithX:1 Y:1],nil];
            break;
    }
    cgimg = [ciContext createCGImage:[ciFilter outputImage] fromRect:[[ciFilter outputImage] extent]];
    //フィルターされた画像を、オリジナル画像に描画
    self.imageView.image = [UIImage imageWithCGImage:cgimg scale:1.0f orientation:UIImageOrientationUp];

    CGImageRelease(cgimg);
}

@end
