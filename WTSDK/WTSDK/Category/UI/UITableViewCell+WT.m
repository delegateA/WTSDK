//
//  UITableViewCell+WT.m
//  WTSDK
//
//  Created by 张威庭 on 15/12/26.
//  Copyright © 2015年 zwt. All rights reserved.
//

#import "UITableViewCell+WT.h"

@implementation UITableViewCell (WT)

#pragma mark --
+ (UINib *)nibWithIdentifier:(NSString *)identifier
{
    return [UINib nibWithNibName:identifier bundle:nil];
}

#pragma mark - Public
+ (void)registerTable:(UITableView *)table
        nibIdentifier:(NSString *)identifier
{
    [table registerNib:[self nibWithIdentifier:identifier] forCellReuseIdentifier:identifier] ;
}

#pragma mark --
#pragma mark - Rewrite these func in SubClass !
- (void)configure:(UITableViewCell *)cell
        customObj:(id)obj
        indexPath:(NSIndexPath *)indexPath
{
    // Rewrite this func in SubClass !
    
}

+ (CGFloat)getCellHeightWithCustomObj:(id)obj
                            indexPath:(NSIndexPath *)indexPath
{
    // Rewrite this func in SubClass if necessary
    if (!obj) {
        return 0.0f ; // if obj is null .
    }
    return 44.0f ; // default cell height
}


@end
