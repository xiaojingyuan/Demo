//
//  MC.h
//  MC
//
//  Created by 孙超凡 on 13-2-24.
//  Copyright (c) 2013年 优米网. All rights reserved.
//
#import <sqlite3.h>
#import <Foundation/Foundation.h>

#define AFSQLITESERVES [AFSqliteServes sharedSqliteServes]

@interface AFSqliteServes : NSObject
{
    FMDatabaseQueue       *_AFDatabaseQueue;
}

+(id)sharedSqliteServes;
#pragma mark - 详情缓存
-(void)putTheDetailWithDict:(NSDictionary*)dict URLString:(NSString*)urlString anduid:(NSString*)uid timestamp:(NSString*)timestamp;
-(NSDictionary*)getTheDetailWithURLString:(NSString*)urlString anduid:(NSString*)uid timestamp:(NSString*)timestamp isNet:(BOOL)isNet;
-(void)deleteTheDetailWithURLString:(NSString*)urlString;

#pragma mark - 语录的操作
//获取随机的一条
-(NSDictionary*)getRandomYulu;
//把网上下载的存起来
-(void)putNetYuluToLocal:(NSArray*)array;

@end
