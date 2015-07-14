//
//  BlockObject.m
//  BlocksDemo
//
//  Created by xiaojingyuan on 7/14/15.
//  Copyright (c) 2015 xiaojingyuan. All rights reserved.
//

#import "BlockObject.h"

@implementation BlockObject
- (id)initWithBlock:(void (^)(int))myBlock
{
    self = [super init];
    if (self) {
        _returnbackBlock = myBlock;
        myBlock(10);
    }
    return self;
}
- (void)blockWith:(void (^)(NSString *, int))twoParamBlock
{
    twoParamBlock(@"00000",2);
    _returnbackBlock(20);
    _getBlock = twoParamBlock;
}
@end
