//
//  JXVideoPlayListTabHeadView.h
//  JXAVPlayerView
//
//  Created by JosephXuan on 2019/10/21.
//  Copyright © 2019 JosephXuan. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN


@protocol JXVideoPlayListTabHeadViewDelegate <NSObject>

@optional
//播放按钮点击方法
- (void)videoPlayListTabHeadView:(UIView *)tabHeadView didClickPlayBtn:(UIButton *)btn;


@end

@interface JXVideoPlayListTabHeadView : UIView
//代理
@property (nonatomic, weak) id<JXVideoPlayListTabHeadViewDelegate> delegate;
/* 1:展示 2:隐藏 默认展示 */
-(void)setPlayBtnUIStatus:(NSInteger)status;

@end

NS_ASSUME_NONNULL_END
