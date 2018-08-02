//
//  SJPickerView.m
//  AutoBooking
//
//  Created by youwan on 2018/8/2.
//  Copyright © 2018年 gzsm. All rights reserved.
//

#import "SJPickerView.h"
@interface SJPickerCell : UITableViewCell
@property(nonatomic,strong)UIImageView *icon;
@property(nonatomic,strong)UILabel *titleLabel;
@property(nonatomic,strong)UIImageView *selectView;

@end

@implementation SJPickerCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self.contentView addSubview:self.icon];
        [self.contentView addSubview:self.titleLabel];
        [self.contentView addSubview:self.selectView];
    }
    return self;
}
-(UIImageView *)icon{
    if (!_icon) {
        _icon = [UIImageView new];
    }
    return _icon;
}
-(UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [UILabel labelWithTextColor:kTitleBColor size:15];
    }
    return _titleLabel;
}
-(UIImageView *)selectView{
    if (!_selectView) {
        _selectView = [UIImageView new];
    }
    return _selectView;
}
@end

@interface SJPickerView()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,assign)BOOL multiSelect;                            // 是否是多选
@property(nonatomic,strong)UILabel *titleLabel;                         // 标题
@property(nonatomic,strong)UITableView *tableView;                      // tableView
@property(nonatomic,assign)CGFloat bottomHeight;                // 底部预留高度（tableView底部到self底部的距离）
@property(nonatomic,assign)BOOL hasImage;                               // 标记选项是否有图标
@property(nonatomic,strong)NSArray<UIImage *> *icons;                   // 图标数组
@property(nonatomic,strong)NSArray<NSString *> *options;                // 选项数组
@property(nonatomic,strong)NSMutableArray<NSString *> *selectOptions;   // 已选择数组
@property(nonatomic,copy)void (^completeBlock)(NSArray<NSString *> *selectOptions);
@property(nonatomic,strong)UIButton *confirmButton;
@property(nonatomic,strong)UIButton *cancelButton;
@end
@implementation SJPickerView
#pragma mark- UITableViewDelegate
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSString *option = self.options[indexPath.row];
    if (self.multiSelect) {
        if ([self.selectOptions containsObject:option]) {
            [self.selectOptions removeObject:option];
        }else{
            [self.selectOptions addObject:option];
        }
        [tableView reloadData];
    }else{
        if (self.completeBlock) {
            self.completeBlock(@[ifNull(option)]);
        }
        [self dismiss];
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return self.rowHeight;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.options.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    SJPickerCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CellID"];
    NSString *path = [[NSBundle mainBundle] pathForResource:@"icon_picker_selected" ofType:@"png"];
    UIImage *selectImage = [[UIImage imageWithContentsOfFile:path] changeColor:self.selectIconColor];
    if (self.hasImage) {
        cell.icon.frame = CGRectMake(15, ceil((self.rowHeight - self.iconSize.height) / 2.0), self.iconSize.width, self.iconSize.height);
        cell.titleLabel.frame = CGRectMake(cell.icon.right + 8, 0, self.width - cell.icon.right - 8 - 36, self.rowHeight);
    }else{
        cell.icon.frame = CGRectZero;
        cell.titleLabel.frame = CGRectMake(15, 0, self.width - 15 - 36, self.rowHeight);
    }
    cell.selectView.frame = CGRectMake(cell.titleLabel.right + 8, ceil((self.rowHeight - 20) / 2), 20, 20);
    cell.selectView.image = selectImage;
    if (indexPath.row < self.icons.count) {
        cell.imageView.image = self.icons[indexPath.row];
    }
    NSString *option = self.options[indexPath.row];
    cell.titleLabel.text = option;
    cell.selectView.hidden = ![self.selectOptions containsObject:option];
    return cell;
}
#pragma mark- CustomMethod
/** 重新布局 */
-(void)relayout{
    CGFloat height = 44;
    CGFloat bottomHeight = (self.multiSelect ? 60 : 0);
    height += bottomHeight;
    BOOL overMax = self.options.count > self.maxCount;
    height = height + (overMax ? self.maxCount : self.options.count) * self.rowHeight;
    self.hasImage = self.icons.count > 0;
    self.frame = CGRectMake(0, 0, 270, height);
    self.center = CGPointMake(kWidth / 2.0, kHeight / 2.0);
    self.titleLabel.frame = CGRectMake(0, 0, self.width, 44);
    self.tableView.frame = CGRectMake(0, 44, self.width, self.height - 44 - bottomHeight);
    self.tableView.scrollEnabled = overMax;
    if (self.multiSelect) {
        self.cancelButton.frame = CGRectMake(0, self.tableView.bottom, self.width / 2.0, self.bottomHeight);
        self.confirmButton.frame = self.cancelButton.frame;
        self.confirmButton.left = self.cancelButton.right;
    }else{
        self.cancelButton.frame = CGRectZero;
        self.confirmButton.frame = CGRectZero;
    }
    [self.tableView reloadData];
}
-(void)confirmAction{
    if (self.completeBlock) {
        self.completeBlock(self.selectOptions);
    }
    [self dismiss];
}
#pragma mark- Setter
-(void)setMaxCount:(int)maxCount{
    if (_maxCount != maxCount) {
        _maxCount = maxCount;
        [self relayout];
    }
}
-(void)setRowHeight:(CGFloat)rowHeight{
    if (_rowHeight != rowHeight) {
        _rowHeight = rowHeight;
        [self relayout];
    }
}
#pragma mark- Getter
-(UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [UILabel labelWithTextColor:Color(51, 51, 51) size:17];
        _titleLabel.backgroundColor = Color(247, 247, 247);
        _titleLabel.textAlignment = 1;
    }
    return _titleLabel;
}
-(UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [_tableView registerClass:[SJPickerCell class] forCellReuseIdentifier:@"CellID"];
    }
    return _tableView;
}
-(UIButton *)confirmButton{
    if (!_confirmButton) {
        _confirmButton = [UIButton buttonWithTitle:@"确定" color:Color(41, 108, 255) size:16 target:self action:@selector(confirmAction)];
    }
    return _confirmButton;
}
-(UIButton *)cancelButton{
    if (!_cancelButton) {
        _cancelButton = [UIButton buttonWithTitle:@"取消" color:Color(41, 108, 255) size:16 target:self action:@selector(dismiss)];
    }
    return _cancelButton;
}
#pragma mark- LifeCycle
-(instancetype)initWithMultiSelect:(BOOL)multiSelect title:(NSString *)title icons:(NSArray<UIImage *> *)icons options:(NSArray<NSString *> *)options selectOptions:(NSArray<NSString *> *)selectOptions completeBlock:(void(^)(NSArray<NSString *> *selectOptions))completeBlock{
    if (self = [super initWithFrame:CGRectZero]) {
        // 初始化配置
        self.multiSelect = multiSelect;
        self.bottomHeight = (multiSelect ? 60 : 0);
        self.selectIconColor = Color(29, 195, 63);
        self.options = options;
        self.icons = icons;
        self.selectOptions = [NSMutableArray arrayWithArray:selectOptions];
        self.dismissOnTouchOutside = !multiSelect;
        self.completeBlock = completeBlock;
        _maxCount = 6;
        _iconSize = CGSizeMake(40, 40);
        _rowHeight = 50;
        // 添加控件
        [self addSubview:self.titleLabel];
        self.titleLabel.text = title;
        [self addSubview:self.tableView];
        [self addSubview:self.cancelButton];
        [self addSubview:self.confirmButton];
        [self relayout];
    }
    return self;
}
/** 多选 */
+(instancetype)pickerTitle:(NSString *)title icons:(NSArray<UIImage *> *)icons options:(NSArray<NSString *> *)options selectOptions:(NSArray<NSString *> *)selectOptions completeBlock:(void(^)(NSArray<NSString *> *selectOptions))completeBlock{
    SJPickerView *pickerView = [[SJPickerView alloc] initWithMultiSelect:YES title:title icons:icons options:options selectOptions:selectOptions completeBlock:completeBlock];
    [pickerView show];
    return pickerView;
}
/** 单选 */
+(instancetype)pickerTitle:(NSString *)title icons:(NSArray<UIImage *> *)icons options:(NSArray<NSString *> *)options select:(NSString *)select completeBlock:(void (^)(NSString *select))completeBlock{
    SJPickerView *pickerView = [[SJPickerView alloc] initWithMultiSelect:NO title:title icons:icons options:options selectOptions:(select.length > 0) ? @[select] : @[] completeBlock:^(NSArray<NSString *> *selectOptions) {
        if (selectOptions.count == 1 && completeBlock) {
            completeBlock(selectOptions[0]);
            
        }
    }];
    [pickerView show];
    return pickerView;
}

@end

