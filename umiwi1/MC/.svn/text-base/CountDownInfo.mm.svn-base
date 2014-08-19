//
//  CountDownInfo.mm
//  iPad
//
//  Created by 孙超凡 QQ:729397005 on 13-8-21.
//  Copyright (c) 2013年 优米网. All rights reserved.
//

#include "CountDownInfo.h"
void CountDownInfo::countStateAndNum(int **state,int **num,NSArray* albumArray,NSArray* videoArray,int downNowNum)
{
    if (albumArray.count == 0 || videoArray.count == 0) {
        return;
    }
    //对那些指针的内存进行调整
    if (*state != NULL) {
        *state = (int *)realloc(*state, albumArray.count * sizeof(int));
    }
    else{
        *state = (int *)malloc(albumArray.count * sizeof(int));
    }
    if (*num != NULL) {
        *num = (int *)realloc(*num, albumArray.count * sizeof(int));
    }
    else{
        *num = (int *)malloc(albumArray.count * sizeof(int));
    }
    
    //初始化map
    map<NSString*,itemsStruct> dataMap;
    for (NSDictionary *dict in albumArray) {
        dataMap[dict[@"id"]] = {0,0};
    }
    //统计信息
    for(int i = 0;i<videoArray.count;i++){
        NSDictionary *dict = videoArray[i];
        NSLog(@"dict=%@",dict[@"countid"]);
        dataMap[dict[@"countid"]].num ++;
        if ([dict[@"state"] isEqualToString:@"1"]) {
            if (dataMap[dict[@"countid"]].state < 1) {
                dataMap[dict[@"countid"]].state = 1;
            }
        }
        else if([dict[@"state"] isEqualToString:@"0"]){
            if (i == downNowNum) {
                if (dataMap[dict[@"countid"]].state < 3) {
                    dataMap[dict[@"countid"]].state = 3;
                }
            }
            else{
                if (dataMap[dict[@"countid"]].state < 2) {
                    dataMap[dict[@"countid"]].state = 2;
                }
            }
        }
        else{
            //不操作啦！
        }
    }
    //赋值
    for (int i=0; i<albumArray.count; i++) {
        NSDictionary *dict = albumArray[i];
        (*state)[i]=dataMap[dict[@"id"]].state;
        (*num)[i]=dataMap[dict[@"id"]].num;
        NSLog(@"state=%d,num=%d",dataMap[dict[@"id"]].state,dataMap[dict[@"id"]].num);
    }
}