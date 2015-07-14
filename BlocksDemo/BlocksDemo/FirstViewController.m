//
//  FirstViewController.m
//  BlocksDemo
//
//  Created by xiaojingyuan on 7/14/15.
//  Copyright (c) 2015 xiaojingyuan. All rights reserved.
//

#import "FirstViewController.h"
#import "BlockObject.h"
@interface FirstViewController ()

@end

@implementation FirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"myblock====%d",myBlock(4));
    //直接使用block进行字符串比较，没有声明。
    NSArray *stringsArray = [NSArray arrayWithObjects:@"string1",@"string21",@"string3",@"sstring4",@"string7",@"string6",@"string1",@"string1", nil];
    
    NSLocale *currentLocale = [NSLocale currentLocale];
    
    __block int  orderedSameCount = 0;
    
    NSArray *diacriticInsensitiveSortArray = [stringsArray sortedArrayUsingComparator:^(id string1, id string2) {
        NSRange string1Range = NSMakeRange(0, [string1 length]);
        NSComparisonResult comparisonResult = [string1 compare:string2 options:NSDiacriticInsensitiveSearch range:string1Range locale:currentLocale];
        if (comparisonResult == NSOrderedSame) {
            orderedSameCount++;
        }
        return comparisonResult;
    }];
    NSLog(@"diacriticInsensitiveSortArray: %@", diacriticInsensitiveSortArray);
    NSLog(@"orderedSameCount: %d", orderedSameCount);
    //
    BlockObject *blocko = [[BlockObject alloc]initWithBlock:^(int num) {
        NSLog(@"num==%d",num);
    }];
    [blocko blockWith:^(NSString *str, int num) {
        NSLog(@"str==%@,num==%d",str,num);
    }];
    
}

//首先先声明一个block 返回一个整数，输入一个整数。
int (^myBlock)(int) = ^(int num )
{
    return num *3;
};

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
