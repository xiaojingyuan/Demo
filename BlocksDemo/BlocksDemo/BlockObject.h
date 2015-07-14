//
//  BlockObject.h
//  BlocksDemo
//
//  Created by xiaojingyuan on 7/14/15.
//  Copyright (c) 2015 xiaojingyuan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BlockObject : NSObject
- (id)initWithBlock:(void (^)(int num))myBlock;
//
- (void)blockWith:(void (^)(NSString *str,int num))twoParamBlock;
@property (nonatomic,strong)void (^returnbackBlock)(int);
//定义一个全局的block
@property (nonatomic,strong)void (^getBlock)(NSString *,int);
//定义一个block
typedef int (^getBlockSub)(NSString *,int);
@end
