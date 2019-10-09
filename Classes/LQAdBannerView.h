//
//  LQAdBannerView.h
//  TheZodiac
//
//  Created by robin on 2019/8/19.
//  Copyright © 2019 LQ. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface LQAdBannerView : UIView

-(instancetype)initRootViewController:(UIViewController *)rootViewController height:(CGFloat)height;
+(instancetype)rootViewController:(UIViewController *)rootViewController height:(CGFloat)height;

@end

NS_ASSUME_NONNULL_END
