//
//  LYRUIConfiguration.h
//  Layer-XDK-UI-iOS
//
//  Created by Łukasz Przytuła on 14.12.2017.
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

#import <LayerKit/LayerKit.h>
#import "LYRUICustomMessageTypeRegistering.h"
#import "LYRUIParticipantsFiltering.h"
#import "LYRUIParticipantsSorting.h"

NS_ASSUME_NONNULL_BEGIN     // {
@interface LYRUIConfiguration : NSObject <LYRUICustomMessageTypeRegistering>

/**
 @abstract The `LYRClient` object used to fetch objects for display.
 @discussion When `client` is set, and `participantsFilter` is nil, a `LYRUIParticipantsDefaultFilterWithCurrentUser` with client's `authenticatedUser` will be used.
 */
@property (nonatomic, strong, nullable) LYRClient *client;

/**
 @abstract An `LYRUIParticipantsFiltering` block which will filter currently logged in user from the participants set. Default value is `LYRUIParticipantsDefaultFilterWithCurrentUser` with client's `authenticatedUser`, or nil when `client` is not authenticated, or not set.
 */
@property (nonatomic, strong, nullable) LYRUIParticipantsFiltering participantsFilter;

/**
 @abstract An `LYRUIParticipantsSorting` block used to sort participants set.
 */
@property (nonatomic, strong, nullable) LYRUIParticipantsSorting participantsSorter;

/**
 @abstract Block used for opening URLs.
 */
@property (nonatomic, copy) void(^openURL)(NSURL *);

/**
 @abstract Block used for checking if URL can be opened.
 */
@property (nonatomic, copy) BOOL(^canOpenURL)(NSURL *);

/**
 @abstract Initializes a new `LYRUIConfiguration` object with the given `LYRClient` object.
 @param client The `LYRClient` object from which objects will be fetched for display.
 @return An `LYRUIConfiguration` object initialized with the given `LYRClient` object.
 */
- (instancetype)initWithLayerClient:(LYRClient *)client;

@end
NS_ASSUME_NONNULL_END       // }
