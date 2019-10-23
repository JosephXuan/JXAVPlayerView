//
//  JXAVPlayerTopInfoView.h
//  JXAVPlayerView
//
//  Created by JosephXuan on 2019/10/21.
//  Copyright © 2019 JosephXuan. All rights reserved.
//
//视频顶部 导航栏
#import <UIKit/UIKit.h>


@class JXAVPlayerTopInfoView;
@protocol JXAVPlayerTopInfoViewDelegate <NSObject>
@optional
//点击返回按钮
-(void)JXAVPlayerTopInfoView:(JXAVPlayerTopInfoView *)infoView clickedBackButton:(UIButton *)backBtn;
//点击右侧按钮
-(void)JXAVPlayerTopInfoView:(JXAVPlayerTopInfoView *)infoView clickedRightButton:(UIButton *)rightBtn;

@end


NS_ASSUME_NONNULL_BEGIN

@interface JXAVPlayerTopInfoView : UIView


@property (nonatomic, weak)id <JXAVPlayerTopInfoViewDelegate> delegate;

//设置返回按钮 图片
-(void)setBackBtnImg:(UIImage *)backBtnImg;

//设置标题
-(void)setTitleStr:(NSString *)titleStr;

//设置右按钮 标题
-(void)setRightBtnTitleStr:(NSString *)rightBtnStr;

//设置右按钮 图片
-(void)setRightBtnTitleImg:(UIImage *)rightBtnImg;

//获取左侧按钮
-(UIButton *)getBackBtn;

//获取标题
-(UILabel *)getTitleLab;

//获取右侧按钮
-(UIButton *)getRightBtn;

@end

NS_ASSUME_NONNULL_END
