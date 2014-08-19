//
//  MC.h
//  MC
//
//  Created by 孙超凡 on 13-2-24.
//  Copyright (c) 2013年 优米网. All rights reserved.
//

#import <Foundation/Foundation.h>

#define AFGLOBALDATA [AFGlobalData sharedGlobalData]

@interface AFGlobalData : NSObject
{
    //默认不允许在3G下下载，只在Wifi下面下载
    BOOL                      _enableDownAt3G;
    
    //存放全部的数据项
    NSMutableDictionary       *_allDictionary;
}
@property (nonatomic, readwrite, assign) BOOL isDebug;
@property (nonatomic, readwrite, assign) BOOL enableDownAt3G;
@property (nonatomic, readwrite, retain) NSMutableArray *searchRecordArray;
@property (nonatomic, readwrite, retain) NSMutableArray *playRecordArray;
@property (nonatomic, readwrite, retain) UITextView *logoTextView;
+ (id)sharedGlobalData;

//搜索记录
-(void)addSearchRecord:(NSString*)record;
-(void)clearSearchRecord;
//播放记录
-(void)addPlayRecord:(NSDictionary*)dict withendTime:(float)endTime;
-(float)getTimeFromRecord:(NSString*)url;
//存储用户的配置
-(void)storeThePlistDictionary;

-(void)addText:(NSString*)t;
@end
