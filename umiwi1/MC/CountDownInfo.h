//
//  CountDownInfo.h
//  iPad
//
//  Created by 孙超凡 QQ:729397005 on 13-8-21.
//  Copyright (c) 2013年 优米网. All rights reserved.
//
//  C++ 之王者归来！C++ 永远的王道！
#ifndef __iPad__CountDownInfo__
#define __iPad__CountDownInfo__

#include <iostream>
#include <map>
#include <string>
using namespace std;
typedef struct {
    int num;
    int state;
}itemsStruct;
class CountDownInfo
{
public:
    void countStateAndNum(int **state,int **num,NSArray* albumArray,NSArray* videoArray,int downNowNum);
};


#endif /* defined(__iPad__CountDownInfo__) */
