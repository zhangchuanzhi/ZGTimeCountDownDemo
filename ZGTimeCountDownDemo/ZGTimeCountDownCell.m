//
//  ZGTimeCountDownCell.m
//  ZGTimeCountDownDemo
//
//  Created by offcn_zcz32036 on 2017/6/27.
//  Copyright © 2017年 offcn. All rights reserved.
//

#import "ZGTimeCountDownCell.h"
#import "ZGTimeCountDownManager.h"
#import "ZGTimeCountDownModel.h"
static NSString * const cellId = @"ZGTimeCountDownCellID";//这个ID每创建一次，要修改一次
@interface ZGTimeCountDownCell ()
@property(nonatomic,strong)UILabel*titleLabel;
@property(nonatomic,strong)UILabel*timeLabel;
@end

@implementation ZGTimeCountDownCell
#pragma mark - reuseIdentifier
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        //监听通知
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(countDownNotification) name:kCountDownNotification object:nil];
        [self createUI];
    }
    return self;
}
#pragma mark - createViews
-(void)createUI
{
    _titleLabel=[[UILabel alloc]initWithFrame:CGRectMake(10, (self.frame.size.height-10)/2, [UIScreen mainScreen].bounds.size.width*2/3-20, 20)];
    _titleLabel.textAlignment=NSTextAlignmentLeft;
    _titleLabel.font=[UIFont systemFontOfSize:16];
    _titleLabel.textColor=[UIColor blackColor];
    [self addSubview:_titleLabel];
    _timeLabel=[[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_titleLabel.frame), (self.frame.size.height-10)/2, [UIScreen mainScreen].bounds.size.width-30-CGRectGetWidth(_titleLabel.frame), 20)];
    _timeLabel.textAlignment=NSTextAlignmentLeft;
    _timeLabel.font=[UIFont systemFontOfSize:14];
    _timeLabel.textColor=[UIColor blackColor];
    [self addSubview:_timeLabel];
}
-(void)setModel:(ZGTimeCountDownModel *)model
{
    _model=model;
    self.titleLabel.text=model.title;
    [self countDownNotification];
}
#pragma mark-倒计时通知回调
-(void)countDownNotification
{
    //判断是否需要倒计时--可能有的cell不需要倒计时，根据真实需求来判定
    if (0) {
        return;
    }
    //计算倒计时
    NSInteger countDown=[_model.count integerValue]-kTimeCountDownManager.timeInterval;
    //当倒计时到了进行回调
    if (countDown<=0) {
        _timeLabel.text=@"活动开始";
        //回调给控制器
        !self.countDoenZero?:self.countDoenZero();
        return;
    }
    //重新赋值
    self.timeLabel.text = [NSString stringWithFormat:@"倒计时%02zd:%02zd:%02zd", countDown/3600, (countDown/60)%60, countDown%60];

}
- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        //监听通知
         [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(countDownNotification) name:kCountDownNotification object:nil];
    }
    return self;
}
+ (instancetype) cellWithTableView:(UITableView *) tableView
{
    ZGTimeCountDownCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (cell == nil)
    {
        
        cell = [[ZGTimeCountDownCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
    }
    
    return cell;
}

-(void)dealloc
{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}
@end
