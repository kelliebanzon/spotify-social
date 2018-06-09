//
//  CreateOpenChannelViewControllerB.m
//  FinalProject
//
//  Created by Kellie Banzon on 06/08/18.
//  Copyright © 2018 Kellie Banzon. All rights reserved.
//

#import "CreateOpenChannelViewControllerB.h"

@interface CreateOpenChannelViewControllerB ()

@property (strong) NSMutableDictionary<NSString *, SBDUser *> *selectedUsers;

@end

@implementation CreateOpenChannelViewControllerB

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)didSelectUsers:(NSMutableDictionary<NSString *, SBDUser *> *)users {
    self.selectedUsers = users;
    
    /* TODO: dispatch_async(dispatch_get_main_queue(), ^{
        [self removeAllOperatorViews];
        if (self.selectedUsers != nil && self.selectedUsers.count > 0) {
            for (NSString *key in self.selectedUsers.allKeys) {
                [self addOperatorView:self.selectedUsers[key]];
            }
        }
    });*/
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    UIViewController *vc = [segue destinationViewController];
    if ([vc isKindOfClass:[SelectOperatorsViewController class]]) {
        ((SelectOperatorsViewController *)vc).delegate = self;
        ((SelectOperatorsViewController *)vc).selectedUsers = self.selectedUsers;
    }
}


@end
