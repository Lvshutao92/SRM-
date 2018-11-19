//
//  XianSuoDetails_One_ViewController.m
//  SRM系统
//
//  Created by 吕书涛 on 2018/11/15.
//  Copyright © 2018 吕书涛. All rights reserved.
//

#import "XianSuoDetails_One_ViewController.h"
#import "XianSuoDetails_Two_ViewController.h"

@interface XianSuoDetails_One_ViewController ()



@property(nonatomic,strong)UISegmentedControl *segmentedControl;
@property(nonatomic,strong)XianSuoDetails_Two_ViewController *twoVC;
@end

@implementation XianSuoDetails_One_ViewController

//按钮点击事件
-(void)segmentValueChanged:(UISegmentedControl *)seg{
    switch (seg.selectedSegmentIndex) {
        case 0:
            [self.twoVC.view removeFromSuperview];
            [self.twoVC removeFromParentViewController];
            break;
        case 1:
            [self addChildViewController:self.twoVC];
            [self.view addSubview:self.twoVC.view];
            
            break;
        default:
            break;
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"";
    self.twoVC = [[XianSuoDetails_Two_ViewController alloc]init];
    
    NSArray * _titles = @[@"联系人", @"沟通记录"];
    _segmentedControl = [[UISegmentedControl alloc] initWithItems:_titles];
    _segmentedControl.selectedSegmentIndex = 0;
    _segmentedControl.tintColor = [UIColor whiteColor];
    [_segmentedControl addTarget:self action:@selector(segmentValueChanged:) forControlEvents:UIControlEventValueChanged];
    _segmentedControl.frame = CGRectMake(0.0, 0.0, 200.0, 29.0);
    self.navigationItem.titleView = _segmentedControl;
    
    // Do any additional setup after loading the view.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
