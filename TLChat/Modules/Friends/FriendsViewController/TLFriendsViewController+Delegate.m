//
//  TLFriendsViewController+Delegate.m
//  TLChat
//
//  Created by 李伯坤 on 16/3/17.
//  Copyright © 2016年 李伯坤. All rights reserved.
//

#import "TLFriendsViewController+Delegate.h"
#import "TLFriendHeaderView.h"
#import "TLFriendCell.h"

#import "TLNewFriendViewController.h"
#import "TLGroupViewController.h"
#import "TLTagsViewController.h"
#import "TLPublicServerViewController.h"
#import "TLFriendDetailViewController.h"

#import "TLUserGroup.h"
#import "TLFriendHelper.h"

@implementation TLFriendsViewController (Delegate)

#pragma mark - Public Methods -
- (void)registerCellClass
{
    [self.tableView registerClass:[TLFriendHeaderView class] forHeaderFooterViewReuseIdentifier:@"TLFriendHeaderView"];
    [self.tableView registerClass:[TLFriendCell class] forCellReuseIdentifier:@"TLFriendCell"];
}

#pragma mark - Delegate -
//MARK: UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.data.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    TLUserGroup *group = [self.data objectAtIndex:section];
    return group.count;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return nil;
    }
    TLUserGroup *group = [self.data objectAtIndex:section];
    TLFriendHeaderView *view = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"TLFriendHeaderView"];
    [view setTitle:group.groupName];
    return view;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TLFriendCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TLFriendCell"];
    TLUserGroup *group = [self.data objectAtIndex:indexPath.section];
    TLUser *user = [group objectAtIndex:indexPath.row];
    [cell setUser:user];
    
    if (indexPath.section == self.data.count - 1 && indexPath.row == group.count - 1){  // 最后一个cell，底部全线
        [cell setBottomLineStyle:TLCellLineStyleFill];
    }
    else {
        [cell setBottomLineStyle:indexPath.row == group.count - 1 ? TLCellLineStyleNone : TLCellLineStyleDefault];
    }
    
    return cell;
}

// 拼音首字母检索
- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView
{
    return self.sectionHeaders;
}

// 检索时空出搜索框
- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index
{
    if(index == 0) {
        [self.tableView scrollRectToVisible:CGRectMake(0, 0, tableView.width, tableView.height) animated:NO];
        return -1;
    }
    return index;
}

//MARK: UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return HEIGHT_FRIEND_CELL;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return 0;
    }
    return HEIGHT_HEADER;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    TLUser *user = [self.data[indexPath.section] objectAtIndex:indexPath.row];
    if (indexPath.section == 0) {
        if ([user.userID isEqualToString:@"-1"]) {
            TLNewFriendViewController *newFriendVC = [[TLNewFriendViewController alloc] init];
            PushVC(newFriendVC);
        }
        else if ([user.userID isEqualToString:@"-2"]) {
            TLGroupViewController *groupVC = [[TLGroupViewController alloc] init];
            PushVC(groupVC);
        }
        else if ([user.userID isEqualToString:@"-3"]) {
            TLTagsViewController *tagsVC = [[TLTagsViewController alloc] init];
            PushVC(tagsVC)
        }
        else if ([user.userID isEqualToString:@"-4"]) {
            TLPublicServerViewController *publicServer = [[TLPublicServerViewController alloc] init];
            PushVC(publicServer)
        }
    }
    else {
        TLFriendDetailViewController *detailVC = [[TLFriendDetailViewController alloc] init];
        [detailVC setUser:user];
        PushVC(detailVC)
    }
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}

@end
