//
//  JXAVPlayerProgressView.m
//  JXAVPlayerView
//
//  Created by JosephXuan on 2019/10/21.
//  Copyright © 2019 JosephXuan. All rights reserved.
//

#import "JXAVPlayerProgressView.h"
#import "JXAVPlayerView+publicHeader.h"//头文件

@interface JXAVPlayerProgressView ()

@property (nonatomic, strong) UIImageView *sliderBgView;
@property (nonatomic, strong) UIView *cacheView;

@end
@implementation JXAVPlayerProgressView
- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.translatesAutoresizingMaskIntoConstraints = NO; // 解决警告
        [self setupSubviews];
    }
    return self;
}

#pragma mark - subViews

- (void)setupSubviews {
    // slideBgView
    [self addSubview:self.sliderBgView];
    [self.sliderBgView  mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self).insets(UIEdgeInsetsMake(4.0, 0.0, 4.0, 0.0));
    }];
    
    
    // cacheView
    [self addSubview:self.cacheView];
    [self.cacheView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.equalTo(self.sliderBgView);
        make.width.equalTo(self.sliderBgView).multipliedBy(FLT_MIN);
    }];
    
    
    // slider
    [self addSubview:self.slider];
    [self.slider mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.sliderBgView).insets(UIEdgeInsetsMake(-1.0, 0.0, 0.0, 0.0));
    }];
   
}

#pragma mark - public

- (void)setValue:(CGFloat)value cache:(CGFloat)cache duration:(CGFloat)duration {
    // slider
    self.slider.maximumValue = duration;
    self.slider.value = value;
    
    // cache
    CGFloat cacheRate = (duration > 0)? cache / duration : FLT_MIN;
    [self.cacheView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.equalTo(self.sliderBgView);
        make.width.equalTo(self.sliderBgView).multipliedBy(MIN(1.0, cacheRate));
    }];
    
}

- (void)dealloc {
    self.sliderBgView = nil;
    self.slider = nil;
}
#pragma mark - getters & setters

- (UIImageView *)sliderBgView {
    if (!_sliderBgView) {
        _sliderBgView = ({
            UIImage *image = [UIImage  imageNamed:@"ic_player_progress_gray_n.png"];
            UIImage *stretchImage = [image stretchableImageWithLeftCapWidth:image.size.width * 0.5 topCapHeight:image.size.height * 0.5];
            UIImageView *imageView = [[UIImageView alloc] initWithImage:stretchImage];
            imageView;
        });
    }
    return _sliderBgView;
}


- (JXAVPlayeSlider *)slider {
    if (!_slider) {
        _slider = ({
            JXAVPlayeSlider *slider = [[JXAVPlayeSlider alloc] init];
            slider.backgroundColor = [UIColor clearColor];
            slider.minimumTrackTintColor = [UIColor clearColor];
            slider.maximumTrackTintColor = [UIColor clearColor];
            
            UIImage *leftImage = [UIImage imageNamed:@"ic_player_progress_orange_n.png"];
            UIImage *leftStretch = [leftImage stretchableImageWithLeftCapWidth:leftImage.size.width * 0.5                    topCapHeight:leftImage.size.height * 0.5];

            [slider setMinimumTrackImage:leftStretch forState:UIControlStateNormal];
            
            [slider setThumbImage:[UIImage imageNamed:@"ic_player_current_n.png"] forState:UIControlStateNormal];
            [slider setThumbImage:[UIImage imageNamed:@"ic_player_current_big_n.png"] forState:UIControlStateHighlighted];
            slider;
        });
    }
    return _slider;
}

- (UIView *)cacheView {
    if (!_cacheView) {
        _cacheView = ({
            UIView *view = [[UIView alloc] init];
            view.layer.masksToBounds = YES;
            view.layer.cornerRadius = 1.0;
            view.backgroundColor = [UIColor whiteColor];
            view;
        });
    }
    return _cacheView;
}

@end

#pragma mark - custom slider

@implementation JXAVPlayeSlider

- (CGRect)thumbRectForBounds:(CGRect)bounds trackRect:(CGRect)rect value:(float)value {
    CGRect thumbRect = [super thumbRectForBounds:bounds trackRect:rect value:value];
    thumbRect.origin.x = (self.maximumValue > 0?(value / self.maximumValue * self.frame.size.width):0) - self.currentThumbImage.size.width / 2;
    thumbRect.origin.y = 0;
    thumbRect.size.height = bounds.size.height;
    return thumbRect;
}

- (CGRect)minimumValueImageRectForBounds:(CGRect)bounds {
    return CGRectZero;
}

- (CGRect)maximumValueImageRectForBounds:(CGRect)bounds {
    return CGRectZero;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
