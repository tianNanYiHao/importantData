//
//  OrderReceiptCell.m
//  jfpal
//
//  Created by Chunhui Luo on 2/28/13.
//
//

#import "OrderReceiptCell.h"
#import "Utils.h"

@implementation OrderReceiptCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}


- (void)awakeFromNib {
    _descLabel.textColor = [UIColor blackColor];
    _resultLabel.textColor = [UIColor blackColor];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}



@end
