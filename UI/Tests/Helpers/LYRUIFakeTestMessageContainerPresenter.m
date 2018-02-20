//
//  LYRUIFakeTestMessageContainerPresenter.m
//  Layer-UI-iOS
//
//  Created by Łukasz Przytuła on 19.02.2018.
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

#import "LYRUIFakeTestMessageContainerPresenter.h"

@implementation LYRUIFakeTestMessageContainerPresenter
@synthesize reusableViewsQueue, actionHandlingDelegate, presentersProvider;

- (UIColor *)backgroundColorForMessage:(LYRUIMessageType *)message {
    return UIColor.whiteColor;
}

- (UIView *)viewForMessage:(LYRUIMessageType *)message {
    return [[UIView alloc] init];
}

- (CGFloat)viewHeightForMessage:(LYRUIMessageType *)message minWidth:(CGFloat)minWidth maxWidth:(CGFloat)maxWidth {
    return 10.0;
}

@end
