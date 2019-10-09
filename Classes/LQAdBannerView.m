//
//  LQAdBannerView.m
//  TheZodiac
//
//  Created by robin on 2019/8/19.
//  Copyright © 2019 LQ. All rights reserved.
//

#import "LQAdBannerView.h"
#import <GoogleMobileAds/GADBannerView.h>

@interface LQAdBannerView ()<GADBannerViewDelegate>

@property (nonatomic, strong) GADBannerView *adBanner;
@property (nonatomic, weak, nullable)  UIViewController *rootViewController;
@property (strong, nonatomic) UIImageView *imageView;        

@end

@implementation LQAdBannerView

+(instancetype)rootViewController:(UIViewController *)rootViewController height:(CGFloat)height
{
    LQAdBannerView *view = [[LQAdBannerView alloc] initRootViewController:rootViewController height:height];
    [rootViewController.view addSubview:view];
    [view setFrame:CGRectMake(0, CGRectGetHeight(rootViewController.view.bounds)/2.0 - height, CGRectGetWidth(rootViewController.view.bounds),height)];
    return view;
}

-(instancetype)initRootViewController:(UIViewController *)rootViewController height:(CGFloat)height
{
    if (self = [super init]) {
        self.rootViewController = rootViewController;
        CGRect frame = self.frame;
        frame.size.height = height;
        self.frame = frame;
        [self addSubview:self.imageView];
        [self addSubview:self.adBanner];
    }
    return self;
}


- (void)layoutSubviews {
    [super layoutSubviews];
    [self.adBanner setFrame:self.bounds];
    [self.imageView setFrame:self.bounds];
}

- (NSString *)GoodAdUnitID {
    NSString *result = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"GoodAdUnitID"];
    return result;
}

-(UIImageView *)imageView
{
    if(!_imageView){
        _imageView = [[UIImageView alloc] initWithFrame:self.bounds];
        [_imageView setContentMode:UIViewContentModeScaleAspectFill];
    }
    return _imageView;
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

#pragma mark -- GADBannerViewDelegate
- (void)adViewDidReceiveAd:(nonnull GADBannerView *)bannerView{
    [self.imageView setHidden:YES];
}


@end
