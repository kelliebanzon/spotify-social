//
//  CreateOpenChannelNavigationController.h
//  FinalProject
//
//  Created by Kellie Banzon on 06/08/18.
//  Copyright © 2018 Kellie Banzon. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <SendBirdSDK/SendBirdSDK.h>


@protocol CreateOpenChannelDelegate <NSObject>

- (void)didCreate:(SBDOpenChannel *)channel;

@end


@interface CreateOpenChannelNavigationController : UINavigationController

@property (nonatomic, weak) id <CreateOpenChannelDelegate> createChannelDelegate;

@end
