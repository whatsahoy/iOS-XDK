//
//  LYRUIAvatarViewConfigurator.m
//  Layer-UI-iOS
//
//  Created by Łukasz Przytuła on 21.07.2017.
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

#import "LYRUIAvatarViewConfigurator.h"
#import "LYRUIAvatarView.h"
#import "LYRUIImageWithLettersView.h"
#import "LYRUIShapedView.h"
#import "LYRUINumberBadgeView.h"
#import "LYRUIImageWithLettersViewConfigurator.h"
#import "LYRUIPresenceViewConfigurator.h"

@interface LYRUIAvatarViewConfigurator ()

@property (nonatomic, strong) LYRUIImageWithLettersViewConfigurator *avatarViewConfigurator;
@property (nonatomic, strong) LYRUIPresenceViewConfigurator *presenceViewConfigurator;

@end

@implementation LYRUIAvatarViewConfigurator

- (void)setupAvatarView:(LYRUIAvatarView *)avatarView withIdentities:(NSArray<LYRIdentity *> *)identities {
    if (identities.count == 1) {
        [self setupSingleAvatarView:avatarView withIdentity:identities.firstObject];
    } else {
        [self setupMultipleAvatarView:avatarView withIdentities:identities];
    }
}

- (void)setupSingleAvatarView:(LYRUIAvatarView *)avatarView withIdentity:(LYRIdentity *)identity {
    [self.avatarViewConfigurator setupImageWithLettersView:avatarView.primaryAvatarView withIdentity:identity];
    // TODO: update to identity layout
}

- (void)setupMultipleAvatarView:(LYRUIAvatarView *)avatarView withIdentities:(NSArray<LYRIdentity *> *)identities {
    if (identities.count == 2) {
        [self.avatarViewConfigurator setupImageWithLettersView:avatarView.secondaryAvatarView withIdentity:identities.lastObject];
    } else {
        [self.avatarViewConfigurator setupImageWithLettersViewWithMultipleParticipantsIcon:avatarView.secondaryAvatarView];
    }
    [self.avatarViewConfigurator setupImageWithLettersView:avatarView.primaryAvatarView withIdentity:identities.firstObject];
    // TODO: update to conversation layout
}

@end
