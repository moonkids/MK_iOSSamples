//
//  ViewController.m
//  MK_GooglePlacesAPI
//
//  Created by MurataKazuki on 2013/12/01.
//  Copyright (c) 2013年 MK. All rights reserved.
//

#import "ViewController.h"
#import <GoogleMaps/GoogleMaps.h>

@interface ViewController (){
    GMSMapView *_mapView;
    GMSCircle *circ;
    GMSPolyline *_line;
}

@end

@implementation ViewController

-(void)viewDidAppear:(BOOL)animated{
    NSTimer *timer =[NSTimer scheduledTimerWithTimeInterval:4.0 target:self selector:@selector(foo) userInfo:nil repeats:NO];
//    [timer fire];
}
-(void)foo{
//    circ.radius = 400;
    [circ setPosition:CLLocationCoordinate2DMake(35.681183, 139.755686)];

    GMSMutablePath *path = [GMSMutablePath path];
    [path addCoordinate:CLLocationCoordinate2DMake(35.681183, 139.765686)];
    [path addCoordinate:CLLocationCoordinate2DMake(35.671183, 139.755686)];

    [_line setPath:path];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //マップの初期表示
    GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:35.681183
                                                            longitude:139.765686
                                                                 zoom:14];
    _mapView = [GMSMapView mapWithFrame:CGRectZero camera:camera];
    _mapView.myLocationEnabled = YES;

    //マップをViewControllerの全画面と入れ替え
    self.view = _mapView;
    
    CLLocationCoordinate2D circleCenter = CLLocationCoordinate2DMake(35.681183, 139.765686);
    circ = [GMSCircle circleWithPosition:circleCenter
                                             radius:1000];
    circ.map = _mapView;
    
GMSMutablePath *path = [GMSMutablePath path];
[path addCoordinate:CLLocationCoordinate2DMake(35.681183, 139.765686)];
[path addCoordinate:CLLocationCoordinate2DMake(35.691183, 139.755686)];
_line = [GMSPolyline polylineWithPath:path];
_line.map = _mapView;
    
[_line setPath:path];
    
//    //マーカの作成
//    GMSMarker *marker = [[GMSMarker alloc] init];
//    marker.position = CLLocationCoordinate2DMake(35.681183, 139.765686);
//    marker.title = @"東京駅";
//    marker.snippet = @"Tokyo Station";
//    marker.map = _mapView;
//    
//    
//    //NSDataでPlacesAPI上のJSONを取得
//    //Places API ( https://developers.google.com/places/documentation/search?hl=ja )
//    NSString *urlString = @"https://maps.googleapis.com/maps/api/place/search/json?location=35.681183,139.765686&radius=500&types=food&name=%E3%83%A9%E3%83%BC%E3%83%A1%E3%83%B3&sensor=false&key=AIzaSyCHMvb3zmXEfIjtRVBq1FqaWDiSX6Th_T8";
////    NSString *urlEncodedString = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
//    NSURL *url = [NSURL URLWithString:urlString];
//    
//    NSData *result = [NSData dataWithContentsOfURL:url options:NSDataReadingUncached error:nil];
//
//    //JSONのエントリーキー「results」内がデータの一覧
//    NSArray *_objects = [NSJSONSerialization JSONObjectWithData:result options:NSJSONReadingMutableLeaves error:nil][@"results"];
//    
//    //結果を一件ずつ繰り返し
//    for (NSDictionary *record in _objects) {
//        //マーカオブジェクトを作成
//        GMSMarker *marker = [[GMSMarker alloc] init];
//        marker.position = CLLocationCoordinate2DMake([record[@"geometry"][@"location"][@"lat"] floatValue], [record[@"geometry"][@"location"][@"lng"] floatValue]);
//        marker.title = record[@"name"];
//        marker.snippet = record[@"vicinity"];
//        marker.map = _mapView;
//    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
