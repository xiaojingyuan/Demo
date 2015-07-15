//
//  FirstViewController.m
//  LayerDemo
//
//  Created by xiaojingyuan on 7/13/15.
//  Copyright (c) 2015 xiaojingyuan. All rights reserved.
//

#import "FirstViewController.h"

@interface FirstViewController ()
{
    UIView     *_circleView;
}
@end

@implementation FirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIImageView * firstImageView = [[UIImageView alloc]initWithFrame:CGRectMake(20, 0, 300, 300)];
    firstImageView.image = [self drawImagewithSize:firstImageView.frame.size];
    [self.view addSubview:firstImageView];
    
    _circleView = [[UIView alloc]initWithFrame:CGRectMake(200, 200, 100, 100)];
    _circleView.backgroundColor = [UIColor redColor];
    //圆角
    _circleView.layer.cornerRadius = 50;
    //是否剪切图层边境，当然剪了就没有阴影了。
//    _circleView.layer.masksToBounds = YES;
    //来个蓝边
    _circleView.layer.borderColor = [UIColor blueColor].CGColor;
    _circleView.layer.borderWidth = 2;
    //阴影
    _circleView.layer.shadowColor = [UIColor blackColor].CGColor;
   _circleView.layer.shadowOffset = CGSizeMake(10, 10);
    _circleView.layer.shadowOpacity = 0.9;

    
//    CALayer *circleLayer = [[CALayer alloc]init];
//    circleLayer.frame = CGRectMake(0, 0, 100, 100);
//    circleLayer.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0.5 alpha:0.5].CGColor;
//    
//    circleLayer.shadowColor = [UIColor blackColor].CGColor;
//    circleLayer.shadowOffset = CGSizeMake(10, 10);
//    circleLayer.shadowOpacity = 0.9;
//    [_circleView.layer addSublayer:circleLayer];
    
    [self.view addSubview:_circleView];
}
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = touches.anyObject;
    CGPoint location = [touch locationInView:self.view];
    
    [UIView animateWithDuration:5.0 delay:2.0 usingSpringWithDamping:0.1 initialSpringVelocity:1.0 options:UIViewAnimationOptionCurveLinear animations:^{
        _circleView.center = location;
    } completion:^(BOOL finished) {
        
    }];
}
- (UIImage *)drawImagewithSize:(CGSize )size
{
    //建立一个基于uiimage的图形上下文
    UIGraphicsBeginImageContext(size);
    //去当前上下文，刚刚建立的。
    CGContextRef ref = UIGraphicsGetCurrentContext();
    CGContextSetRGBFillColor(ref, 0, 1, 0, 0.5);
//    CGContextSetRGBStrokeColor(ref, 1, 1, 0, 1);
//    CGContextSetLineWidth(ref, 5);
//    CGContextFillRect(ref, CGRectMake(10, 10, 200, 200));
//    CGContextAddRect(ref, CGRectMake(10, 10, 200, 200));
//    CGContextBeginPath(ref);
//    画圆，图文，圆心， 半径，其实角度，结束角度，顺时针还是逆时针。
    CGContextAddArc(ref, 100, 100,100,0,M_PI, NO);
//    //实心矩形
//    CGContextFillRect(ref, CGRectMake(10, 10, 100, 100));
//    //矩形
//    CGContextAddRect(ref, CGRectMake(10, 20, 50, 50));
//    //填充颜色
    CGContextFillPath(ref);
    CGContextAddArc(ref, 100, 100,100,M_PI, 2*M_PI, NO);
    CGContextSetRGBFillColor(ref, 0, 0, 1, 1);
//    //设置画笔色
//    CGContextSetRGBStrokeColor(ref, 0, 1, 0, 1);
//    //填充一个区域
    CGContextFillPath(ref);
    
//    CGContextStrokePath(ref);
//获取image
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    //结束图文
    UIGraphicsEndImageContext();
    return image;
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
