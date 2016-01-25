//
//  UITableViewCell+WT.h
//  WTSDK
//
//  Created by 张威庭 on 15/12/26.
//  Copyright © 2015年 zwt. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITableViewCell (WT)
+ (void)registerTable:(UITableView *)table
        nibIdentifier:(NSString *)identifier ;

- (void)configure:(UITableViewCell *)cell
        customObj:(id)obj
        indexPath:(NSIndexPath *)indexPath ;

+ (CGFloat)getCellHeightWithCustomObj:(id)obj
                            indexPath:(NSIndexPath *)indexPath ;

@end
