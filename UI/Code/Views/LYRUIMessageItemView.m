//
//  LYRUIMessageItemView.m
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

#import "LYRUIMessageItemView.h"
#import "LYRUIConfiguration+DependencyInjection.h"
#import "LYRUIMessageItemViewLayout.h"
#import "LYRUIMessageItemIBSetup.h"

static CGFloat const LYRUIMessageItemViewContentDefaultCornerRadius = 4.0;
static CGFloat const LYRUIMessageItemViewContentDefaultBorderWidth = 1.0;

@interface LYRUIMessageItemView ()

@property (nonatomic, weak, readwrite) UIView *primaryAccessoryViewContainer;
@property (nonatomic, weak, readwrite) UIView *contentViewContainer;
@property (nonatomic, weak, readwrite) UIView *secondaryAccessoryViewContainer;
@property (nonatomic, weak, readwrite) UIView *statusViewContainer;

@property (nonatomic, weak, readwrite) UITapGestureRecognizer *tapGestureRecognizer;

@end

@implementation LYRUIMessageItemView
@synthesize primaryAccessoryView = _primaryAccessoryView,
            contentView = _contentView,
            statusView = _statusView,
            secondaryAccessoryView = _secondaryAccessoryView,
            layerConfiguration = _layerConfiguration,
            messageId = _messageId,
            contentViewColor = _contentViewColor,
            actionHandler = _actionHandler,
            actionPreviewHandler = _actionPreviewHandler;
@dynamic layout;

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self lyr_commonInit];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self lyr_commonInit];
    }
    return self;
}

- (instancetype)initWithConfiguration:(LYRUIConfiguration *)configuration {
    self = [self initWithFrame:CGRectZero];
    if (self) {
        [self lyr_commonInit];
        self.layerConfiguration = configuration;
    }
    return self;
}

- (void)setLayerConfiguration:(LYRUIConfiguration *)layerConfiguration {
    _layerConfiguration = layerConfiguration;
    if (self.layout == nil) {
        self.layout = [layerConfiguration.injector layoutForViewClass:[self class]];
    }
}

- (void)lyr_commonInit {
    self.updateConstraintsOnWidthChange = YES;
    self.primaryAccessoryViewContainer = [self addView];
    self.contentViewContainer = [self addView];
    self.contentViewContainer.layer.cornerRadius = LYRUIMessageItemViewContentDefaultCornerRadius;
    self.contentViewContainer.layer.borderWidth = LYRUIMessageItemViewContentDefaultBorderWidth;
    self.secondaryAccessoryViewContainer = [self addView];
    self.statusViewContainer = [self addView];
    
    
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                                           action:@selector(handleTap)];
    [self.contentViewContainer addGestureRecognizer:tapGestureRecognizer];
    self.tapGestureRecognizer = tapGestureRecognizer;
}

- (UIView *)addView {
    return [self addViewIn:self];
}

- (UIView *)addViewIn:(UIView *)superview {
    UIView *view = [[UIView alloc] init];
    view.clipsToBounds = YES;
    view.translatesAutoresizingMaskIntoConstraints = NO;
    [superview addSubview:view];
    return view;
}

- (void)prepareForInterfaceBuilder {
    [[[LYRUIMessageItemIBSetup alloc] init] prepareMessageItemForInterfaceBuilder:self];
}

#pragma mark - Properties

- (void)setPrimaryAccessoryView:(UIView *)primaryAccessoryView {
    if (self.primaryAccessoryView != nil) {
        [self.primaryAccessoryView removeFromSuperview];
    }
    if (primaryAccessoryView != nil) {
        [self.primaryAccessoryViewContainer addSubview:primaryAccessoryView];
    }
    _primaryAccessoryView = primaryAccessoryView;
    [self setNeedsUpdateConstraints];
}

- (void)setStatusView:(UIView *)statusView {
    if (self.statusView != nil) {
        [self.statusView removeFromSuperview];
    }
    if (statusView != nil) {
        [self.statusViewContainer addSubview:statusView];
    }
    _statusView = statusView;
    [self setNeedsUpdateConstraints];
}

- (void)setContentView:(UIView *)contentView {
    if (self.contentView != nil) {
        [self.contentView removeFromSuperview];
    }
    if (contentView != nil) {
        [self.contentViewContainer addSubview:contentView];
    }
    _contentView = contentView;
    [self setNeedsUpdateConstraints];
}

- (void)setSecondaryAccessoryView:(UIView *)secondaryAccessoryView {
    if (self.secondaryAccessoryView != nil) {
        [self.secondaryAccessoryView removeFromSuperview];
    }
    if (secondaryAccessoryView != nil) {
        [self.secondaryAccessoryViewContainer addSubview:secondaryAccessoryView];
    }
    _secondaryAccessoryView = secondaryAccessoryView;
    [self setNeedsUpdateConstraints];
}

- (void)setContentViewColor:(UIColor *)contentViewColor {
    _contentViewColor = contentViewColor;
    self.contentViewContainer.backgroundColor = contentViewColor;
    self.contentViewContainer.layer.borderColor = contentViewColor.CGColor;
    
    self.contentViewContainer.layer.shadowRadius = 2;
    self.contentViewContainer.layer.shadowColor = [UIColor colorWithRed:0.04 green:0.08 blue:0.15 alpha:0.5].CGColor;
    self.contentViewContainer.layer.shadowOffset = CGSizeMake(0, 2);
    self.contentViewContainer.layer.shadowOpacity = 0.6;
    self.contentViewContainer.layer.masksToBounds = NO;
    
}

#pragma mark - Action handling

- (void)handleTap {
    if (self.actionHandler) {
        self.actionHandler();
    }
}

@end
