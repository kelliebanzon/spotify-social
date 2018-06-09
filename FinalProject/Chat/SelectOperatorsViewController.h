//
//  SelectOperatorsViewController.h
//  FinalProject
//
//  Created by Kellie Banzon on 06/08/18.
//  Copyright © 2018 Kellie Banzon. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <SendBirdSDK/SendBirdSDK.h>

@interface SelectOperatorsViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>

@property (strong) NSMutableArray<SBDUser *> *users;
@property (strong) SBDUserListQuery *userListQuery;
@property (strong) UIRefreshControl *refreshControl;
@property (strong) NSMutableDictionary<NSString *, SBDUser *> *selectedUsers;

@end
