//
//  ZGTimeCountDownManager.h
//  ZGTimeCountDownDemo
//
//  Created by offcn_zcz32036 on 2017/6/27.
//  Copyright © 2017年 offcn. All rights reserved.
//

#import <Foundation/Foundation.h>
/// 使用单例
#define kTimeCountDownManager [ZGTimeCountDownManager manager]
/// 倒计时的通知
#define kCountDownNotification @"CountDownNotification"
@interface ZGTimeCountDownManager : NSObject
//时间（单位：秒）
@property(nonatomic,assign)NSInteger timeInterval;
//使用单例
+(instancetype)manager;
//开始倒计时
-(void)start;
//刷新倒计时
-(void)reload ;
//停止倒计时
-(void)invalidate;
@end
