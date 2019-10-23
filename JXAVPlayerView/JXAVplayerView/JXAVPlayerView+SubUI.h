//
//  JXAVPlayerView+SubUI.h
//  JXAVPlayerView
//
//  Created by JosephXuan on 2019/10/22.
//  Copyright © 2019 JosephXuan. All rights reserved.
//
//通过分类创建UI 避免代码臃肿 从而逻辑清晰 方便维护

#import "JXAVPlayerView.h"

NS_ASSUME_NONNULL_BEGIN

@interface JXAVPlayerView (SubUI)
//创建子视图 （）
- (void)setupSubviews;

@end

NS_ASSUME_NONNULL_END
