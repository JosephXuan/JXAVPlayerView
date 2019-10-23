//
//  JXAVPlayerBottomActionView.m
//  JXAVPlayerView
//
//  Created by JosephXuan on 2019/10/21.
//  Copyright © 2019 JosephXuan. All rights reserved.
//

#import "JXAVPlayerBottomActionView.h"
#import "JXAVPlayerProgressView.h"//进度条
#import "JXAVPlayerView+publicHeader.h"//头文件

static const CGFloat controlButtonH = 30.0;

@interface JXAVPlayerBottomActionView ()
//播放按钮
@property (nonatomic, strong) UIButton *playButton;
//暂停按钮
@property (nonatomic, strong) UIButton *pauseButton;
//全屏按钮
@property (nonatomic, strong) UIButton *scaleButton;
//倍速按钮
@property (nonatomic, strong) UIButton *rateButton;
//当前时间
@property (nonatomic, strong) UILabel *currentTimeLabel;
//总时间
@property (nonatomic, strong) UILabel *durationLabel;
//进度条
@property (nonatomic, strong) JXAVPlayerProgressView *progressView;
//记录更新状态 离开拖动 状态为no 开始拖动为yes
@property (nonatomic, assign) BOOL stopUpdateProgress;

@end

@implementation JXAVPlayerBottomActionView
- (instancetype)init {
    self = [super init];
    if (self) {
       
        [self setupSubviews];
    }
    return self;
}
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        [self setupSubviews];
    }
    return self;
}
-(void)setupSubviews{
    CGFloat margin = 10.0;
    //播放按钮
    [self addSubview:self.playButton];
    [self.playButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(margin);
        make.centerY.equalTo(self);
        make.size.mas_equalTo(CGSizeMake(controlButtonH, controlButtonH));
       
    }];
    
    //暂停按钮
    [self addSubview:self.pauseButton];
    [self.pauseButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.playButton);
    }];
    
    //全屏按钮
    CGFloat scaleButtonWidth = controlButtonH;
    [self addSubview:self.scaleButton];
    [self.scaleButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.right.equalTo(self).offset(-margin);
        make.height.equalTo(@(controlButtonH));
        make.width.equalTo(@(scaleButtonWidth));
    }];
    
    //倍速按钮
    [self addSubview:self.rateButton];
    [self.rateButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.right.equalTo(self.scaleButton.mas_left).offset(-margin);
        make.height.equalTo(@(controlButtonH));
        make.width.equalTo(@0.0); // to update
    }];
    
    //总时间 (默认竖屏 需要更新)
    [self addSubview:self.durationLabel];
    [self.durationLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self).offset(-5.0);
        make.right.equalTo(self.scaleButton.mas_left).offset(-20.0);
    }];
    
    //当前时间 (默认竖屏 需要更新)
    [self addSubview:self.currentTimeLabel];
    [self.currentTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
         make.centerY.equalTo(self.durationLabel);
         make.right.equalTo(self.durationLabel.mas_left);
        
    }];
    self.currentTimeLabel.font = [UIFont systemFontOfSize:10.0f];
    
   
     self.durationLabel.font = [UIFont systemFontOfSize:10.0f];
    //进度条 (默认竖屏 需要更新)
    [self addSubview:self.progressView];
    [self.progressView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.playButton.mas_right).offset(margin);
        make.right.equalTo(self.scaleButton.mas_left).offset(-margin);
        make.centerY.equalTo(self.playButton);
        make.height.equalTo(@10.0);
    }];
    
}

#pragma mark - public

- (void)updateConstraintsWithLayoutType:(BOOL)horizon {
    
    CGFloat margin = 10.0;
    
    if (UI_USER_INTERFACE_IDIOM() != UIUserInterfaceIdiomPad) {
      
    }
    if (horizon) {
        //竖屏
    } else {
        //横屏
    }
}

-(void)updateProgressWithCurrentTime:(NSTimeInterval)currentTime cacheDuration:(NSTimeInterval)cacheDuration totalDuration:(NSTimeInterval)totalDuration isHorizon:(BOOL)isHorizon {
    
    if (self.stopUpdateProgress) {
        return;
    }
    
    BOOL durationInvalid = (ceil(totalDuration) <= 0);
    
    self.currentTimeLabel.text = (!isHorizon && durationInvalid)? @"" : [NSString stringFromTimeInterval:currentTime totalTimeInterval:totalDuration];
    
    //横屏状态下 斜杠为空 竖屏状态下展示“/”
    NSString *separator = isHorizon? @"" : @" / ";
    
    self.durationLabel.text = durationInvalid? @"" : [NSString stringWithFormat:@"%@%@", separator, [NSString stringFromTimeInterval:totalDuration]];
    
    [self.progressView setValue:currentTime cache:cacheDuration duration:totalDuration];
    
}

- (void)updateWithPlayState:(BOOL)playing {
    self.playButton.hidden = playing;
    self.pauseButton.hidden = !playing;
}

- (void)setSlideEnable:(BOOL)enable {
    self.progressView.userInteractionEnabled = enable;
}

- (void)updateWithRate:(NSString *)rateString {
    
    [self.rateButton setTitle:rateString ?: @"1.0X" forState:UIControlStateNormal];
    
}


//播放按钮
-(UIButton *)playButton{
    if (!_playButton) {
        _playButton = [UIButton buttonWithType:UIButtonTypeCustom];
    }
    return _playButton;
}
//暂停按钮
-(UIButton *)pauseButton{
    if (!_pauseButton) {
        _pauseButton = [UIButton buttonWithType:UIButtonTypeCustom];
    }
    return _pauseButton;
}
//全屏按钮
-(UIButton *)scaleButton{
    if (!_scaleButton) {
        _scaleButton = [UIButton buttonWithType:UIButtonTypeCustom];
    }
    return _scaleButton;
}
//倍速按钮
-(UIButton *)rateButton{
    if (!_rateButton) {
        _rateButton = [UIButton buttonWithType:UIButtonTypeCustom];
    }
    return _rateButton;
};
//当前时间
-(UILabel *)currentTimeLabel{
    if (!_currentTimeLabel) {
        _currentTimeLabel = [[UILabel alloc]init];
    }
    return _currentTimeLabel;
}
//总时间
-(UILabel *)durationLabel{
    if (!_durationLabel) {
        _durationLabel = [[UILabel alloc]init];
    }
    return _durationLabel;
}
//进度条
-(JXAVPlayerProgressView *)progressView{
    if(!_progressView){
        _progressView = [[JXAVPlayerProgressView alloc]init];
    }
    return _progressView;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
