//
//  ViewController.m
//  ZGTimeCountDownDemo
//
//  Created by offcn_zcz32036 on 2017/6/27.
//  Copyright © 2017年 offcn. All rights reserved.
//

#import "ViewController.h"
#import "ZGTimeCountDownManager.h"
#import "ZGTimeCountDownModel.h"
#import "ZGTimeCountDownCell.h"
@interface ViewController ()
<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,strong)UITableView*tableView;
@property(nonatomic,strong)NSArray*dataSource;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //启动倒计时管理
    [kTimeCountDownManager start];
    self.tableView.refreshControl=[UIRefreshControl new];
    [self.tableView.refreshControl addTarget:self action:@selector(reloadData) forControlEvents:UIControlEventValueChanged];
}
-(UITableView *)tableView
{
    if (!_tableView) {
        _tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 64, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height-64)];
        _tableView.dataSource=self;
        _tableView.delegate=self;
        _tableView.showsVerticalScrollIndicator=NO;
        _tableView.showsHorizontalScrollIndicator=NO;
        [self.view addSubview:_tableView];
    }
    return _tableView;
}
-(NSArray *)dataSource
{
    if (!_dataSource) {
        NSMutableArray *mutArr=[NSMutableArray array];
        for (NSInteger i=0; i<50; i++) {
            //模拟从服务器取得数据-服务器返回的数据为剩余时间数
            NSInteger count=arc4random_uniform(100);
            ZGTimeCountDownModel*model=[[ZGTimeCountDownModel alloc]init];
            model.count=[NSString stringWithFormat:@"%zd",count];
            model.title=[NSString stringWithFormat:@"第%zd条数据",i];
            [mutArr addObject:model];
        }
        _dataSource=mutArr.copy;
    }
    return _dataSource;
}
#pragma mark-刷新数据
-(void)reloadData
{
    self.dataSource=nil;
    [kTimeCountDownManager reload];
    [self.tableView reloadData];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.tableView.refreshControl endRefreshing];
    });
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSource.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ZGTimeCountDownCell *cell=[ZGTimeCountDownCell cellWithTableView:tableView];
    cell.model=self.dataSource[indexPath.row];
    return cell;
}
@end
