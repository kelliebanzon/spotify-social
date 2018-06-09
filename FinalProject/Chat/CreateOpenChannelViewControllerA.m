//
//  CreateOpenChannelViewControllerA.m
//  FinalProject
//
//  Created by Kellie Banzon on 06/07/18.
//  Copyright © 2018 Kellie Banzon. All rights reserved.
//

#import "CreateOpenChannelViewControllerA.h"
#import "SelectOperatorsViewController.h"
#import "OperatorTableViewCell.h"
#import "CustomActivityIndicatorView.h"
#import "CreateOpenChannelNavigationController.h"
#import <SendBirdSDK/SendBirdSDK.h>
#import <AFNetworking/UIImageView+AFNetworking.h>

@interface CreateOpenChannelViewControllerA ()

@property (weak, nonatomic) IBOutlet UIImageView *coverImageView;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UITextField *channelNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *channelURLTextField;
@property (weak, nonatomic) IBOutlet CustomActivityIndicatorView *activityIndicatorView;

@property (strong) NSMutableDictionary<NSString *, SBDUser *> *selectedUsers;
@property (strong) NSMutableArray<SBDUser *> *selectedUsersArray;
@property (strong) NSData *coverImageData;

@end

@implementation CreateOpenChannelViewControllerA

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UITapGestureRecognizer *clickCoverImageRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickCoverImage:)];
    [self.coverImageView setUserInteractionEnabled:YES];
    [self.coverImageView addGestureRecognizer:clickCoverImageRecognizer];
    
    self.activityIndicatorView.hidden = YES;
    [self.view bringSubviewToFront:self.activityIndicatorView];

    
    // Do any additional setup after loading the view.
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    self.selectedUsersArray = [[NSMutableArray alloc] init];
    
    self.navigationController.navigationBar.barStyle = UIBarStyleBlackTranslucent;
    self.navigationController.navigationBar.barTintColor = [UIColor colorNamed:@"SPTDarkGray"];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - TableView

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    printf("numberOfRowsInSection: %i\n", self.selectedUsersArray.count);
    return self.selectedUsersArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 64;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    OperatorTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"OperatorTableViewCell"];
    if (cell == nil) {
        [tableView registerNib:[UINib nibWithNibName:@"OperatorTableViewCell" bundle:nil] forCellReuseIdentifier:@"OperatorTableViewCell"];
        cell = [tableView dequeueReusableCellWithIdentifier:@"OperatorTableViewCell"];
    }
    
    dispatch_async(dispatch_get_main_queue(), ^{
        OperatorTableViewCell *updateCell = (OperatorTableViewCell *)[tableView cellForRowAtIndexPath:indexPath];
        if (updateCell) {
            updateCell.nicknameLabel.text = self.selectedUsersArray[indexPath.row].nickname;
            [updateCell.profilePictureImageView setImageWithURL:[NSURL URLWithString:self.selectedUsersArray[indexPath.row].profileUrl]];
            
        }
    });
    
    return cell;
}

- (void)didSelectUsers:(NSMutableDictionary<NSString *, SBDUser *> *)users {
    [self.selectedUsersArray addObjectsFromArray: self.selectedUsers.allValues];
    [self.selectedUsersArray addObject: [SBDMain getCurrentUser]];
    [_tableView reloadData];
}

#pragma mark - CoverImage

- (void)clickCoverImage:(id)sender {
    UIAlertController *vc = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *takePhotoAction = [UIAlertAction actionWithTitle:@"Take Photo" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        dispatch_async(dispatch_get_main_queue(), ^{
            UIImagePickerController *mediaUI = [[UIImagePickerController alloc] init];
            mediaUI.sourceType = UIImagePickerControllerSourceTypeCamera;
            NSMutableArray *mediaTypes = [[NSMutableArray alloc] initWithObjects:(NSString *)kUTTypeImage, nil];
            mediaUI.mediaTypes = mediaTypes;
            [mediaUI setDelegate:self];
            [self presentViewController:mediaUI animated:YES completion:nil];
        });
    }];
    
    UIAlertAction *chooseFromLibraryAction = [UIAlertAction actionWithTitle:@"Choose from Library" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        dispatch_async(dispatch_get_main_queue(), ^{
            UIImagePickerController *mediaUI = [[UIImagePickerController alloc] init];
            mediaUI.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            NSMutableArray *mediaTypes = [[NSMutableArray alloc] initWithObjects:(NSString *)kUTTypeImage, nil];
            mediaUI.mediaTypes = mediaTypes;
            [mediaUI setDelegate:self];
            [self presentViewController:mediaUI animated:YES completion:nil];
        });
    }];
    
    UIAlertAction *closeAction = [UIAlertAction actionWithTitle:@"Close" style:UIAlertActionStyleCancel handler:nil];
    
    [vc addAction:takePhotoAction];
    [vc addAction:chooseFromLibraryAction];
    [vc addAction:closeAction];
    
    [self presentViewController:vc animated:YES completion:nil];
}


- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *, id> *)info
{
    NSString *mediaType = [info objectForKey: UIImagePickerControllerMediaType];
    __weak CreateOpenChannelViewControllerA *weakSelf = self;
    [picker dismissViewControllerAnimated:YES completion:^{
        CreateOpenChannelViewControllerA *strongSelf = weakSelf;
        if (CFStringCompare ((CFStringRef) mediaType, kUTTypeImage, 0) == kCFCompareEqualTo) {
            UIImage *originalImage;
            originalImage = (UIImage *)[info objectForKey:UIImagePickerControllerOriginalImage];
            if (originalImage != nil) {
                NSData *imageData = UIImageJPEGRepresentation(originalImage, 1.0);
                
                [strongSelf cropImage:imageData];
            }
        }
    }];
}


- (void)cropImage:(NSData *)imageData {
    UIImage *image = [UIImage imageWithData:imageData];
    RSKImageCropViewController *imageCropVC = [[RSKImageCropViewController alloc] initWithImage:image];
    imageCropVC.delegate = self;
    imageCropVC.cropMode = RSKImageCropModeSquare;
    [self presentViewController:imageCropVC animated:NO completion:nil];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [picker dismissViewControllerAnimated:YES completion:^{
    }];
}

// Crop image has been canceled.
- (void)imageCropViewControllerDidCancelCrop:(RSKImageCropViewController *)controller {
    [controller dismissViewControllerAnimated:NO completion:nil];
}

// The original image has been cropped.
- (void)imageCropViewController:(RSKImageCropViewController *)controller
                   didCropImage:(UIImage *)croppedImage
                  usingCropRect:(CGRect)cropRect {
    self.coverImageView.image = croppedImage;
    self.coverImageData = UIImageJPEGRepresentation(croppedImage, 0.5);
    [controller dismissViewControllerAnimated:NO completion:nil];
}

// The original image has been cropped. Additionally provides a rotation angle used to produce image.
- (void)imageCropViewController:(RSKImageCropViewController *)controller
                   didCropImage:(UIImage *)croppedImage
                  usingCropRect:(CGRect)cropRect
                  rotationAngle:(CGFloat)rotationAngle {
    self.coverImageView.image = croppedImage;
    self.coverImageData = UIImageJPEGRepresentation(croppedImage, 0.5);
    [controller dismissViewControllerAnimated:NO completion:nil];
}

// The original image will be cropped.
- (void)imageCropViewController:(RSKImageCropViewController *)controller
                  willCropImage:(UIImage *)originalImage {
    // Use when `applyMaskToCroppedImage` set to YES.
}


#pragma mark - Navigation

- (IBAction)clickCancelButton:(id)sender {
    printf("clickCancelButton\n");
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)clickDoneButton:(id)sender {
    printf("clickDoneButton\n");
    if ([self.channelNameTextField hasText] == NO){
        UIAlertController* emptyChatNameAlert = [UIAlertController alertControllerWithTitle:@"Error" message:@"Channel must have a name." preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction* dismissButton = [UIAlertAction actionWithTitle:@"Dismiss" style:UIAlertActionStyleCancel handler:nil];
        [emptyChatNameAlert addAction:dismissButton];
        
        [self presentViewController:emptyChatNameAlert animated:YES completion:nil];
    }
    else {
        [self.activityIndicatorView setHidden:NO];
        [self.activityIndicatorView startAnimating];
        NSMutableArray<NSString *> *operatorIds = [[NSMutableArray alloc] init];
        [operatorIds addObjectsFromArray:self.selectedUsers.allKeys];
        [operatorIds addObject:[SBDMain getCurrentUser].userId];
        NSString *channelUrl = self.channelURLTextField.text;
        [SBDOpenChannel createChannelWithName:self.channelNameTextField.text channelUrl:channelUrl coverImage:self.coverImageData coverImageName:@"cover_image.jpg" data:nil operatorUserIds:operatorIds customType:nil progressHandler:nil completionHandler:^(SBDOpenChannel * _Nullable channel, SBDError * _Nullable error) {
            [self.activityIndicatorView setHidden:YES];
            [self.activityIndicatorView stopAnimating];
            
            if (error != nil) {
                UIAlertController *vc = [UIAlertController alertControllerWithTitle:@"Error" message:error.domain preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction *closeAction = [UIAlertAction actionWithTitle:@"Close" style:UIAlertActionStyleCancel handler:nil];
                [vc addAction:closeAction];
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self presentViewController:vc animated:YES completion:nil];
                });
                
                return;
            }
            
            if ([self.navigationController isKindOfClass:[CreateOpenChannelNavigationController class]]) {
                CreateOpenChannelNavigationController *nc = (CreateOpenChannelNavigationController *)self.navigationController;
                
                if (nc.createChannelDelegate != nil) {
                    [nc.createChannelDelegate didCreate:channel];
                }
            }
            
            [self dismissViewControllerAnimated:YES completion:nil];
        }];
    }
}


- (IBAction)unwindFromSelectOperatorsViewController:(UIStoryboardSegue *)segue
{
    if ([segue.sourceViewController isKindOfClass:[SelectOperatorsViewController class]]) {
        SelectOperatorsViewController *opsVC = segue.sourceViewController;
        if ([segue.identifier isEqualToString:@"unwindDoneFromOpVC"]){
            printf("unwindDone\n");
            self.selectedUsers = opsVC.selectedUsers;
            [self didSelectUsers:self.selectedUsers];
        }
        else if ([segue.identifier isEqualToString:@"unwindCancelFromOpVC"]){
            printf("unwindCancel\n");
        }
    }
}

@end
