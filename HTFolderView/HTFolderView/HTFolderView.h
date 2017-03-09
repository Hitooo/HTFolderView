//
//  FolderView.h
//  fhln2
//
//  Created by net on 15/7/24.
//  Copyright (c) 2015年 Hitoo. All rights reserved.
//

#import <UIKit/UIKit.h>

//文件夹的主题
typedef NS_ENUM(NSInteger, HTEffectStyle) {
    
    HTEffectStyleDark = 0,
    HTEffectStyleLight
};

@interface HTFolderCollectionCell : UICollectionViewCell

@property (nonatomic, copy) UIImageView *headImgView;
@property (nonatomic, copy) UILabel *titleLab;

@end

@protocol HTFolderViewDelegate <NSObject>
@required
- (void)didSelectItem:(NSInteger)itemIndex;

@end

@interface HTFolderView : UIView

@property (nonatomic,copy) UIView *backgroundView;
@property (nonatomic,copy) UIView *folderView;
@property (nonatomic,copy) UILabel *folderTitle;
@property (nonatomic, weak) id<HTFolderViewDelegate> delegate;
@property (nonatomic,copy) NSArray *datasource;

@property (copy, nonatomic) void(^HTBlock)(NSInteger index);

- (id)initWithTitle:(NSString *)title dataSoure:(NSArray *)arr style:(HTEffectStyle)style;

- (void)showAnimation;
- (void)hideAnimation;

@end
