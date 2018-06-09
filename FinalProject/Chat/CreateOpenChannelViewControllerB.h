//
//  CreateOpenChannelViewControllerB.h
//  FinalProject
//
//  Created by Kellie Banzon on 06/08/18.
//  Copyright © 2018 Kellie Banzon. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SelectOperatorsViewController.h"

@interface CreateOpenChannelViewControllerB : UIViewController<SelectOperatorsDelegate>

@property (strong) NSString *channelName;
@property (strong) NSData *coverImageData;

@end
