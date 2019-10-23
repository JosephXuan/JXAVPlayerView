//
//  JXVideoPlayListTabCell.h
//  JXAVPlayerView
//
//  Created by JosephXuan on 2019/10/21.
//  Copyright © 2019 JosephXuan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JXVideoPlayListModel.h"//model
NS_ASSUME_NONNULL_BEGIN

static NSString *const playCellID=@"playCellID";

@interface JXVideoPlayListTabCell : UITableViewCell

/** 快速创建Cell */
+ (instancetype)cellWithTableView:(UITableView *)tableView withIdentifier:(NSString *)cellIdentifier indexPath:(NSIndexPath *)indexPath;

@property(nonatomic,strong)JXVideoPlayListModel * listModel;

+(CGFloat)returnHeightWithPlayModel:(JXVideoPlayListModel *)playModel;
@end

NS_ASSUME_NONNULL_END
