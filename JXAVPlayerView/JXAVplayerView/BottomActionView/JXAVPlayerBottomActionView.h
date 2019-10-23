//
//  JXAVPlayerBottomActionView.h
//  JXAVPlayerView
//
//  Created by JosephXuan on 2019/10/21.
//  Copyright © 2019 JosephXuan. All rights reserved.
//
//BJPUMediaControlView
#import <UIKit/UIKit.h>

@class JXAVPlayerBottomActionView;
@protocol JXAVPlayerBottomActionViewDelegate <NSObject>
@optional

//点击播放按钮
-(void)JXAVPlayerBottomActionView:(JXAVPlayerBottomActionView *)actionView clickedPlayButton:(UIButton *)playButton;
//点击暂停按钮
-(void)JXAVPlayerBottomActionView:(JXAVPlayerBottomActionView *)actionView clickedPauseButton:(UIButton *)pauseButton;

//点击倍速按钮
-(void)JXAVPlayerBottomActionView:(JXAVPlayerBottomActionView *)actionView clickedRightButton:(UIButton *)rightBtn;

//点击全屏按钮

//拖动进度条
@end


@interface JXAVPlayerBottomActionView : UIView
/**
 更新进度条
 currentTime
 cacheDuration
 totalDuration
 isHorizon
 */
-(void)updateProgressWithCurrentTime:(NSTimeInterval)currentTime cacheDuration:(NSTimeInterval)cacheDuration totalDuration:(NSTimeInterval)totalDuration isHorizon:(BOOL)isHorizon;
/**
 更新布局
*/
- (void)updateConstraintsWithLayoutType:(BOOL)horizon;
/**
 设置进度条是否可以使用
*/
- (void)setSlideEnable:(BOOL)enable;
/**
 设置播放btn标题
*/
- (void)updateWithRate:(NSString *)rateString;
/**
 设置 播放按钮-暂停按钮 播放状态
*/
- (void)updateWithPlayState:(BOOL)playing;

@end
