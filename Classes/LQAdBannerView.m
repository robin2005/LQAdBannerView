//
//  LQAdBannerView.m
//  TheZodiac
//
//  Created by robin on 2019/8/19.
//  Copyright © 2019 LQ. All rights reserved.
//

#import "LQAdBannerView.h"
#import "ZKCycleScrollView.h"
#import <GoogleMobileAds/GADBannerView.h>



@interface LQAdBannerView ()<ZKCycleScrollViewDelegate, ZKCycleScrollViewDataSource,GADBannerViewDelegate>

@property (nonatomic, strong) ZKCycleScrollView *googleBanner;
@property (nonatomic, strong) GADBannerView *adBanner;
@property (nonatomic, weak, nullable)  UIViewController *rootViewController;
@property (weak, nonatomic) UIImageView *imageView;       // The photo / 照片

@end

@implementation LQAdBannerView

-(instancetype)initRootViewController:(UIViewController *)rootViewController height:(CGFloat)height
{
    if (self = [super init]) {
        self.rootViewController = rootViewController;
        [self setHeight:height];
        [self addSubview:self.googleBanner];
    }
    return self;
}

-(ZKCycleScrollView *)googleBanner{
    if (!_googleBanner) {
        _googleBanner = [[ZKCycleScrollView alloc] initWithFrame:CGRectMake(0.f, 0.f, kScreenWidth, self.height)];
        _googleBanner.delegate = self;
        _googleBanner.dataSource = self;
        _googleBanner.itemSpacing = 0;
        _googleBanner.pageIndicatorTintColor = [[UIColor whiteColor] colorWithAlphaComponent:0.6];;
        _googleBanner.itemSize = CGSizeMake(kScreenWidth, self.height);
        [_googleBanner registerCellClass:[ZKCycleScrollViewCell class] forCellWithReuseIdentifier:@"ZKCycleScrollViewCell"];
        [self addSubview:_googleBanner];
    }
    return _googleBanner;
}
//App名字
- (NSString *)GoodAdUnitID {
    NSString *result = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"GoodAdUnitID"];
    return result;
}


-(GADBannerView *)adBanner
{
    if(!_adBanner){
        CGPoint origin = CGPointMake(0.0, 0.0);
        _adBanner = [[GADBannerView alloc] initWithAdSize:kGADAdSizeBanner origin:origin];
        _adBanner.adUnitID = [self GoodAdUnitID] ;
        _adBanner.delegate = self;
        [_adBanner setRootViewController:self.rootViewController];
        [_adBanner loadRequest: [GADRequest request]];
    }
    return _adBanner;
}

#pragma mark -- ZKCycleScrollView DataSource
- (NSInteger)numberOfItemsInCycleScrollView:(ZKCycleScrollView *)cycleScrollView {
    return 1;
}

- (__kindof ZKCycleScrollViewCell *)cycleScrollView:(ZKCycleScrollView *)cycleScrollView cellForItemAtIndex:(NSInteger)index {
    ZKCycleScrollViewCell *cell = [cycleScrollView dequeueReusableCellWithReuseIdentifier:@"ZKCycleScrollViewCell" forIndex:index];
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:cycleScrollView.bounds];
    [cell removeAllSubviews];
    [cell addSubview:imageView];
    [imageView setContentMode:UIViewContentModeScaleAspectFill];
    [imageView setImage:LQAppImageNamed(@"banner")];
    [cell addSubview:self.adBanner];
    [self.adBanner setFrame:cycleScrollView.bounds];
    [self.adBanner mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.adBanner.superview);
        make.left.mas_equalTo(self.adBanner.superview);
        make.width.mas_equalTo(kScreenWidth);
        make.height.mas_equalTo(self.height);
    }];
    self.imageView = imageView;
    return cell;
}

#pragma mark -- GADBannerViewDelegate
- (void)adViewDidReceiveAd:(nonnull GADBannerView *)bannerView{
    [self.imageView setHidden:YES];
}


@end
