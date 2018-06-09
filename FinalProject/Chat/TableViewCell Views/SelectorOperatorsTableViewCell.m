//
//  SelectorOperatorsTableViewCell.m
//  FinalProject
//
//  Created by Kellie Banzon on 06/08/18.
//  Copyright © 2018 Kellie Banzon. All rights reserved.
//

#import "SelectorOperatorsTableViewCell.h"

@implementation SelectorOperatorsTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    if (selected){
        self.selectedImageView.image = [UIImage imageNamed:@"btn_check_on"];
    }
    else {
        self.selectedImageView.image = [UIImage imageNamed:@"btn_check_off"];
    }

}

@end
