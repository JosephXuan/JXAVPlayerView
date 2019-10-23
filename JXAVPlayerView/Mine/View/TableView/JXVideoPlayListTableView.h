//
//  JXVideoPlayListTableView.h
//  JXAVPlayerView
//
//  Created by JosephXuan on 2019/10/21.
//  Copyright © 2019 JosephXuan. All rights reserved.
//

#import <UIKit/UIKit.h>
@class JXVideoPlayListModel;

NS_ASSUME_NONNULL_BEGIN

@protocol didSelectCellDelegate <NSObject>

@optional
//cell的点击方法
- (void)tableView:(UITableView *)tableView didselectIndexPath:(NSIndexPath *)indexPath;


@end

@interface JXVideoPlayListTableView : UITableView

//评论的数据
@property(nonatomic,strong)NSArray < JXVideoPlayListModel * >* playListArr;

//代理
@property (nonatomic, weak) id<didSelectCellDelegate> cellDelegate;

@end

NS_ASSUME_NONNULL_END
