//
//  B_TableViewCell.m
//  SRM系统
//
//  Created by 吕书涛 on 2018/11/7.
//  Copyright © 2018 吕书涛. All rights reserved.
//

#import "B_TableViewCell.h"

@implementation B_TableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}






//重写初始化方法，在初始化同时将子控件添加到cell上显示；
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        //创建联系人姓名Lable对象
        self.nameLable = [[UILabel alloc]initWithFrame:CGRectMake(10, 10, 160, 20)];
        self.nameLable.adjustsFontSizeToFitWidth = YES;
        self.nameLable.font = FONT(18);
        [self.contentView addSubview:self.nameLable];
        //创建电话号码对象
        self.phoneNumberLable = [[UILabel alloc]initWithFrame:CGRectMake(10, 40, 160, 20)];
        self.phoneNumberLable.adjustsFontSizeToFitWidth = YES;
        self.phoneNumberLable.textColor = [UIColor lightGrayColor];
        self.phoneNumberLable.font = FONT(14);
        [self.contentView addSubview:self.phoneNumberLable];
        //
        self.btn1 = [UIButton buttonWithType:UIButtonTypeCustom];
        self.btn1.frame = CGRectMake(SCREEN_WIDTH-50, 20, 30, 30);
        [self.btn1 setImage:[UIImage imageNamed:@"dh"] forState:UIControlStateNormal];
        [self.contentView addSubview:self.btn1];
        //
        self.btn2 = [UIButton buttonWithType:UIButtonTypeCustom];
        self.btn2.frame = CGRectMake(SCREEN_WIDTH-100, 20, 30, 30);
        [self.btn2 setImage:[UIImage imageNamed:@"dx"] forState:UIControlStateNormal];
        [self.contentView addSubview:self.btn2];
    }
    return self;
}


@end
