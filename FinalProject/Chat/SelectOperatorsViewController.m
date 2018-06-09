//
//  SelectOperatorsViewController.m
//  FinalProject
//
//  Created by Kellie Banzon on 06/08/18.
//  Copyright © 2018 Kellie Banzon. All rights reserved.
//


#import "SelectOperatorsViewController.h"
#import "SelectorOperatorsTableViewCell.h"
#import <AFNetworking/UIImageView+AFNetworking.h>

@interface SelectOperatorsViewController ()
@property (weak, nonatomic) IBOutlet UIBarButtonItem *okButtonItem;
@property (weak, nonatomic) IBOutlet UITableView *tableView;



@end

@implementation SelectOperatorsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.users = [[NSMutableArray alloc] init];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    self.refreshControl = [[UIRefreshControl alloc] init];
    [self.refreshControl addTarget:self action:@selector(refreshUserList) forControlEvents:UIControlEventValueChanged];
    
    self.tableView.refreshControl = self.refreshControl;
    
    self.userListQuery = nil;
    
    self.selectedUsers = [NSMutableDictionary new];
    
    if (self.selectedUsers.count == 0) {
        self.okButtonItem.enabled = NO;
    }
    else {
        self.okButtonItem.enabled = YES;
    }
    
    self.okButtonItem.title = [NSString stringWithFormat:@"OK (%d)", (int)self.selectedUsers.count];
    
    [self refreshUserList];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)refreshUserList {
    [self loadUserListNextPage:YES];
}

- (void)loadUserListNextPage:(BOOL)refresh {
    if (refresh) {
        self.userListQuery = nil;
    }
    
    if (self.userListQuery == nil) {
        self.userListQuery = [SBDMain createAllUserListQuery];
        self.userListQuery.limit = 20;
    }
    
    if (self.userListQuery.hasNext == NO) {
        return;
    }
    
    [self.userListQuery loadNextPageWithCompletionHandler:^(NSArray<SBDUser *> * _Nullable users, SBDError * _Nullable error) {
        if (error != nil) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.refreshControl endRefreshing];
            });
            
            return;
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            if (refresh) {
                [self.users removeAllObjects];
            }
            
            [self.users addObjectsFromArray:users];
            [self.tableView reloadData];
            
            [self.refreshControl endRefreshing];
        });
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.users.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 64;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SelectorOperatorsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SelectorOperatorsTableViewCell"];
    if (cell == nil) {
        [tableView registerNib:[UINib nibWithNibName:@"SelectorOperatorsTableViewCell" bundle:nil] forCellReuseIdentifier:@"SelectorOperatorsTableViewCell"];
        cell = [tableView dequeueReusableCellWithIdentifier:@"SelectorOperatorsTableViewCell"];
    }
    
    dispatch_async(dispatch_get_main_queue(), ^{
        SelectorOperatorsTableViewCell *updateCell = (SelectorOperatorsTableViewCell *)[tableView cellForRowAtIndexPath:indexPath];
        if (updateCell) {
            [updateCell setSelectionStyle:UITableViewCellSelectionStyleNone];
            updateCell.nicknameLabel.text = self.users[indexPath.row].nickname;
            [updateCell.profileImageView setImageWithURL:[NSURL URLWithString:self.users[indexPath.row].profileUrl]];
            
            if (self.selectedUsers[self.users[indexPath.row].userId] != nil) {
                [updateCell setSelected:YES];
            }
            else {
                [updateCell setSelected:NO];
            }
            
        }
    });
    if (self.users.count > 0 && indexPath.row == self.users.count - 1) {
        [self loadUserListNextPage:NO];
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.selectedUsers[self.users[indexPath.row].userId] != nil) {
        printf("remove selectedUser\n");
        [self.selectedUsers removeObjectForKey:self.users[indexPath.row].userId];
    }
    else {
        self.selectedUsers[self.users[indexPath.row].userId] = self.users[indexPath.row];
    }
    
    self.okButtonItem.title = [NSString stringWithFormat:@"OK (%d)", (int)self.selectedUsers.count];
    
    if (self.selectedUsers.count == 0) {
        self.okButtonItem.enabled = NO;
    }
    else {
        self.okButtonItem.enabled = YES;
    }
    
    [tableView reloadData];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
