//
//  MSYViewController.m
//  MSYLog
//
//  Created by FancyPower.com on 03/18/2022.
//  Copyright (c) 2022 FancyPower.com. All rights reserved.
//

#import "MSYViewController.h"
#import <Masonry/Masonry.h>
#import <MSYTableView/MSYCommonTableView.h>
#import <MSYTableView/MSYTableViewProtocol.h>
#import <MSYTableView/MSYCommonTableData.h>

#import "MSYListDefine.h"
#import <MSYLog/MSYLogManager.h>

@interface MSYViewController ()

@property (nonatomic, strong) MSYCommonTableView *listView;

@end

@implementation MSYViewController

#pragma mark - lifecycle methods

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.listView];
    [self initConstraints];
    [self loadDataSource];
    
    MSYLog(@"当前Log文件路径:%@", [[MSYLogManager sharedInstance] currentFilePath]);
    MSYLog(@"当前logs文件夹路径:%@", [[MSYLogManager sharedInstance] filePaths]);
}

#pragma mark - public methods

- (void)pushNextPageWithCtr:(UIViewController *)ctr
                      title:(NSString *)title {
    if (!ctr) {
        return;
    }
    
    ctr.title = title;
    
    [self.navigationController pushViewController:ctr animated:YES];
}

#pragma mark - private methods

- (void)initConstraints {
    [self.listView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.view);
    }];
}

- (void)loadDataSource {
    NSArray *titleList = @[
        kRowTitle_logLevel,
        kRowTitle_switchLevel,
        kRowTitle_cleanLogFile,
        kRowTitle_removeOSLogger,
        kRowTitle_addOSLogger,
        kRowTitle_removeFileLogger,
        kRowTitle_addFileLogger,
    ];
    
    NSMutableArray *rowDicList = [NSMutableArray array];
    for (NSString *title in titleList) {
        NSDictionary *rowDic = @{
            kRow_title : title,
        };
        
        [rowDicList addObject:rowDic];
    }
    
    NSDictionary *secDic = @{
        kSec_headerTitle : kSecTitle_example,
        kSec_rowContent : rowDicList,
        kSec_footerHeight : @(kSectionHeaderHeight_zero),
    };
    self.listView.dataSource = [MSYCommonTableSection sectionsWithData:@[secDic]];
}

#pragma mark - MSYTableViewProtocol

- (void)msy_tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    MSYCommonTableSection *secModel = self.listView.dataSource[indexPath.section];
    MSYCommonTableRow *rowModel = secModel.rows[indexPath.row];
    
    if ([rowModel.title isEqualToString:kRowTitle_logLevel]) {
        MSYLogError(@"log error");
        MSYLogWarn(@"log warn");
        MSYLogInfo(@"log info");
        MSYLogDebug(@"log debug");
        MSYLogVerbose(@"log verbose");
    }
    else if ([rowModel.title isEqualToString:kRowTitle_switchLevel]) {
        [[MSYLogManager sharedInstance] switchLogLevel:DDLogLevelVerbose];
    }
    else if ([rowModel.title isEqualToString:kRowTitle_cleanLogFile]) {
        [[MSYLogManager sharedInstance] createAndRollToNewFile];
    }
    else if ([rowModel.title isEqualToString:kRowTitle_removeOSLogger]) {
        [[MSYLogManager sharedInstance] removeOSLogger];
    }
    else if ([rowModel.title isEqualToString:kRowTitle_addOSLogger]) {
        [[MSYLogManager sharedInstance] addOSLogger];
    }
    else if ([rowModel.title isEqualToString:kRowTitle_removeFileLogger]) {
        [[MSYLogManager sharedInstance] removeFileLogger];
    }
    else if ([rowModel.title isEqualToString:kRowTitle_addFileLogger]) {
        [[MSYLogManager sharedInstance] addFileLogger];
    }
}


#pragma mark - getter && setter

- (MSYCommonTableView *)listView {
    if (!_listView) {
        _listView = [[MSYCommonTableView alloc] init];
    }
    return _listView;
}

@end
