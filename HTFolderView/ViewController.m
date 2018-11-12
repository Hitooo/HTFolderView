//
//  ViewController.m
//  HTFolderView
//
//  Created by zhanghaitao on 2017/3/7.
//  Copyright © 2017年 zhanghaitao. All rights reserved.
//

#import "ViewController.h"
#import "HTFolderView.h"

@interface ViewController ()

@property (nonatomic,copy) HTFolderView *folderView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
    btn.titleLabel.font = [UIFont systemFontOfSize:18];
    [btn setTitle:@"Touch Me" forState:0];
    btn.backgroundColor = [UIColor orangeColor];
    [btn addTarget:self action:@selector(didClickBtn:) forControlEvents:(UIControlEventTouchUpInside)];
    btn.frame = CGRectMake(50, 50, 100, 60);
    [self.view addSubview:btn];
}

- (void)didClickBtn:(UIButton *)sender{
    
    _folderView = nil;
    [self.folderView showAnimation];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark UI
-(HTFolderView *)folderView{
    if (!_folderView) {
        _folderView = [[HTFolderView alloc] initWithTitle:@"我的文件夹" dataSoure:@[@"item",@"item",@"item",@"item",@"item",@"item",@"item",@"item",@"item"] style:HTEffectStyleDark];
        _folderView.HTBlock = ^(NSInteger index){
            //do something
        };
    }
    
    return _folderView;
}
@end
