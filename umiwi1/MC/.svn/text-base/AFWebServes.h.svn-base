//
//  AFWebServes.h
//  MC
//
//  Created by 孙超凡 on 13-2-24.
//  Copyright (c) 2013年 优米网. All rights reserved.
//

#import <Foundation/Foundation.h>


#define AFWEBSERVES [AFWebServes sharedWebServes]

typedef enum {
    //首页的视频请求
    AFWebServesLunBo,
    AFWebServesRecommend,
    AFWebServesCybw,
    AFWebServesHotsell,
    AFWebServesHotFree,
    AFWebServesMember,
    
    //分类
    AFWebServesAllCourse,
    AFWebServesExp,
    AFWebServesGold,
    AFWebServesSilver,
    AFWebServesDiamond,
    AFWebServesHotFreeList,
    AFWebServesTypeList,
    
    //搜索
    AFWebServesSearchKey,
    AFWebServesSearchResult,
    AFWebServesSuggest,
    
    //登录注册相关
    AFWebServesLogin,
    AFWebServesBindCheck,
    AFWebServesRegister,
    AFWebServesGetUserinfo,
    AFWebServesCanLogin,
    AFWebServesCanLogout,
    
    //首页启动
    AFWebServesStartUp,
    
    //名人名言
    AFWebServesYulu,
    
    //获取详情
    AFWebServesDetail,
    AFWebServesRelative,
    AFWebServesMusic,
    
    //更多 订单，课程，收藏，播放记录
    AFWebServesOrder,
    AFWebServesCourse,
    AFWebServesStore,
    AFWebServesRecord,
    AFWebServesStoreCommit,
    AFWebServesStoreDelete,
    AFWebServesRecordDelete,
    AFWebServesHuoDong,
    
    AFWebServesGoodApp,
    
    //我的订单（新型）  &&  优惠劵
    AFWebServesNewOrder,
    AFWebServesCoupon,
    
    //iPad >> 首页新加的视频请求
    AFWebServesLoginCourse,
    AFWebServesNewWorker,
    AFWebServesManagement,
    AFWebServesMarketSales,
    AFWebServesBusiness,
    AFWebServesSkill,
    AFWebServesCollege,
    
    //iPad >> 排行榜
    AFWebServesRank,
    //iPad >> 线下活动列表
    AFWebServesActivity,
    //iPad >> 获取导师名字
    AFWebServesTutor,
    
    //每次提交信息
    AFWebServesCommitInfo,
    
    //获取最近的更新
    AFWebServesLatest,
    
    //专题列表
    AFWebServesZhuanTi,
    
    //今日限免
    AFWebServesTimeLimitFree,
    
    //中奖配置
    AFWebServesLuckyMenu,
    AFWebServesLotteryList,
    AFWebServesLotteryResult,
    AFWebServesHomeShow,
}AFWebServesType;
//定义回调的Block
typedef enum {
    AFOrderTypeHot,
    AFOrderTypeNew,
}AFOrderType;
typedef enum {
    AFRankTypeDay,
    AFRankTypePay,
    AFRankTypeFree,
    AFRankTypeGood,
}AFRankType;
typedef enum {
    AFVIPTypeNone,
    AFVIPTypeFree,
    AFVIPTypeExp,
    AFVIPTypeSilver,
    AFVIPTypeGold,
    AFVIPTypeDiamond,
}AFVIPType;
@interface AFWebServes : NSObject
{
}
+ (id)sharedWebServes;
#pragma mark - 首页的视频请求
//获取轮播
-(void)getLunBoWithSuccessBlock:(getBackDictionaryBlock)dictBlock andFailBlock:(getFailBlock)failBlock;
//获取首页推荐
-(void)getRecommendWithSuccessBlock:(getBackDictionaryBlock)dictBlock andFailBlock:(getFailBlock)failBlock;
/**
 创业百问的获取接口
 @param  page     :  当前页
         perPage  :  每页多少条
 @returns 一个字典
 @exception
 */
-(void)getCybwlistAtPage:(int)page perPage:(int)perPage WithSuccessBlock:(getBackDictionaryBlock)dictBlock andFailBlock:(getFailBlock)failBlock;
//本周热播
-(void)getHotsellWithSuccessBlock:(getBackDictionaryBlock)dictBlock andFailBlock:(getFailBlock)failBlock;

-(void)getHotFreeWithSuccessBlock:(getBackDictionaryBlock)dictBlock andFailBlock:(getFailBlock)failBlock;
-(void)getMemberIndexWithSuccessBlock:(getBackDictionaryBlock)dictBlock andFailBlock:(getFailBlock)failBlock;
#pragma mark - 分类
-(void)getAllCourseListAtPage:(int)page perPage:(int)perPage orderBy:(AFOrderType)orderType andVIPType:(AFVIPType)VIPType andClassName:(NSString*)classname andTutor:(NSString*)tutor WithSuccessBlock:(getBackDictionaryBlock)dictBlock andFailBlock:(getFailBlock)failBlock;
-(void)getExpAtPage:(int)page perPage:(int)perPage orderBy:(AFOrderType)type category:(NSString*)categoryString WithSuccessBlock:(getBackDictionaryBlock)dictBlock andFailBlock:(getFailBlock)failBlock;
-(void)getSilverAtPage:(int)page perPage:(int)perPage orderBy:(AFOrderType)type category:(NSString*)categoryString WithSuccessBlock:(getBackDictionaryBlock)dictBlock andFailBlock:(getFailBlock)failBlock;
-(void)getGoldAtPage:(int)page perPage:(int)perPage orderBy:(AFOrderType)type category:(NSString*)categoryString WithSuccessBlock:(getBackDictionaryBlock)dictBlock andFailBlock:(getFailBlock)failBlock;
-(void)getDiamondAtPage:(int)page perPage:(int)perPage orderBy:(AFOrderType)type category:(NSString*)categoryString WithSuccessBlock:(getBackDictionaryBlock)dictBlock andFailBlock:(getFailBlock)failBlock;
//优米品牌视频  免费的
-(void)getHotFreeListAtPage:(int)page perPage:(int)perPage orderBy:(AFOrderType)type category:(NSString*)categoryString WithSuccessBlock:(getBackDictionaryBlock)dictBlock andFailBlock:(getFailBlock)failBlock;
-(void)getTypeListWithSuccessBlock:(getBackDictionaryBlock)dictBlock andFailBlock:(getFailBlock)failBlock;
#pragma mark - 搜索
-(void)getSearchKeyWithSuccessBlock:(getBackDictionaryBlock)dictBlock andFailBlock:(getFailBlock)failBlock;
-(void)getSearchResultWithKey:(NSString*)key WithSuccessBlock:(getBackDictionaryBlock)dictBlock andFailBlock:(getFailBlock)failBlock;
-(void)getSuggestWithKey:(NSString*)key WithSuccessBlock:(getBackDictionaryBlock)dictBlock andFailBlock:(getFailBlock)failBlock;
#pragma mark - 登录注册相关
-(void)doLoginWithUsername:(NSString*)nameString password:(NSString*)password WithSuccessBlock:(getBackDictionaryBlock)dictBlock andFailBlock:(getFailBlock)failBlock;
-(void)getgetOnLineUserBindWithSuccessBlock:(getBackArrayBlock)arrayBlock andFailBlock:(getFailBlock)failBlock;
-(void)registerUserAccountWithUsername:(NSString*)nameString password:(NSString*)password email:(NSString*)emailString WithSuccessBlock:(getBackDictionaryBlock)dictBlock andFailBlock:(getFailBlock)failBlock;
-(void)getUserOnLineInformationWithSuccessBlock:(getBackDictionaryBlock)dictBlock andFailBlock:(getFailBlock)failBlock;
-(void)getCanLoginWithSuccessBlock:(getBackDictionaryBlock)dictBlock andFailBlock:(getFailBlock)failBlock;
-(void)getLogoutWithSuccessBlock:(getBackDictionaryBlock)dictBlock andFailBlock:(getFailBlock)failBlock;
#pragma mark - 首页启动logo
-(void)getStartUpMessageWithSuccessBlock:(getBackDictionaryBlock)dictBlock andFailBlock:(getFailBlock)failBlock;
#pragma mark - 名人名言
-(void)getYuluWithSuccessBlock:(getBackDictionaryBlock)dictBlock andFailBlock:(getFailBlock)failBlock;
#pragma mark - 获取详情
-(void)getDetailVideoWithString:(NSString*)detailUrlString WithSuccessBlock:(getBackDictionaryBlock)dictBlock andFailBlock:(getFailBlock)failBlock;
-(void)getRelativeVedioAtID:(NSString*)vedioID andNum:(int)num WithSuccessBlock:(getBackDictionaryBlock)dictBlock andFailBlock:(getFailBlock)failBlock;
-(void)getMusicWithID:(NSString*)vedioID WithSuccessBlock:(getBackDictionaryBlock)dictBlock andFailBlock:(getFailBlock)failBlock;
#pragma mark - 更多 订单，课程，收藏，播放记录
-(void)getOrderListAtPage:(int)page perPage:(int)perPage WithSuccessBlock:(getBackDictionaryBlock)dictBlock andFailBlock:(getFailBlock)failBlock;
-(void)getCourseListAtPage:(int)page perPage:(int)perPage andClassName:(NSString*)classname andTutor:(NSString*)tutor WithSuccessBlock:(getBackDictionaryBlock)dictBlock andFailBlock:(getFailBlock)failBlock;
-(void)getStoreListAtPage:(int)page perPage:(int)perPage WithSuccessBlock:(getBackDictionaryBlock)dictBlock andFailBlock:(getFailBlock)failBlock;
-(void)getRecordListAtPage:(int)page perPage:(int)perPage WithSuccessBlock:(getBackDictionaryBlock)dictBlock andFailBlock:(getFailBlock)failBlock;
//提交和删除收藏的数据
-(void)commitStoreVideoId:(NSString*)stringID WithSuccessBlock:(getBackDictionaryBlock)dictBlock andFailBlock:(getFailBlock)failBlock;
-(void)deleteStoreVideoId:(NSString*)stringID WithSuccessBlock:(getBackDictionaryBlock)dictBlock andFailBlock:(getFailBlock)failBlock;
//删除 历史记录
-(void)deleteRecordVideoId:(NSString*)stringID WithSuccessBlock:(getBackDictionaryBlock)dictBlock andFailBlock:(getFailBlock)failBlock;
//获取优米活动
-(void)getHuoDongWithSuccessBlock:(getBackDictionaryBlock)dictBlock andFailBlock:(getFailBlock)failBlock;
#pragma mark - 应用推荐
-(void)getGoodApplicationWithSuccessBlock:(getBackDictionaryBlock)dictBlock andFailBlock:(getFailBlock)failBlock;
#pragma mark - 我的订单（新型）  &&  优惠劵  
-(void)getNewOrderListAtPage:(int)page perPage:(int)perPage WithSuccessBlock:(getBackDictionaryBlock)dictBlock andFailBlock:(getFailBlock)failBlock;
-(void)getCouponListAtPage:(int)page perPage:(int)perPage WithSuccessBlock:(getBackDictionaryBlock)dictBlock andFailBlock:(getFailBlock)failBlock;
#pragma mark - iPad >> 首页新加的视频请求
-(void)getLoginCourseWithSuccessBlock:(getBackDictionaryBlock)dictBlock andFailBlock:(getFailBlock)failBlock;
//职场新人 NewWorker
-(void)getNewWorkerAtPage:(int)page perPage:(int)perPage WithSuccessBlock:(getBackDictionaryBlock)dictBlock andFailBlock:(getFailBlock)failBlock;
//管理进阶 Management
-(void)getManagementAtPage:(int)page perPage:(int)perPage WithSuccessBlock:(getBackDictionaryBlock)dictBlock andFailBlock:(getFailBlock)failBlock;
//市场销售 MarketSales
-(void)getMarketSalesAtPage:(int)page perPage:(int)perPage WithSuccessBlock:(getBackDictionaryBlock)dictBlock andFailBlock:(getFailBlock)failBlock;
//创业商机 Business
-(void)getBusinessAtPage:(int)page perPage:(int)perPage WithSuccessBlock:(getBackDictionaryBlock)dictBlock andFailBlock:(getFailBlock)failBlock;
//职业技能 Skill
-(void)getSkillAtPage:(int)page perPage:(int)perPage WithSuccessBlock:(getBackDictionaryBlock)dictBlock andFailBlock:(getFailBlock)failBlock;
//大学生 College
-(void)getCollegeAtPage:(int)page perPage:(int)perPage WithSuccessBlock:(getBackDictionaryBlock)dictBlock andFailBlock:(getFailBlock)failBlock;
#pragma mark - iPad >> 排行榜
-(void)getRankWithType:(AFRankType)rankType WithSuccessBlock:(getBackDictionaryBlock)dictBlock andFailBlock:(getFailBlock)failBlock;
#pragma mark - iPad >> 线下活动列表
-(void)getActivityListAtPage:(int)page perPage:(int)perPage WithSuccessBlock:(getBackDictionaryBlock)dictBlock andFailBlock:(getFailBlock)failBlock;
#pragma mark - iPad >> 获取导师名字
-(void)getTutorWithSuccessBlock:(getBackDictionaryBlock)dictBlock andFailBlock:(getFailBlock)failBlock;
#pragma mark - 每次提交信息
-(void)getCommitInfoWithApp:(NSString*)app deviceid:(NSString*)deviceid channel:(NSString*)channel model:(NSString*)model version:(NSString*)version WithSuccessBlock:(getBackDictionaryBlock)dictBlock andFailBlock:(getFailBlock)failBlock;
#pragma mark - 获取最近的更新
-(void)getLatestAtPage:(int)page perPage:(int)perPage WithSuccessBlock:(getBackDictionaryBlock)dictBlock andFailBlock:(getFailBlock)failBlock;
#pragma mark - 专题获取
-(void)getZhuanTiAtPage:(int)page perPage:(int)perPage WithSuccessBlock:(getBackDictionaryBlock)dictBlock andFailBlock:(getFailBlock)failBlock;
#pragma mark - 今日限免课程
-(void)getTimeLimitFreeWithSuccessBlock:(getBackDictionaryBlock)dictBlock andFailBlock:(getFailBlock)failBlock;
#pragma mark - 中奖配置
-(void)getLuckyMenuWithSuccessBlock:(getBackDictionaryBlock)dictBlock andFailBlock:(getFailBlock)failBlock;
-(void)getLotteryListWithSuccessBlock:(getBackDictionaryBlock)dictBlock andFailBlock:(getFailBlock)failBlock;
-(void)getLotteryResultWithSuccessBlock:(getBackDictionaryBlock)dictBlock andFailBlock:(getFailBlock)failBlock;
-(void)getHomeShowWithSuccessBlock:(getBackDictionaryBlock)dictBlock andFailBlock:(getFailBlock)failBlock;
@end












