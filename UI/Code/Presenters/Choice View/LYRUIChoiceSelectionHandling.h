//
//  LYRUIChoiceSelectionHandling.h
//  Layer-XDK-UI-iOS
//
//  Created by Łukasz Przytuła on 16.01.2018.
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

#import <Foundation/Foundation.h>
#import "LYRUIConfigurable.h"
@class LYRUIChoiceButton;
@class LYRUIChoice;
@protocol LYRUIChoiceSet;
@protocol LYRUIMessageListActionHandlingDelegate;

NS_ASSUME_NONNULL_BEGIN     // {
@protocol LYRUIChoiceSelectionHandling <NSObject>

@property (nonatomic, strong, readonly) id<LYRUIChoiceSet> choiceSet;
@property (nonatomic, weak) NSArray<LYRUIChoiceButton *> *buttons;

@property (nonatomic, weak, nullable) id <LYRUIMessageListActionHandlingDelegate> actionHandlingDelegate;

- (instancetype)initWithChoiceSet:(id<LYRUIChoiceSet>)choiceSet configuration:(LYRUIConfiguration *)configuration;

- (void)buttonTapped:(LYRUIChoiceButton *)tappedButton;

@end
NS_ASSUME_NONNULL_END       // }
