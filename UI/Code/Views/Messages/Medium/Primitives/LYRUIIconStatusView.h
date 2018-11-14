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

@interface LYRUIIconStatusView : UIView <LYRUIConfigurable>

@property (nonatomic, nullable) LYRUIMessageTypeStatus *status;
@end

NS_ASSUME_NONNULL_END
