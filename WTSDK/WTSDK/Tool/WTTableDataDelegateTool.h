//
//  WTTableDataDelegateTool.h
//  WTSDK
//
//  Created by 张威庭 on 15/12/26.
//  Copyright © 2015年 zwt. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef void (^TableViewCellConfigureBlock)(NSIndexPath *indexPath, id item, UITableViewCell *cell);
typedef CGFloat (^CellHeightBlock)(NSIndexPath *indexPath, id item);
typedef void (^DidSelectCellBlock)(NSIndexPath *indexPath, id item);

@interface WTTableDataDelegateTool : NSObject <UITableViewDelegate,UITableViewDataSource>

- (id)initWithItems:(NSArray *)anItems
     cellIdentifier:(NSString *)aCellIdentifier
 configureCellBlock:(TableViewCellConfigureBlock)aConfigureCellBlock
    cellHeightBlock:(CellHeightBlock)aHeightBlock
     didSelectBlock:(DidSelectCellBlock)didselectBlock;

- (void)handleTableViewDatasourceAndDelegate:(UITableView *)table;

- (id)itemAtIndexPath:(NSIndexPath *)indexPath;
@end
