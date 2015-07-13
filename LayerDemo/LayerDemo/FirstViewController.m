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
    _circleView = [[UIView alloc]initWithFrame:CGRectMake(200, 200, 100, 100)];
    _circleView.backgroundColor = [UIColor redColor];
    _circleView.layer.cornerRadius = 50;
    _circleView.layer.masksToBounds = YES;
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
