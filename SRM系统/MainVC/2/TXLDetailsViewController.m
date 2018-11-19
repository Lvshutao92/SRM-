//
//  TXLDetailsViewController.m
//  SRM系统
//
//  Created by 吕书涛 on 2018/11/7.
//  Copyright © 2018 吕书涛. All rights reserved.
//

#import "TXLDetailsViewController.h"

#import "GouTongViewController.h"

#import <MessageUI/MFMailComposeViewController.h>

@interface TXLDetailsViewController ()<MFMessageComposeViewControllerDelegate,MFMailComposeViewControllerDelegate>
{
    UIView *bgview;
    
    UIImageView *topview;
    CGFloat height;
}


@end

@implementation TXLDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor =RGBACOLOR(245, 245, 245, 1);
    
    bgview = [[UIView alloc]initWithFrame:CGRectMake(0, kNavBarHAbove7, SCREEN_WIDTH, 532)];
    bgview.backgroundColor = RGBACOLOR(245, 245, 245, 1);
    [self.view addSubview:bgview];
    
    [self setupview];
    
}



- (void)setupview{
    UIView *headerview = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 340)];
    headerview.backgroundColor = [UIColor whiteColor];
    [bgview addSubview:headerview];
    
    topview = [[UIImageView alloc]initWithFrame:CGRectMake(15, 15, SCREEN_WIDTH-30, 200)];
    //topview.image = [UIImage imageNamed:@"bg"];
    LRViewBorderRadius(topview, 10, 0, [UIColor clearColor]);
    [headerview addSubview:topview];
    
    
    
    CAGradientLayer *_gradientLayer = [CAGradientLayer layer];
    _gradientLayer.bounds = topview.bounds;
    _gradientLayer.borderWidth = 0;
    _gradientLayer.frame = topview.bounds;
    _gradientLayer.colors = [NSArray arrayWithObjects:
                             (id)RGBACOLOR(135, 206, 250, 1.0).CGColor,
                             (id)RGBACOLOR(30, 144, 255, 1.0).CGColor, nil ,nil];
    _gradientLayer.startPoint = CGPointMake(0, 0);
    _gradientLayer.endPoint   = CGPointMake(1.0, 1.0);
    [topview.layer insertSublayer:_gradientLayer atIndex:0];
    
    
    
    
    
    
    
    SQCustomButton *noAbtn = [[SQCustomButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/2-170, 240, 70, 70)
                                             type:SQCustomButtonTopImageType
                                        imageSize:CGSizeMake(50, 50) midmargin:10];
    noAbtn.isShowSelectBackgroudColor = NO;
    noAbtn.imageView.image = [UIImage imageNamed:@"daDH"];
    noAbtn.titleLabel.text = @"打电话";
    noAbtn.titleLabel.font = [UIFont systemFontOfSize:16];
    noAbtn.titleLabel.textColor = RGBACOLOR(18, 150, 219, 1);
    [headerview addSubview:noAbtn];
    [noAbtn touchAction:^(SQCustomButton * _Nonnull button) {
        NSMutableString *str =[[NSMutableString alloc]initWithFormat:@"tel:%@",self.model.mobile];
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
    }];
   
    SQCustomButton *noAbtn1 = [[SQCustomButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/2-80, 240, 70, 70)
                                                             type:SQCustomButtonTopImageType
                                                        imageSize:CGSizeMake(50, 50) midmargin:10];
    noAbtn1.isShowSelectBackgroudColor = NO;
    noAbtn1.imageView.image = [UIImage imageNamed:@"faDX"];
    noAbtn1.titleLabel.text = @"发短信";
    noAbtn1.titleLabel.font = [UIFont systemFontOfSize:16];
    noAbtn1.titleLabel.textColor = RGBACOLOR(18, 150, 219, 1);
    [headerview addSubview:noAbtn1];
    [noAbtn1 touchAction:^(SQCustomButton * _Nonnull button) {
        MFMessageComposeViewController *vc = [[MFMessageComposeViewController alloc] init];
        vc.recipients = @[self.model.mobile];  
        vc.messageComposeDelegate = self;
        [self presentViewController:vc animated:YES completion:nil];
    }];
    
    SQCustomButton *noAbtn2 = [[SQCustomButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/2+10, 240, 70, 70)
                                                              type:SQCustomButtonTopImageType
                                                         imageSize:CGSizeMake(50, 50) midmargin:10];
    noAbtn2.isShowSelectBackgroudColor = NO;
    noAbtn2.imageView.image = [UIImage imageNamed:@"faYJ"];
    noAbtn2.titleLabel.text = @"发邮件";
    noAbtn2.titleLabel.font = [UIFont systemFontOfSize:16];
    noAbtn2.titleLabel.textColor = RGBACOLOR(18, 150, 219, 1);
    [headerview addSubview:noAbtn2];
    [noAbtn2 touchAction:^(SQCustomButton * _Nonnull button) {
        NSString *mailStr = [NSString stringWithFormat:@"mailto://%@",self.model.email];
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:mailStr]];
    }];
    
    
    
    
    SQCustomButton *noAbtn3 = [[SQCustomButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/2+100, 240, 70, 70)
                                                             type:SQCustomButtonTopImageType
                                                        imageSize:CGSizeMake(50, 50) midmargin:10];
    noAbtn3.isShowSelectBackgroudColor = NO;
    noAbtn3.imageView.image = [UIImage imageNamed:@"gtju"];
    noAbtn3.titleLabel.text = @"沟通记录";
    noAbtn3.titleLabel.font = [UIFont systemFontOfSize:16];
    noAbtn3.titleLabel.textColor = RGBACOLOR(18, 150, 219, 1);
    [headerview addSubview:noAbtn3];
    [noAbtn3 touchAction:^(SQCustomButton * _Nonnull button) {
        GouTongViewController *goutong = [[GouTongViewController alloc]init];
        goutong.title = @"沟通记录";
        goutong.model = self.model;
        [self.navigationController pushViewController:goutong animated:YES];
    }];
    
    
    
    [self setupview1];
    
    [self setupview2];
}







- (void)messageComposeViewController:(MFMessageComposeViewController*)controller didFinishWithResult:(MessageComposeResult)result
{
    // 关闭短信界面
    [controller dismissViewControllerAnimated:YES completion:nil];
    if(result == MessageComposeResultCancelled) {
        //NSLog(@"取消发送");
    } else if(result == MessageComposeResultSent) {
        [self dengdaiupdate:@"发送成功"];
    } else {
        [self dengdaiupdate:@"发送失败"];
    }
}
- (void)dengdaiupdate:(NSString *)str{
    MBProgressHUD *hud= [[MBProgressHUD alloc] initWithView:self.view];
    [hud setRemoveFromSuperViewOnHide:YES];
    hud.label.text =str;
    [hud setMode:MBProgressHUDModeCustomView];
    [self.view addSubview:hud];
    [hud showAnimated:YES];
    [hud hideAnimated:YES afterDelay:1.0];
}






- (void)setupview1{
    UIImageView *imgview = [[UIImageView alloc]initWithFrame:CGRectMake(10, 20, 100, 100)];
    imgview.image = [UIImage imageNamed:@"txa"];
    //imgview.contentMode = UIViewContentModeScaleAspectFit;
    LRViewBorderRadius(imgview, 50, 0, [UIColor clearColor]);
    [topview addSubview:imgview];
    
    UILabel *namelab = [[UILabel alloc]initWithFrame:CGRectMake(140, 10, SCREEN_WIDTH-170, 30)];
    namelab.text = self.model.personName;
    namelab.textColor = [UIColor whiteColor];
    [topview addSubview:namelab];
    
    UILabel *agelab = [[UILabel alloc]initWithFrame:CGRectMake(140, 60, SCREEN_WIDTH-170, 30)];
    if ([self.model.sex isEqualToString:@"M"]) {
        agelab.text = @"性别：男";
    }else{
        agelab.text = @"性别：女";
    }
    agelab.font = FONT(15);
    agelab.textColor = [UIColor whiteColor];
    [topview addSubview:agelab];
    
    
    UILabel *birthdaylab = [[UILabel alloc]initWithFrame:CGRectMake(140, 110, SCREEN_WIDTH-170, 30)];
    birthdaylab.text = [NSString stringWithFormat:@"生日：%@",self.model.birthday];
    birthdaylab.font = FONT(15);
    birthdaylab.textColor = [UIColor whiteColor];
    [topview addSubview:birthdaylab];
    
    UILabel *zhiweilab = [[UILabel alloc]initWithFrame:CGRectMake(140, 160, SCREEN_WIDTH-170, 30)];
    zhiweilab.text = [NSString stringWithFormat:@"职位：%@",self.model.position];
    zhiweilab.font = FONT(15);
    zhiweilab.textColor = [UIColor whiteColor];
    [topview addSubview:zhiweilab];
}

- (void)setupview2{
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 350, SCREEN_WIDTH, 60)];
    view.backgroundColor = [UIColor whiteColor];
    [bgview addSubview:view];
    UILabel *lab1 = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, SCREEN_WIDTH-80, 60)];
    lab1.text = [NSString stringWithFormat:@"线索编号：%@",self.model.leadNo];
    lab1.backgroundColor = [UIColor whiteColor];
    [view addSubview:lab1];
    
    
    
    UIView *view1 = [[UIView alloc]initWithFrame:CGRectMake(0, 411, SCREEN_WIDTH, 60)];
    view1.backgroundColor = [UIColor whiteColor];
    [bgview addSubview:view1];
    UILabel *lab = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, SCREEN_WIDTH-80, 60)];
    lab.text = [NSString stringWithFormat:@"称呼：%@",self.model.nickName];
    lab.backgroundColor = [UIColor whiteColor];
    [view1 addSubview:lab];
    
    
    
    UIView *view2 = [[UIView alloc]initWithFrame:CGRectMake(0, 472, SCREEN_WIDTH, 60)];
    view2.backgroundColor = [UIColor whiteColor];
    [bgview addSubview:view2];
    UILabel *lab2 = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, SCREEN_WIDTH-150, 60)];
    lab2.text = [NSString stringWithFormat:@"微信号：%@",self.model.wechat];
    lab2.backgroundColor = [UIColor whiteColor];
    [view2 addSubview:lab2];
    
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(SCREEN_WIDTH-50, 15, 30, 30);
    [btn setTitle:@"➕" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(clickADdweixin) forControlEvents:UIControlEventTouchUpInside];
    [view2 addSubview:btn];
    
    UIButton *btn1 = [UIButton buttonWithType:UIButtonTypeCustom];
    btn1.frame = CGRectMake(SCREEN_WIDTH-90, 15, 30, 30);
    [btn1 setImage:[UIImage imageNamed:@"fuzhi"] forState:UIControlStateNormal];
    [btn1 addTarget:self action:@selector(clickfuzhi) forControlEvents:UIControlEventTouchUpInside];
    [view2 addSubview:btn1];
    
    
}
- (void)clickADdweixin{
    NSURL *url = [NSURL URLWithString:@"weixin://"];
    BOOL canOpen = [[UIApplication sharedApplication] canOpenURL:url];
    if (canOpen) {
        [[UIApplication sharedApplication] openURL:url];
    }else{
        NSLog(@"未安装微信");
    }
}
- (void)clickfuzhi{
    UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
    pasteboard.string = self.model.wechat;
    
    
    MBProgressHUD *hud= [[MBProgressHUD alloc] initWithView:self.view];
    [hud setRemoveFromSuperViewOnHide:YES];
    hud.label.text =@"复制成功";
    UIImageView *imageview=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"dui"]];
    [hud setCustomView:imageview];
    [hud setMode:MBProgressHUDModeCustomView];
    [self.view addSubview:hud];
    [hud showAnimated:YES];
    [hud hideAnimated:YES afterDelay:1.0];
}


@end
