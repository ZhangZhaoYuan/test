//
//  MessageCell.m
//  Test
//
//  Created by xinxin on 2020/4/12.
//  Copyright © 2020 PM. All rights reserved.
//

#import "MessageCell.h"
#import "MJExtension.h"
@implementation MessageCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self bulidUI];
    }
    return self;
}
-(void)bulidUI{
    self.contentLabel = [[UILabel alloc]initWithFrame:self.contentView.frame];
    self.contentLabel.textColor = [UIColor orangeColor];
    self.contentLabel.font = [UIFont systemFontOfSize:16];
    self.contentLabel.textAlignment = 1;
    [self.contentView addSubview:self.contentLabel];
}

@end
