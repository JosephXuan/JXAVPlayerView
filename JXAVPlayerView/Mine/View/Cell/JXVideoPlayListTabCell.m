//
//  JXVideoPlayListTabCell.m
//  JXAVPlayerView
//
//  Created by JosephXuan on 2019/10/21.
//  Copyright © 2019 JosephXuan. All rights reserved.
//

#import "JXVideoPlayListTabCell.h"

#import "JXAVPlayerView+publicHeader.h"//头文件
@interface JXVideoPlayListTabCell ()

@property(nonatomic,strong)UILabel * titleLab;

@end

@implementation JXVideoPlayListTabCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
/** 快速创建Cell */
+ (instancetype)cellWithTableView:(UITableView *)tableView withIdentifier:(NSString *)cellIdentifier indexPath:(NSIndexPath *)indexPath{
    //static NSString *homeHoldLifeCellID=@"HomeHoldLifeCellID";
    
    JXVideoPlayListTabCell *cell=[tableView dequeueReusableCellWithIdentifier:playCellID forIndexPath:indexPath];
    /*
     cell.opaque=YES;
     cell.layer.drawsAsynchronously=YES;
     cell.layer.rasterizationScale=[UIScreen mainScreen].scale;
     */
    return cell;
}

/* 自定义Cell */
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self =[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self){
        [self setUpView];
        //
        self.contentView.backgroundColor=[UIColor whiteColor];
    }
    return self;
}

-(void)setUpView{
    
    [self.contentView addSubview:self.titleLab];
    [self.titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(10);
        make.centerY.equalTo(self.contentView.mas_centerY);
    }];
    
}

-(void)setListModel:(JXVideoPlayListModel *)listModel{
    _listModel = listModel;
    
    
}

+(CGFloat)returnHeightWithPlayModel:(JXVideoPlayListModel *)playModel{
    return 43;
}

-(UILabel *)titleLab{
    if (!_titleLab) {
        _titleLab = [[UILabel alloc]init];
    }
    return _titleLab;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
