//
//  LYRUIMessageItemView.h
//  Layer-XDK-UI-iOS
//
//  Created by Łukasz Przytuła on 11.08.2017.
//  Copyright (c) 2017 Layer. All rights reserved.
//
//  Licensed under the Apache License, Version 2.0 (the "License");
//  you may not use this file except in compliance with the License.
//  You may obtain a copy of the License at
//
//  http://www.apache.org/licenses/LICENSE-2.0
//
//  Unless required by applicable law or agreed to in writing, software
//  distributed under the License is distributed on an "AS IS" BASIS,
//  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
//  See the License for the specific language governing permissions and
//  limitations under the License.
//

#import <UIKit/UIKit.h>
#import "LYRUIConfigurable.h"
#import "LYRUIViewWithLayout.h"
#import "LYRUIViewWithAction.h"
@class LYRUIMessageItemView;

NS_ASSUME_NONNULL_BEGIN     // {
@protocol LYRUIMessageItemView <LYRUIViewWithAction>

@property (nonatomic, weak, readonly) UITapGestureRecognizer *tapGestureRecognizer;

@property(nonatomic, strong, nullable) UIView *primaryAccessoryView;
@property(nonatomic, strong, nullable) UIView *statusView;
@property(nonatomic, strong, nullable) UIView *contentView;
@property(nonatomic, strong, nullable) UIView *secondaryAccessoryView;

@property (nonatomic, copy) NSString *messageId;

@property(nonatomic, strong) UIColor *contentViewColor;

@end

typedef NS_ENUM(NSUInteger, LYRUIMessageItemViewLayoutDirection) {
    LYRUIMessageItemViewLayoutDirectionLeft = 1,
    LYRUIMessageItemViewLayoutDirectionRight = -1,
};

@protocol LYRUIMessageItemViewLayout <LYRUIViewLayout>

/**
 @abstract Direction of conversation item subviews alignment.
 @warning Changing the layout direction requires `setNeedsUpdateConstraints` to be called on the view.
 */
@property (nonatomic) LYRUIMessageItemViewLayoutDirection layoutDirection;

- (void)addConstraintsInView:(LYRUIMessageItemView *)view;

- (void)updateConstraintsInView:(LYRUIMessageItemView *)view;

- (void)removeConstraintsFromView:(LYRUIMessageItemView *)view;

@end

IB_DESIGNABLE
/**
 @abstract The `LYRUIMessageItemView` class provides a lightweight, customizable view for presenting Layer message objects.
 */
@interface LYRUIMessageItemView : LYRUIViewWithLayout <LYRUIMessageItemView, LYRUIConfigurable>

/**
 @abstract An primary accessory view for the item, i.e. an avatar view;
 */
@property(nonatomic, strong, nullable) IBOutlet UIView *primaryAccessoryView;

/**
 @abstract An secondary accessory view for the item, i.e. an disclosure indicator;
 */
@property(nonatomic, strong, nullable) IBOutlet UIView *secondaryAccessoryView;

/**
 @abstract An status view
 */
@property(nonatomic, strong, nullable) IBOutlet UIView *statusView;

/**
 @abstract The view in which the primary accessory view will be contained;
 */
@property (nonatomic, weak, readonly) UIView *primaryAccessoryViewContainer;

/**
 @abstract The view in which the content view will be contained;
 */
@property (nonatomic, weak, readonly) UIView *contentViewContainer;

/**
 @abstract The view in which the secondary accessory view will be contained;
 */
@property (nonatomic, weak, readonly) UIView *secondaryAccessoryViewContainer;

/**
 @abstract The view in which we show the status;
 */
@property (nonatomic, weak, readonly) UIView *statusViewContainer;

/**
 @abstract Layout of the message item subviews.
 */
@property (nonatomic, copy) id<LYRUIMessageItemViewLayout> layout;

@end
NS_ASSUME_NONNULL_END       // }
