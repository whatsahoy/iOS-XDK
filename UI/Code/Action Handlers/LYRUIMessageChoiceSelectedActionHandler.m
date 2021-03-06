//
//  LYRUIMessageChoiceSelectedActionHandler.m
//  Layer-XDK-UI-iOS
//
//  Created by Łukasz Przytuła on 05.12.2017.
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

#import "LYRUIMessageChoiceSelectedActionHandler.h"
#import "LYRUIResponseMessage.h"

@implementation LYRUIMessageChoiceSelectedActionHandler

- (void)handleActionWithData:(NSDictionary *)data delegate:(id<LYRUIActionHandlingDelegate>)delegate {
    if (data == nil || data[@"text"] == nil || data[@"changes"] == nil) {
        return;
    }
    LYRUIResponseMessage *responseMessage = [[LYRUIResponseMessage alloc] initWithResponseTo:data[@"response_to"]
                                                                            responseToNodeId:data[@"response_to_node_id"]
                                                                             participantData:data[@"participant_data"]
                                                                                     changes:data[@"changes"]
                                                                                        text:data[@"text"]
                                                                                 messagePart:nil];
    [delegate actionHandler:self sendMessage:responseMessage];
}

- (UIViewController *)viewControllerForActionWithData:(NSDictionary *)data {
    return nil;
}

@end
