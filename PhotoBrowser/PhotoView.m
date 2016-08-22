//
//  PhotoView.m
//  PhotoBrowser
//
//  Created by 李震 on 16/8/22.
//  Copyright © 2016年 lizhen. All rights reserved.
//

#import "PhotoView.h"
#import "UIImageView+WebCache.h"
#import "UIView+Extension.h"

@interface PhotoView ()

@property (nonatomic, weak) UIImageView *gifView;

@end

@implementation PhotoView

- (void)setPhoto:(NSString *)photo {
    _photo = photo;
    // 赋值
    [self sd_setImageWithURL:[NSURL URLWithString:_photo] placeholderImage:[UIImage imageNamed:@"timeline_image_placeholder"]];
    // 判断下是否显示gif
    NSString *urlStr = _photo;
    if ([urlStr hasSuffix:@".gif"]) {
        self.gifView.hidden = NO;
    }else{
        self.gifView.hidden = YES;
    }
}

// 对.gif标示图片进行布局
- (void)layoutSubviews {
    [super layoutSubviews];
    self.gifView.x = self.width - self.gifView.width;
    self.gifView.y = self.height - self.gifView.height;
}

#pragma mark - 1、初始化控件------
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        // 允许用户进行交互
        self.userInteractionEnabled = YES;
        // 图片不缩放，并放满容器
        self.contentMode = UIViewContentModeScaleAspectFill;
        // 裁剪图片，超出控件的部分裁剪掉
        self.clipsToBounds = YES;
        UIImageView *gifView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"timeline_image_gif"]];
        [self addSubview:gifView];
        _gifView = gifView;
    }
    return self;
}




/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
