//
//  ViewController.m
//  PhotoBrowser
//
//  Created by 李震 on 16/8/22.
//  Copyright © 2016年 lizhen. All rights reserved.
//

#import "ViewController.h"
#import "PhotoGrid.h"
#import "MWPhotoBrowser.h"

@interface ViewController ()<PhotoGridDelegate,MWPhotoBrowserDelegate>

@property (nonatomic,weak)PhotoGrid * photosView;

@property (nonatomic,strong)NSArray * picUrls;

@property (nonatomic,strong)NSMutableArray * selections;

@property (nonatomic,strong)NSMutableArray * photos;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    _picUrls = @[@"http://c.hiphotos.bdimg.com/album/w%3D2048/sign=10a72dd37af40ad115e4c0e3631413df/f7246b600c338744f1243597500fd9f9d62aa073.jpg",
                 @"http://pic23.nipic.com/20120901/7341593_111221480000_2.jpg",
                 @"http://www.4j4j.cn/upload/pic/20121031/261e39e216.jpg",
                 @"http://www.bz55.com/uploads/allimg/140403/137-140403145U3.jpg",
                 @"http://a2.att.hudong.com/21/96/300000944056128089967362411_950.jpg",
                 @"http://pic25.nipic.com/20121205/5955207_182136452000_2.jpg",
                 @"http://img3.redocn.com/tupian/20151014/weimeikatongdongmantu_5095808.jpg",
                 @"http://img.pconline.com.cn/images/upload/upc/tx/wallpaper/1307/30/c0/23934263_1375169304679.jpg",
                 @"http://att2.citysbs.com/fz/bbs_attachments/2010/month_1002/middle_1002031225cd908311aa3f2124.jpg"
                 ];
    /*
     需要数据源：是 MWPhoto类 的数组。
     
     + (MWPhoto *)photoWithImage:(UIImage *)image;// 本地图片
     + (MWPhoto *)photoWithURL:(NSURL *)url;// URL 图片
     + (MWPhoto *)photoWithAsset:(PHAsset *)asset targetSize:(CGSize)targetSize;// 照片
     + (MWPhoto *)videoWithURL:(NSURL *)url; // 视频
     
     @property (nonatomic, strong) NSString *caption;// 描述
     
     @property (nonatomic, strong) NSURL *videoURL;
     @property (nonatomic) BOOL emptyImage;
     @property (nonatomic) BOOL isVideo;
     */
    
    MWPhoto * photo;
    _photos = [NSMutableArray new];
    for (NSString * urlStr in _picUrls) {
        photo = [MWPhoto photoWithURL:[NSURL URLWithString:urlStr]];
        [_photos addObject:photo];
    }
    
    
    PhotoGrid *photosView = [[PhotoGrid alloc] init];
    [self.view addSubview:photosView];
    _photosView = photosView;
    _photosView.delegate = self;
    
    _photosView.picUrls = _picUrls;
    
    CGFloat photosX = 10;
    CGFloat photosY = 100;
    CGSize photosSize = [self photosSizeWithCount:(int)_picUrls.count];
    _photosView.frame = (CGRect){{photosX,photosY},photosSize};
    _photosView.backgroundColor = [UIColor grayColor];
    
    
}

- (CGSize)photosSizeWithCount:(int)count
{
    // 获取总列数
    int cols = count == 4 ? 2 : 3;
    // 获取总行数 = (总个数 - 1) / 总列数 + 1
    int rols = (count - 1) / cols + 1;
    CGFloat photoWH = 100;
    CGFloat w = cols * photoWH + (cols - 1) * 10;
    CGFloat h = rols * photoWH + (rols - 1) * 10;
    return CGSizeMake(w, h);
}

#pragma mark Photodelegate
- (void)transmit:(UITapGestureRecognizer *)tap{
    
    
    UIImageView *tapView = (UIImageView *)tap.view;
    
    
    /*
     初始化方法
     - (id)initWithPhotos:(NSArray *)photosArray;// 不需要代理，直接使用预览，简单方便
     - (id)initWithDelegate:(id <MWPhotoBrowserDelegate>)delegate;// 代理方法更多
    */
     
    MWPhotoBrowser *browser = [[MWPhotoBrowser alloc] initWithDelegate:self];
    
    /*
     - (void)reloadData;// 重新加载
     - (void)setCurrentPhotoIndex:(NSUInteger)index;// 默认选中
     */
    [browser setCurrentPhotoIndex:tapView.tag];
    
    /*
     包含属性
     
     @property (nonatomic) BOOL displayNavArrows;// toolBar 上的 左右翻页 ，默认 NO
     @property (nonatomic) BOOL displayActionButton;// 系统分享
     @property (nonatomic) BOOL alwaysShowControls;// 是否一直显示 导航栏
     
     @property (nonatomic) BOOL displaySelectionButtons;// 选择图片
     @property (nonatomic, strong) NSString *customImageSelectedIconName;// 选择大图
     @property (nonatomic, strong) NSString *customImageSelectedSmallIconName;// 选择小图
     
     @property (nonatomic) BOOL enableGrid;// 是否可以查看小图预览模式
     @property (nonatomic) BOOL startOnGrid;// 以小图预览模式进入
     
     @property (nonatomic) BOOL autoPlayOnAppear;// 自动播放视频
     @property (nonatomic) NSUInteger delayToHideElements;// 延迟 隐藏时间
     @property (nonatomic) BOOL zoomPhotosToFill;//
     
     @property (nonatomic, readonly) NSUInteger currentIndex;// 当前位置
     */
    
    browser.displayActionButton = NO;
    browser.enableGrid = NO;
    
    
    // push 显示！
    [self.navigationController pushViewController:browser animated:YES];
    
}

#pragma mark  MWPhotoBrowserDelegate

//数量
- (NSUInteger)numberOfPhotosInPhotoBrowser:(MWPhotoBrowser *)photoBrowser {
    return _photos.count;
}

// 内容
- (id <MWPhoto>)photoBrowser:(MWPhotoBrowser *)photoBrowser photoAtIndex:(NSUInteger)index {
    if (index < _photos.count)
        return [_photos objectAtIndex:index];
    return nil;
}

// 网格视图
- (id <MWPhoto>)photoBrowser:(MWPhotoBrowser *)photoBrowser thumbPhotoAtIndex:(NSUInteger)index {
    if (index < _photos.count)
        return [_photos objectAtIndex:index];
    return nil;
}

// nav title
//- (NSString *)photoBrowser:(MWPhotoBrowser *)photoBrowser titleForPhotoAtIndex:(NSUInteger)index {
//    return @"123";
//}

// 已经 显示
- (void)photoBrowser:(MWPhotoBrowser *)photoBrowser didDisplayPhotoAtIndex:(NSUInteger)index {
    NSLog(@"%zi",index);
}

// 是否选中，需要结合属性设置，同时使用 NSNumber 的数组
- (BOOL)photoBrowser:(MWPhotoBrowser *)photoBrowser isPhotoSelectedAtIndex:(NSUInteger)index {
    return [[_selections objectAtIndex:index] boolValue];
}

// 选择某个
- (void)photoBrowser:(MWPhotoBrowser *)photoBrowser photoAtIndex:(NSUInteger)index selectedChanged:(BOOL)selected {
    [_selections replaceObjectAtIndex:index withObject:[NSNumber numberWithBool:selected]];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
