//
//  LYRUIBaseItemViewDefaultTheme.m
//  Layer-XDK-UI-iOS
//
//  Created by Łukasz Przytuła on 27.09.2017.
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

#import "LYRUIBaseItemViewDefaultTheme.h"

@implementation LYRUIBaseItemViewDefaultTheme
@synthesize titleLabelFont = _titleLabelFont,
            titleLabelColor = _titleLabelColor,
            subtitleLabelFont = _subtitleLabelFont,
            subtitleLabelColor = _subtitleLabelColor,
            detailLabelFont = _detailLabelFont,
            detailLabelColor = _detailLabelColor;

- (instancetype)init {
    self = [super init];
    if (self) {
        UIColor *blackColor = [UIColor colorWithRed:27.0/255.0 green:28.0/255.0 blue:29.0/255.0 alpha:1.0];
        UIColor *grayColor = [UIColor colorWithRed:163.0/255.0 green:168.0/255.0 blue:178.0/255.0 alpha:1.0];
        self.titleLabelFont = [UIFont fontWithName:@"Lato-Regular" size:16.0];
        self.titleLabelColor = blackColor;
        self.subtitleLabelFont = [UIFont fontWithName:@"Lato-Regular" size:14.0];
        self.subtitleLabelColor = grayColor;
        self.detailLabelFont = [UIFont fontWithName:@"Lato-Regular" size:12.0];
        self.detailLabelColor = grayColor;
    }
    return self;
}

- (id)copyWithZone:(NSZone *)zone {
    __typeof(self) copy = [[[self class] allocWithZone:zone] init];
    copy.titleLabelFont = self.titleLabelFont;
    copy.titleLabelColor = self.titleLabelColor;
    copy.subtitleLabelFont = self.subtitleLabelFont;
    copy.subtitleLabelColor = self.subtitleLabelColor;
    copy.detailLabelFont = self.detailLabelFont;
    copy.detailLabelColor = self.detailLabelColor;
    return copy;
}

@end
