//
//  LYRUIPanelTypingIndicatorViewLayout.m
//  Layer-XDK-UI-iOS
//
//  Created by Łukasz Przytuła on 14.09.2017.
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

#import "LYRUIPanelTypingIndicatorViewLayout.h"

@interface LYRUIPanelTypingIndicatorViewLayout ()

@property (nonatomic, strong) NSMutableArray *labelConstraints;

@end

@implementation LYRUIPanelTypingIndicatorViewLayout

- (instancetype)init {
    self = [super init];
    if (self) {
        self.labelConstraints = [[NSMutableArray alloc] init];
    }
    return self;
}

- (id)copyWithZone:(NSZone *)zone {
    return [[[self class] allocWithZone:zone] init];
}

- (BOOL)isEqual:(id)other {
    return [self isKindOfClass:[other class]];
}

- (void)addConstraintsInView:(LYRUIPanelTypingIndicatorView *)view {
    NSMutableArray *constraints = self.labelConstraints;
    [constraints addObject:[view.label.topAnchor constraintEqualToAnchor:view.topAnchor constant:4.0]];
    [constraints addObject:[view.label.leftAnchor constraintEqualToAnchor:view.leftAnchor]];
    [constraints addObject:[view.label.bottomAnchor constraintEqualToAnchor:view.bottomAnchor constant:-4.0]];
    [constraints addObject:[view.label.rightAnchor constraintEqualToAnchor:view.rightAnchor]];
    [constraints addObject:[view.label.heightAnchor constraintEqualToConstant:14.0]];
    view.label.textAlignment = NSTextAlignmentCenter;
    view.label.font = [UIFont fontWithName:@"Lato-Regular" size:12.0];
    [NSLayoutConstraint activateConstraints:constraints];
}

- (void)updateConstraintsInView:(LYRUIPanelTypingIndicatorView *)view {}

- (void)removeConstraintsFromView:(LYRUIPanelTypingIndicatorView *)view {
    [NSLayoutConstraint deactivateConstraints:self.labelConstraints];
    [self.labelConstraints removeAllObjects];
}

@end
