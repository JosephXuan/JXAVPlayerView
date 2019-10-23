//
//  JXAVPlayerView+SubUI.m
//  JXAVPlayerView
//
//  Created by JosephXuan on 2019/10/22.
//  Copyright © 2019 JosephXuan. All rights reserved.
//

#import "JXAVPlayerView+SubUI.h"
#import "JXAVPlayerView+publicHeader.h"//头文件

@implementation JXAVPlayerView (SubUI)

- (void)setupSubviews{
    
    //添加视频内容view
    UIView *contentView = self.contentView;
    [self addSubview:contentView];
    [contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.edges.mas_equalTo(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
    
    //添加顶部infoview
    CGFloat topBarHeight = NAVIGATION_BAR_HEIGHT;
    [self addSubview:self.topInfoView];
    [self.topInfoView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top).offset(0);
        make.left.right.equalTo(self);
        make.height.equalTo(@(topBarHeight)).priorityHigh();
    }];
    
    
    //添加底部操作view
    [self addSubview:self.bottomactionView];
    [self.bottomactionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self);
        make.bottom.offset(TAB_BAR_HEIGHT);
        make.height.equalTo(@44.0).priorityHigh();
    }];
    
    
    //添加 手势view
    [self addSubview:self.sliderView];
    [self.sliderView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self);
        make.top.equalTo(self.topInfoView.mas_bottom);
        make.bottom.equalTo(self.bottomactionView.mas_top);
    }];
    //添加锁屏按钮
    [self addSubview:self.lockButton];
    [self.lockButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(NAVIGATION_BAR_HEIGHT+20.0);
        make.centerY.equalTo(self);
    }];
    
    //添加操作
    [self setupControlActions];
}

#pragma mark - actions

- (void)setupControlActions {
    
    // show & hide 单击手势
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showOrHideInterfaceViews)];
    [self.sliderView addGestureRecognizer:tap];
    
    // lock 锁屏按钮 操作
    [self.lockButton addTarget:self action:@selector(lockAction) forControlEvents:UIControlEventTouchUpInside];
    
    //双击手势
    UITapGestureRecognizer *doubleTapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(handleDoubleTap:)];
    doubleTapGesture.numberOfTapsRequired =2;
    doubleTapGesture.numberOfTouchesRequired =1;
    [self addGestureRecognizer:doubleTapGesture];
    
    //顶部view-delegate
   // self.topInfoView
    //底部view-delegate
   // self.bottomactionView
   
    
    
}

//双击
- (void)handleDoubleTap:(UITapGestureRecognizer *)gestureRecognizer{
    
    
}
/*
- (void)backAction {
    if (self.layoutType == BJYPlayerViewLayoutType_FullHorizon) {
        if (self.playType == BJYPlayerViewScreenFullScreenType) {
            [self cancelAction];
        }else{
            self.manualRotation = YES;
            [self configLayoutType:BJYPlayerViewLayoutType_Vertical];
        }
    }
    else {
        [self cancelAction];
    }
}

- (void)cancelAction {
    if (self.cancelCallback) {
        self.cancelCallback();
    }
}

- (void)lockAction {
    BOOL lock = !self.lockButton.selected;
    self.lockButton.selected = lock;
    self.mediaControlView.hidden = lock;
    self.mediaSettingView.hidden = YES;
    self.topBarView.hidden = lock;
    self.sliderView.slideEnabled = !lock;
    [self.mediaControlView setSlideEnable:!lock];
    if (self.screenLockCallback) {
        self.screenLockCallback(lock);
    }
}

#pragma mark - show & hide

- (void)hideInterfaceViews {
    NSTimeInterval duration = 1.0;
    [self hideView:self.topBarView withDuration:duration];
    [self hideView:self.mediaControlView withDuration:duration];
    [self hideView:self.lockButton withDuration:duration];
}

- (void)hideInterfaceViewsAutomatically {
    if (!self.mediaControlView.slideCanceled) {
        // 进度条响应交互中，不执行隐藏
        [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(hideInterfaceViewsAutomatically) object:nil];
        [self performSelector:@selector(hideInterfaceViewsAutomatically) withObject:nil afterDelay:5.0];
        return;
    }
    [self hideInterfaceViews];
}

- (void)showOrHideInterfaceViews {
    if (self.layoutType == BJYPlayerViewLayoutType_FullHorizon) {
        self.lockButton.hidden = !self.lockButton.hidden;
        [self hideView:self.mediaSettingView withDuration:0.5];
    }
    if (self.lockButton.selected) {
        return;
    }
    
    if (self.layoutType == BJYPlayerViewLayoutType_FullHorizon && !self.mediaSettingView.hidden) {
        self.mediaSettingView.hidden = YES;
    }
    
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(hideInterfaceViewsAutomatically) object:nil];
    BOOL hidden = !self.mediaControlView.hidden;
    self.mediaControlView.hidden = hidden;
    self.topBarView.hidden = hidden;
    if (!self.mediaControlView.hidden) {
        [self performSelector:@selector(hideInterfaceViewsAutomatically) withObject:nil afterDelay:5.0];
    }
}

- (void)hideView:(UIView *)view withDuration:(NSTimeInterval)duration {
    [UIView animateWithDuration:0.5 animations:^{
        view.alpha = 0.0;
    } completion:^(BOOL finished) {
        view.hidden = YES;
        view.alpha = 1.0;
    }];
}

#pragma mark - public

- (void)configBackButtonHidden:(BOOL)isHidden{
    self.backVideoButton.hidden = isHidden;
    if (isHidden) {
        self.topBarView.backgroundColor = [[BJPUTheme brandColor] colorWithAlphaComponent:0.0];
    } else {
        self.topBarView.backgroundColor = [[BJPUTheme brandColor] colorWithAlphaComponent:0.4];
    }
}
- (void)configBarTitleLabHidden:(BOOL)isHidden{
    self.barTitleLab.hidden = isHidden;
    if (isHidden) {
        self.barTitleLab.textColor = [[BJPUTheme brandColor] colorWithAlphaComponent:0.0];
    } else {
        self.barTitleLab.textColor = [UIColor whiteColor];
    }
}
- (void)updateConstriantsWithLayoutType:(BJYPlayerViewLayoutType)layoutType {
    BOOL horizon = (layoutType == BJYPlayerViewLayoutType_FullHorizon);
    BOOL locked = self.lockButton.selected;
    if (locked && !horizon) {
        [self configBackButtonHidden:NO];
        [self configBarTitleLabHidden:NO];
        [self configLayoutType:BJYPlayerViewLayoutType_FullHorizon];
        return;
    }
    
    if (horizon || self.playType == BJYPlayerViewScreenFullScreenType) {
        [self configBackButtonHidden:NO];
        [self configBarTitleLabHidden:NO];
    }else{
       [self configBackButtonHidden:YES];
        [self configBarTitleLabHidden:YES];
    }
    [self configLayoutType:layoutType];
    [self updatePlayProgress];
    
    [self.mediaControlView updateConstraintsWithLayoutType:horizon];
    BOOL controlHidden = self.mediaControlView.hidden;
    // mediaSettingView: 1: 竖屏：直接隐藏；2.之前是隐藏状态，继续保持。
    self.mediaSettingView.hidden = !horizon || self.mediaSettingView.hidden;
    self.lockButton.hidden = !horizon || controlHidden;
    
    
}

- (void)updatePlayerViewConstraintWithVideoRatio:(CGFloat)ratio {
    UIView *playerView = self.playerManager.playerView;
    [playerView bjl_remakeConstraints:^(BJLConstraintMaker *make) {
        if (ratio > 0) {
            make.edges.equalTo(self).priorityHigh();
            make.width.equalTo(playerView.bjl_height).multipliedBy(ratio);
            make.center.equalTo(self);
            make.top.left.greaterThanOrEqualTo(self);
            make.bottom.right.lessThanOrEqualTo(self);
        }
        else {
            make.edges.equalTo(self);
        }
    }];
}

- (void)updatePlayerViewConstraintRatio{
    BJVDefinitionInfo *definitionInfo = self.playerManager.currDefinitionInfo;
    CGFloat width = definitionInfo.width;
    CGFloat height = definitionInfo.height;
    if (width > 0.0 && height > 0.0) {
        CGFloat videoRatio = width / height;
        // 更新播放视图宽高比
        [self updatePlayerViewConstraintWithVideoRatio:videoRatio];
    }
}
- (void)updatePlayProgress {
    NSTimeInterval curr = self.playerManager.currentTime;
    NSTimeInterval cache = self.playerManager.cachedDuration;
    NSTimeInterval total = self.playerManager.duration;
    BOOL horizon = (self.layoutType == BJYPlayerViewLayoutType_FullHorizon);
    if (self.playerDelegate&& [self.playerDelegate respondsToSelector:@selector(getVideoPlayerWithPlayCurrentTime:duration:)]) {
        [self.playerDelegate getVideoPlayerWithPlayCurrentTime:curr duration:total];
    }
    [self.mediaControlView updateProgressWithCurrentTime:curr
                                           cacheDuration:cache
                                           totalDuration:total
                                               isHorizon:horizon];
}

- (void)updateWithPlayState:(BJVPlayerStatus)state {
    if (state == BJVPlayerStatus_paused ||
        state == BJVPlayerStatus_stopped ||
        state == BJVPlayerStatus_reachEnd ||
        state == BJVPlayerStatus_failed ||
        state == BJVPlayerStatus_ready) {
        [self.mediaControlView updateWithPlayState:NO];
    }
    else if (state == BJVPlayerStatus_playing) {
        [self.mediaControlView updateWithPlayState:YES];
    }
    
    [self updatePlayProgress];
}

- (void)showMediaSettingView {
    if (self.layoutType != BJYPlayerViewLayoutType_FullHorizon) {
        return;
    }
    [self hideInterfaceViews];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        self.mediaSettingView.hidden = NO;
    });
}
*/

@end

