//
//  JXVideoPlayViewController.m
//  JXAVPlayerView
//
//  Created by JosephXuan on 2019/10/21.
//  Copyright © 2019 JosephXuan. All rights reserved.
//

#import "JXVideoPlayViewController.h"

#import "JXAVPlayerView+publicHeader.h"//头文件
#import "JXVideoPlayListModel.h"//model
#import "JXVideoPlayListTableView.h"//tableView
#import "JXVideoPlayListTabHeadView.h"//表头
#import "JXVideoPlayListTabCell.h"//cell

#define tabHeadHeight 180
@interface JXVideoPlayViewController ()<JXVideoPlayListTabHeadViewDelegate>
//表
@property(nonatomic,strong)JXVideoPlayListTableView * listTableView;
//数据源
@property(nonatomic,strong)NSMutableArray * listMuArr;
//
@property(nonatomic,strong)JXVideoPlayListTabHeadView * tabHeadView;
@end

@implementation JXVideoPlayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
     if (@available(iOS 13.0, *)) {
           self.view.backgroundColor = [UIColor systemGroupedBackgroundColor];
       } else {
           // Fallback on earlier versions
           self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
       }
    [self setUpView];
    [self loadDataSource];
}
#pragma mark -- 请求数据
-(void)loadDataSource{
   
    for (int i = 0; i < 10; i++) {
        JXVideoPlayListModel *listModel = [[JXVideoPlayListModel alloc]init];
        listModel.titleStr = [NSString stringWithFormat:@"第%d区",i];
        [self.listMuArr addObject:listModel];
    }
    self.listTableView.playListArr = [self.listMuArr copy];
    [self.listTableView reloadData];
    
}
#pragma makr -- 设置view
-(void)setUpView{
    
    [self.view addSubview:self.listTableView];
    [self.listTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
        
    }];
    self.tabHeadView.delegate=self;
    self.listTableView.tableHeaderView = self.tabHeadView;
}
#pragma mark -- delegate
- (void)videoPlayListTabHeadView:(UIView *)tabHeadView didClickPlayBtn:(UIButton *)btn{
    
}

//http://vfx.mtime.cn/Video/2019/02/04/mp4/190204084208765161.mp4
-(JXVideoPlayListTableView * )listTableView{
    if (!_listTableView) {
        _listTableView = [[JXVideoPlayListTableView alloc]initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        [_listTableView registerClass:[JXVideoPlayListTabCell class] forCellReuseIdentifier:playCellID];
       // _listTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _listTableView.backgroundColor = [UIColor whiteColor];
    }
    return _listTableView;
}
-(NSMutableArray *)listMuArr{
    if (!_listMuArr) {
        _listMuArr = [[NSMutableArray alloc]init];
    }
    return _listMuArr;
}
-(JXVideoPlayListTabHeadView *)tabHeadView{
    if (!_tabHeadView) {
        _tabHeadView = [[JXVideoPlayListTabHeadView alloc]initWithFrame:CGRectMake(0, 0, KAppScreenWidth, tabHeadHeight)];
    }
    return _tabHeadView;
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
