//
//  MC.h
//  MC
//
//  Created by 孙超凡 on 13-2-24.
//  Copyright (c) 2013年 优米网. All rights reserved.
//

#import <Foundation/Foundation.h>

#define AFCACHEDATA [AFCacheData sharedCacheData]

typedef void (^getCacheDataArrayBlock)(NSArray* array);

@interface AFCacheData : NSObject
{
    //首页轮播
    NSMutableDictionary       *_homePageCycleDictionary;
    //首页显示
    NSMutableArray            *_homePageShowArray;
    //首页的会员级别
    NSMutableArray            *_memberShowArray;
    
    //显示会员级别的分类
    NSMutableDictionary       *_typeListDictionary;
    //显示搜索关键词
    NSMutableDictionary       *_searchKeyDictionary;
    //显示导师名字
    NSMutableDictionary       *_tutorDictionary;
    //显示摇奖的配置
    NSMutableDictionary       *_luckyMenuDictionary;
    //首页是否显示限免和优惠什么的
    NSMutableDictionary       *_homeShowDictionary;
    
    //应用推荐
    NSMutableDictionary       *_goodAppDictioary;
    
    //存放全部的数据项
    NSMutableDictionary       *_allDictionary;
    dispatch_queue_t           _arrayQueue;
    dispatch_group_t           _arrayGroup;
}
+ (id)sharedCacheData;
#pragma mark - 首页
- (NSArray*)homePageCycleArrayyWithUpdateBlock:(getCacheDataArrayBlock)block;
- (NSArray*)homePageShowArrayWithUpdateBlock:(getCacheDataArrayBlock)block;
//为会员专区也开设一个
- (NSArray*)homePageMemberArrayWithUpdateBlock:(getCacheDataArrayBlock)block;

#pragma mark - 其他   
//关键词类别
- (NSArray*)classTypeList;
//搜索词
- (NSArray*)searchKeyList;
//导师字典
- (NSDictionary*)tutorNameList;
//摇奖的配置
- (NSDictionary*)luckyMenuList;
//首页是否显示限免和优惠什么的
-(void)getHomeShowWithSuccessBlock:(getBackDictionaryBlock)dictBlock andFailBlock:(getFailBlock)failBlock;
#pragma mark - 详情缓存

-(void)getDetailVideoWithString:(NSString*)detailUrlString WithSuccessBlock:(getBackDictionaryBlock)dictBlock andFailBlock:(getFailBlock)failBlock;
-(void)deleteTheDetailWithURLString:(NSString*)urlString;
#pragma mark - 语录

-(NSDictionary*)getAYulu;

#pragma mark - 应用推荐
-(void)getGoodApplicationCacheWithSuccessBlock:(getCacheDataArrayBlock)block andFailBlock:(getFailBlock)failBlock;

//存储缓存
-(void)storeThePlistDictionary;


@end
/*
 
 //再加点
 isDown:         //是否下载     1=已下载   0=还没有下载
 enableDown:     //是不是能下载  1=下载    0=用户暂停
 downProgress:   //下载进度
 collectDate:    //收藏日期
 watchProgress:  //观看进度
 */







