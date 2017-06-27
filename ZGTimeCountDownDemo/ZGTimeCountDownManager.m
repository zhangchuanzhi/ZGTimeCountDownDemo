//
//  ZGTimeCountDownManager.m
//  ZGTimeCountDownDemo
//
//  Created by offcn_zcz32036 on 2017/6/27.
//  Copyright © 2017年 offcn. All rights reserved.
//

#import "ZGTimeCountDownManager.h"
@interface ZGTimeCountDownManager()
@property(nonatomic,strong)NSTimer*timer;
@end
@implementation ZGTimeCountDownManager
+(instancetype)manager
{
    static ZGTimeCountDownManager *manager=nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager=[[ZGTimeCountDownManager alloc]init];
    });
    return manager;
}
-(void)start
{
    //启动定时器
    [self timer];
}
-(NSTimer *)timer
{
    if (!_timer) {
        _timer=[NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timerAction) userInfo:nil repeats:YES];
        [[NSRunLoop mainRunLoop]addTimer:_timer forMode:NSRunLoopCommonModes];
    }
    return _timer;
}
-(void)timerAction
{
    //时间差+1
    self.timeInterval++;
    //发出通知--可以将时间差传递出去，或者直接通知类属性取
    [[NSNotificationCenter defaultCenter]postNotificationName:kCountDownNotification object:nil userInfo:@{@"TimeInterval" : @(self.timeInterval)}];
}
-(void)reload
{
    //刷新只要让时间差为0即可
    _timeInterval=0;
}
-(void)invalidate
{
    [self.timer invalidate];
    self.timer=nil;
    _timeInterval=0;
}
@end
