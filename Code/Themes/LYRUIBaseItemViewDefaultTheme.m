//
//  LYRUIBaseItemViewDefaultTheme.m
//  Layer-UI-iOS
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
            messageLabelFont = _messageLabelFont,
            messageLabelColor = _messageLabelColor,
            timeLabelFont = _timeLabelFont,
            timeLabelColor = _timeLabelColor;

- (instancetype)init {
    self = [super init];
    if (self) {
        UIColor *blackColor = [UIColor colorWithRed:27.0/255.0 green:28.0/255.0 blue:29.0/255.0 alpha:1.0];
        UIColor *grayColor = [UIColor colorWithRed:163.0/255.0 green:168.0/255.0 blue:178.0/255.0 alpha:1.0];
        self.titleLabelFont = [UIFont systemFontOfSize:16];
        self.titleLabelColor = blackColor;
        self.messageLabelFont = [UIFont systemFontOfSize:14];
        self.messageLabelColor = grayColor;
        self.timeLabelFont = [UIFont systemFontOfSize:12];
        self.timeLabelColor = grayColor;
    }
    return self;
}

@end
