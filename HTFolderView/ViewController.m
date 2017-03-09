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
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark UI
-(HTFolderView *)folderView{
    if (!_folderView) {
        _folderView = [[HTFolderView alloc] initWithTitle:@"我的文件夹" dataSoure:@[@"天气",@"生活",@"工作",@"效率",@"娱乐",@"天气1",@"天气2",@"天气3",@"天气4"] style:HTEffectStyleDark];
        _folderView.HTBlock = ^(NSInteger index){
            //do something
        };
    }
    
    return _folderView;
}
@end
