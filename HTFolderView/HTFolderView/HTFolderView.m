//
//  FolderView.m
//  fhln2
//
//  Created by net on 15/7/24.
//  Copyright (c) 2015年 Hitoo. All rights reserved.
//

#define HT_SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define HT_SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)
#define FolderOutMargin 40
#define FolderInnerMargin 16
#define HT_COLOR(R, G, B, A) [UIColor colorWithRed:R/255.0 green:G/255.0 blue:B/255.0 alpha:A]// 设置颜色RGB
#define HT_BG_COLOR [UIColor groupTableViewBackgroundColor]
#define HT_TEXT_BLACKCOLOR HT_COLOR(40, 40, 40, 1)//一级标题字体颜色
#define HT_TEXT_DARKCOLOR HT_COLOR(101, 101, 101, 1)//二级标题字体颜色
#define HT_IMAGENAME(name) [UIImage imageNamed:name]//定义UIImage对象

#import "HTFolderView.h"

@implementation HTFolderCollectionCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self.contentView addSubview:self.headImgView];
        [self.contentView addSubview:self.titleLab];
    }
    return self;
}


-(UIImageView *)headImgView{
    if (!_headImgView) {
        _headImgView = [[UIImageView alloc] initWithFrame:CGRectMake((self.bounds.size.width-52)/2, 5, 52, 52)];
    }
    return _headImgView;
}

-(UILabel *)titleLab{
    if (!_titleLab) {
        _titleLab = [[UILabel alloc] initWithFrame:CGRectMake(2, 57, self.bounds.size.width-4, self.bounds.size.height-57)];
        _titleLab.textColor = [UIColor whiteColor];
        _titleLab.font = [UIFont systemFontOfSize:14];
        _titleLab.textAlignment = NSTextAlignmentCenter;
        _titleLab.lineBreakMode = NSLineBreakByTruncatingTail;
        _titleLab.numberOfLines = 0;
//        _titleLab.adjustsFontSizeToFitWidth = YES;
    }
    return _titleLab;
}
@end

@interface HTFolderView()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
{
}
@property (nonatomic,strong) UICollectionView *collectionView;
@property (nonatomic) HTEffectStyle folderStyle;

@end

@implementation HTFolderView

- (id)initWithTitle:(NSString *)title dataSoure:(NSArray *)arr style:(HTEffectStyle)style{
    
    return [self initWithTitle:title dataSoure:arr withImageArr:nil style:style];
}

- (id)initWithTitle:(NSString *)title dataSoure:(NSArray *)arr withImageArr:(NSArray *)imagearr style:(HTEffectStyle)style{
    
    self = [super initWithFrame:CGRectMake(0, 0, HT_SCREEN_WIDTH, HT_SCREEN_HEIGHT)];
    if (self)
    {
        self.datasource = arr;
        self.imageArr = imagearr;
        self.folderStyle = style;
        self.folderTitle.text = title;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideAnimation)];
        [self.backgroundView addGestureRecognizer:tap];
        
        [[[UIApplication sharedApplication] keyWindow] addSubview:self];
    }
    return self;
}

#pragma mark - Action

-(CGFloat)getHeightOfItem{
    
    NSInteger height = [self getWidthOfItem];
    
    if (height-57<16) {
        height = height + 16;
    }
    
    return height;
}

-(CGFloat)getWidthOfItem{
    
    CGFloat widthOfItem = ([self getWidthOfFolder] - 2*FolderInnerMargin-2*1)/3;
    return widthOfItem;
}

-(CGFloat)getHeightOfFolder{
    return FolderInnerMargin + [self getRowsOfFolder]*([self getHeightOfItem] + FolderInnerMargin);
}

-(CGFloat)getWidthOfFolder{
    
    return HT_SCREEN_WIDTH - 2*FolderOutMargin;
}

-(NSInteger)getRowsOfFolder{
    
    NSInteger addNum = self.datasource.count%3 == 0?0:1;
    NSInteger heightNum = self.datasource.count/3 + addNum;
    
    if (heightNum <= 0) {
        heightNum = 1;
    }
    else if (heightNum>3){
        heightNum = 3;
    }
    return heightNum;
}

#pragma mark - UI
- (UIView *)folderView
{
    if (!_folderView)
    {
        if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0){
            
            UIBlurEffectStyle style = self.folderStyle == HTEffectStyleLight?UIBlurEffectStyleExtraLight:UIBlurEffectStyleDark;
            _folderView = [[UIVisualEffectView alloc] initWithEffect:[UIBlurEffect effectWithStyle:style]];
        }
        else{
            _folderView = [[UIView alloc] init];
        }
        
        _folderView.frame = CGRectMake(FolderOutMargin, (HT_SCREEN_HEIGHT-[self getHeightOfFolder])/2, [self getWidthOfFolder], [self getHeightOfFolder]);
        _folderView.layer.cornerRadius = 30;
        _folderView.layer.masksToBounds = YES;
        [self addSubview:_folderView];
    }
    
    _folderView.tag = 999;
    return _folderView;
}

- (UILabel *)folderTitle
{
    if (!_folderTitle)
    {
        _folderTitle = [[UILabel alloc] initWithFrame:CGRectMake(0, ((HT_SCREEN_HEIGHT-[self getHeightOfFolder])/2-37)/2, HT_SCREEN_WIDTH, 37)];
        _folderTitle.textAlignment = NSTextAlignmentCenter;
        
        _folderTitle.textColor = self.folderStyle == HTEffectStyleLight?HT_BG_COLOR:HT_TEXT_DARKCOLOR;
        _folderTitle.font = [UIFont systemFontOfSize:35];
        _folderTitle.backgroundColor = [UIColor clearColor];

        if([self.backgroundView isKindOfClass:[UIVisualEffectView class]]){
            UIVisualEffectView *view = (UIVisualEffectView *)self.backgroundView;
            [view.contentView addSubview:_folderTitle];
        }
        else{
            [self.backgroundView addSubview:_folderTitle];
        }
    }
    return _folderTitle;
}

- (UIView *)backgroundView
{
    if (!_backgroundView)
    {
        if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0){
            
            UIBlurEffectStyle style = self.folderStyle == HTEffectStyleLight?UIBlurEffectStyleDark:UIBlurEffectStyleLight;
            _backgroundView = [[UIVisualEffectView alloc] initWithEffect:[UIBlurEffect effectWithStyle:style]];
        }
        else{
           _backgroundView = [[UIView alloc] init];
        }
        
        _backgroundView.frame = CGRectMake(0, 0, HT_SCREEN_WIDTH, HT_SCREEN_HEIGHT);

        [self addSubview:_backgroundView];
    }
    return _backgroundView;
}

-(UICollectionView *)collectionView{
    if (!_collectionView) {
        
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        flowLayout.minimumInteritemSpacing = 1;
        flowLayout.minimumLineSpacing = FolderInnerMargin;
        flowLayout.sectionInset = UIEdgeInsetsMake(FolderInnerMargin, FolderInnerMargin, FolderInnerMargin, FolderInnerMargin);
        flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
        flowLayout.itemSize = CGSizeMake([self getWidthOfItem], [self getHeightOfItem]);
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0,[self getWidthOfFolder],[self getHeightOfFolder]) collectionViewLayout:flowLayout];
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
        _collectionView.backgroundColor = [UIColor clearColor];
        _collectionView.pagingEnabled = NO;
        _collectionView.indicatorStyle = self.folderStyle == HTEffectStyleLight?UIScrollViewIndicatorStyleBlack:UIScrollViewIndicatorStyleWhite;
        [_collectionView registerClass:[HTFolderCollectionCell class] forCellWithReuseIdentifier:@"cell"];
        
        if ([self.folderView isKindOfClass:[UIVisualEffectView class]]) {
            UIVisualEffectView *view = (UIVisualEffectView *)self.folderView;
            [view.contentView addSubview:_collectionView];
        }else{
            [self.folderView addSubview:_collectionView];
        }
    }
    
    return _collectionView;
}


#pragma mark <UICollectionViewDataSource>

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.datasource.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    HTFolderCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    
    cell.headImgView.image = self.imageArr.count>0?HT_IMAGENAME(self.imageArr[indexPath.row]):HT_IMAGENAME(self.datasource[indexPath.row]);
    cell.titleLab.text = self.datasource[indexPath.row];
    cell.headImgView.contentMode = UIViewContentModeScaleAspectFill;
    
    cell.titleLab.textColor = self.folderStyle == HTEffectStyleLight?HT_TEXT_DARKCOLOR:[UIColor whiteColor];

    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    [UIView animateWithDuration:0.25 delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
        self.frame = CGRectMake(-CGRectGetWidth(self.bounds), 0, self.bounds.size.width, self.bounds.size.height);
    } completion:^(BOOL finished2) {
        [self removeFromSuperview];
    }];
    
    if(self.delegate&&[self.delegate respondsToSelector:@selector(didSelectItem:)]){
        [self.delegate didSelectItem:indexPath.row];
    }
    
    if (self.HTBlock) {
        self.HTBlock(indexPath.row);
    }
}

-(BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    return YES;
}

#pragma mark - 动画
- (void)showAnimation
{
    self.folderView.alpha = 0;
    [self.collectionView reloadData];
    
    CGFloat d1 = 0.2, d2 = 0.15;
    self.folderView.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.4, 0.4);
    [UIView animateWithDuration:d1 animations:^{
        self.folderView.alpha = 1;
        self.folderView.transform = CGAffineTransformScale(CGAffineTransformIdentity, 1.1, 1.1);
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:d2 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
            self.folderView.alpha = 1;
            self.folderView.transform = CGAffineTransformScale(CGAffineTransformIdentity, 1, 1);
        } completion:^(BOOL finished2) {
        }];
    }];
    
}

- (void)hideAnimation
{
    CGFloat d1 = 0.2, d2 = 0.1;
    [UIView animateWithDuration:d2 animations:^{
        self.folderView.transform = CGAffineTransformScale(CGAffineTransformIdentity, 1.1, 1.1);
    } completion:^(BOOL finished){
        [UIView animateWithDuration:d1 delay:0 options:UIViewAnimationOptionTransitionFlipFromRight animations:^{
            self.folderView.alpha = 0;
            self.folderView.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.4, 0.4);
        } completion:^(BOOL finished2){
            
            [self removeFromSuperview];
        }];
    }];
}

@end
