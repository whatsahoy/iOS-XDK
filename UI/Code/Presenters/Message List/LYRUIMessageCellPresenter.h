//
//  LYRUIMessageCellPresenter.h
//  Layer-XDK-UI-iOS
//
//  Created by Łukasz Przytuła on 28.08.2017.
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

#import "LYRUIParticipantsFiltering.h"
#import "LYRUIConfigurable.h"
#import "LYRUIListCellSizeCalculating.h"
#import "LYRUIListCellPresenting.h"
@protocol LYRUIMessageListActionHandlingDelegate;
@class LYRUIMessageType;

@interface LYRUIMessageCellPresenter : NSObject <LYRUIListCellSizeCalculating, LYRUIListCellPresenting, LYRUIConfigurable>

/**
 @abstract Delegate used for handling message actions.
 */
@property (nonatomic, weak) id<LYRUIMessageListActionHandlingDelegate> actionHandlingDelegate;

- (CGFloat)cellHeightForMessage:(LYRUIMessageType *)message contentViewWidth:(CGFloat)width;

@end
