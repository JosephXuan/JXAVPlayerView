//
//  JXAVPlayerView+publicHeader.h
//  JXAVPlayerView
//
//  Created by JosephXuan on 2019/10/22.
//  Copyright © 2019 JosephXuan. All rights reserved.
//
//公共头文件

#import "JXAVPlayerView.h"

#import "JXAVPlayerTools.h"//
#import "JXAVPlayerBottomActionView.h"//底部操作view
#import "JXAVPlayerTopInfoView.h"//顶部navInfoView
#import "JXAVPlayerSliderView.h"//上层的手势view
#import "NSString+Deal.h"//处理

NS_ASSUME_NONNULL_BEGIN

@interface JXAVPlayerView ()


//用来存放 player
@property (nonatomic, strong) UIView *contentView;
//底部操作view
@property (nonatomic, strong) JXAVPlayerBottomActionView *bottomactionView;
//顶部navInfoView
@property (nonatomic, strong) JXAVPlayerTopInfoView *topInfoView;
//上层的手势view
@property (nonatomic, strong) JXAVPlayerSliderView *sliderView;
//锁屏键
@property (nonatomic, strong )UIButton * lockButton;

@end


NS_ASSUME_NONNULL_END
