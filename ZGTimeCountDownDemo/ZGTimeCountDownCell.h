//
//  ZGTimeCountDownCell.h
//  ZGTimeCountDownDemo
//
//  Created by offcn_zcz32036 on 2017/6/27.
//  Copyright © 2017年 offcn. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ZGTimeCountDownModel;
@interface ZGTimeCountDownCell : UITableViewCell
@property(nonatomic,strong)ZGTimeCountDownModel*model;
//可能有的不需要倒计时，如倒计时时间已到，或者已经过了
@property(nonatomic,assign)BOOL needCountDown;
@property(nonatomic,copy)void(^countDoenZero)();
//自定义初始化方法
+ (instancetype) cellWithTableView:(UITableView *) tableView;
@end
