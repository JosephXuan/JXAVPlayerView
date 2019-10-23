//
//  JXAVPlayerProgressView.h
//  JXAVPlayerView
//
//  Created by JosephXuan on 2019/10/21.
//  Copyright © 2019 JosephXuan. All rights reserved.
//
//BJPUProgressView
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class JXAVPlayeSlider;

@interface JXAVPlayerProgressView : UIView

@property (nonatomic, nullable) JXAVPlayeSlider *slider;
/**
 设置 progress的值
 */
- (void)setValue:(CGFloat)value cache:(CGFloat)cache duration:(CGFloat)duration;

@end

#pragma mark - custom slider

@interface JXAVPlayeSlider : UISlider

@end

NS_ASSUME_NONNULL_END
