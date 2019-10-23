//
//  JXAVPlayerSliderView.h
//  JXAVPlayerView
//
//  Created by JosephXuan on 2019/10/21.
//  Copyright © 2019 JosephXuan. All rights reserved.
//
//操作view 视频播放的上层的操作view（）
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class JXAVPlayerSliderView;

@protocol JXAVPlayerSliderViewDelegate <NSObject>

@optional
//拖动-获取 当前播放到的时间
- (CGFloat)originValueForTouchSlideView:(JXAVPlayerSliderView *)touchSlideView;
//拖动-获取 总时间
- (CGFloat)durationValueForTouchSlideView:(JXAVPlayerSliderView *)touchSlideView;

//更新 拖动 进度
- (void)touchSlideView:(JXAVPlayerSliderView *)touchSlideView finishHorizonalSlide:(CGFloat)value;

@end


@interface JXAVPlayerSliderView : UIView

@property (nonatomic, weak) id<JXAVPlayerSliderViewDelegate> delegate;
//是否允许拖动
@property (nonatomic, assign) BOOL slideEnabled;

@end

//屏幕亮度 展示view
@interface JXAVPlayerSliderLightView : UIView
 
@end

//拖动时  进度展示View
@interface JXAVPlayerSliderSeekView : UIView

- (void)resetRelTime:(long)relTime duration:(long)duration difference:(long)difference;

@end


NS_ASSUME_NONNULL_END
