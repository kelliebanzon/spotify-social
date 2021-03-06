//
//  SelectOperatorsViewController.h
//  FinalProject
//
//  Created by Kellie Banzon on 06/08/18.
//  Copyright © 2018 Kellie Banzon. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <SendBirdSDK/SendBirdSDK.h>

@protocol SelectOperatorsDelegate <NSObject>

- (void)didSelectUsers:(NSMutableDictionary<NSString *, SBDUser *> *)users;

@end


@interface SelectOperatorsViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, weak) id <SelectOperatorsDelegate> delegate;

@property (strong) NSMutableArray<SBDUser *> *users;
@property (strong) SBDUserListQuery *userListQuery;
@property (strong) UIRefreshControl *refreshControl;
@property (strong) NSMutableDictionary<NSString *, SBDUser *> *selectedUsers;

@end



