//
//  TLMomentExtensionView+TableView.h
//  TLChat
//
//  Created by 李伯坤 on 16/4/8.
//  Copyright © 2016年 李伯坤. All rights reserved.
//

#import "TLMomentExtensionView.h"

@interface TLMomentExtensionView (TableView) <UITableViewDelegate, UITableViewDataSource>

- (void)registerCellForTableView:(UITableView *)tableView;

@end
