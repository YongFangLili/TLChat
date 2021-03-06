//
//  TLExpressionMoreSearchCell.m
//  TLChat
//
//  Created by 李伯坤 on 2017/7/21.
//  Copyright © 2017年 李伯坤. All rights reserved.
//

#import "TLExpressionMoreSearchCell.h"
#import "TLExpressionSearchViewController.h"
#import "TLSearchController.h"

@interface TLExpressionMoreSearchCell ()

@property (nonatomic, strong) TLSearchController *searchController;

@property (nonatomic, copy) id (^eventAction)(NSInteger, id);

@end

@implementation TLExpressionMoreSearchCell

#pragma mark - # Protocol
+ (CGSize)viewSizeByDataModel:(id)dataModel
{
    return CGSizeMake(SCREEN_WIDTH, SEARCHBAR_HEIGHT);
}

- (void)setViewEventAction:(id (^)(NSInteger, id))eventAction
{
    self.eventAction = eventAction;
}

#pragma mark - # Public Methods
- (id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setBackgroundColor:[UIColor whiteColor]];
        @weakify(self);
        TLExpressionSearchViewController *searchResultVC = [[TLExpressionSearchViewController alloc] init];
        [searchResultVC setItemClickAction:^(TLExpressionSearchViewController *searchController, id data) {
            @strongify(self);
            [self.searchController setActive:NO];
            if (self.eventAction) {
                self.eventAction(0, data);
            }
        }];
        self.searchController = [TLSearchController createWithResultsContrller:searchResultVC];
        [self.searchController.searchBar setPlaceholder:LOCSTR(@"搜索表情")];
        [self.contentView addSubview:self.searchController.searchBar];
    }
    return self;
}

@end
