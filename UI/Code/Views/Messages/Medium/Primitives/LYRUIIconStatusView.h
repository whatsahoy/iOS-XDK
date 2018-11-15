//
//  LYRUIIconStatusView.h
//  Pods
//
//  Created by Mike Hernas on 14/11/2018.
//

#import <UIKit/UIKit.h>
#import "LYRUIMessageTypeStatus.h"
#import "LYRUIConfigurable.h"

NS_ASSUME_NONNULL_BEGIN

@class LYRUIMessageType;
@interface LYRUIIconStatusView : UIView <LYRUIConfigurable>

- (void)configureWithMessage:(LYRUIMessageType *)message;

@end

NS_ASSUME_NONNULL_END
