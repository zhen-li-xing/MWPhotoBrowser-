//
//  PhotoGrid.h
//  PhotoBrowser
//
//  Created by 李震 on 16/8/22.
//  Copyright © 2016年 lizhen. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol PhotoGridDelegate <NSObject>

- (void)transmit:(UITapGestureRecognizer *)tap;

@end

@interface PhotoGrid : UIView

@property (nonatomic, strong) NSArray * picUrls;

@property (nonatomic, weak)id<PhotoGridDelegate>delegate;

@end
