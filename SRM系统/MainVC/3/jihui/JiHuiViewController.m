//
//  JiHuiViewController.m
//  SRM系统
//
//  Created by 吕书涛 on 2018/11/12.
//  Copyright © 2018 吕书涛. All rights reserved.
//

#import "JiHuiViewController.h"

@interface JiHuiViewController ()


@property(nonatomic,strong)UISegmentedControl *segmentedControl;


@end

@implementation JiHuiViewController

- (void)clickback{
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIView *btnview = [[UIView alloc]initWithFrame:CGRectMake(0, kStatusBarHeight, 44, 44)];
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(5, 7, 30, 30);
    [btn setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    [btnview addSubview:btn];
    [btn addTarget:self action:@selector(clickback) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *bar = [[UIBarButtonItem alloc]initWithCustomView:btnview];
    self.navigationItem.leftBarButtonItem = bar;
    
    NSArray * _titles = @[@"有效机会", @"无效机会",@"报价申请",@"报价审核"];
    _segmentedControl = [[UISegmentedControl alloc] initWithItems:_titles];
    _segmentedControl.selectedSegmentIndex = 0;
    _segmentedControl.tintColor = [UIColor whiteColor];
    //[_segmentedControl addTarget:self action:@selector(segmentValueChanged:) forControlEvents:UIControlEventValueChanged];
    _segmentedControl.frame = CGRectMake(0.0, 0.0, 200.0, 29.0);
    self.navigationItem.titleView = _segmentedControl;
}













@end
