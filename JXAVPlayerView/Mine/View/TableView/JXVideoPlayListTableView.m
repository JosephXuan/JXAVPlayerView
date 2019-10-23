//
//  JXVideoPlayListTableView.m
//  JXAVPlayerView
//
//  Created by JosephXuan on 2019/10/21.
//  Copyright © 2019 JosephXuan. All rights reserved.
//

#import "JXVideoPlayListTableView.h"
#import "JXVideoPlayListTabHeadView.h"//表头
#import "JXVideoPlayListTabCell.h"//cell
#import "JXVideoPlayListModel.h"//model

@interface JXVideoPlayListTableView() <UITableViewDataSource,UITableViewDelegate>


@end

@implementation JXVideoPlayListTableView
- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {
    self = [super initWithFrame:frame style:style];
    if (self) {
        self.delegate = self;
        self.dataSource = self;
    }
    return self;
}

#pragma mark - UITableViewDelegate , UITableViewDataSource
- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView{
    
   //数据区
    NSLog(@"多少行数据>>%ld",self.playListArr.count);
    return self.playListArr.count;
    
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    //如果有集合返回集合count
    return 1;
    
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    //展示评论区
    JXVideoPlayListTabCell *cell = [JXVideoPlayListTabCell cellWithTableView:tableView withIdentifier:playCellID indexPath:indexPath];

    return cell;
   
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    JXVideoPlayListModel *listModel;
    if (indexPath.section<self.playListArr.count) {
        listModel=self.playListArr[indexPath.section];
        
    }
    CGFloat cellHeight=0.f;

    cellHeight=[JXVideoPlayListTabCell returnHeightWithPlayModel:listModel];
    
    return cellHeight;
}


- (CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 0.01;
    
}

- (CGFloat) tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    return 0.01;
    
    
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    UIView *headerView = [[UIView alloc]init];
    return headerView;
    
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
   
    UIView *bgView = [[UIView alloc]init];
    bgView.backgroundColor = [UIColor whiteColor];
    return bgView;
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if ([self.cellDelegate respondsToSelector:@selector(tableView:didselectIndexPath:)]) {
        [_cellDelegate tableView:tableView didselectIndexPath:indexPath];
    }
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
