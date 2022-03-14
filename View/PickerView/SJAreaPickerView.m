//
//  SJAreaPickerView.m
//  renejin
//
//  Created by ShaJin on 2019/4/26.
//  Copyright © 2019 ZhaoJin. All rights reserved.
//

#import "SJAreaPickerView.h"
#import "AreaModel.h"

@interface SJAreaPickerView ()<UIPickerViewDelegate,UIPickerViewDataSource>
@property(nonatomic,strong)UIView           *titleView;
@property(nonatomic,strong)UIButton         *confirmButton;
@property(nonatomic,strong)UIButton         *cancelButton;
@property (nonatomic,strong)UIPickerView    *pickerView;

@property(nonatomic,strong)NSArray<ProvinceModel *> *dataSource;
@property(nonatomic,strong)ProvinceModel    *province;
@property(nonatomic,strong)CityModel        *city;
@property(nonatomic,strong)AreaModel        *area;

@property(nonatomic,copy)void (^completeBlock)(NSString *province, NSString *city, NSString *area);
@property(nonatomic,strong)NSString *defaultProvince;
@property(nonatomic,strong)NSString *defaultCity;
@property(nonatomic,strong)NSString *defaultArea;
@end
@implementation SJAreaPickerView
#pragma mark- UIPickerViewDelegate
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    switch (component) {
        case 0:{
            self.province = self.dataSource[row];
            self.city = self.province.cities[0];
            self.area = self.city.districts[0];
            [pickerView selectRow:0 inComponent:1 animated:YES];
            [pickerView selectRow:0 inComponent:2 animated:YES];
            [pickerView reloadComponent:1];
            [pickerView reloadComponent:2];
        }break;
        case 1:{
            self.city = self.province.cities[row];
            self.area = self.city.districts[0];
            [pickerView selectRow:0 inComponent:2 animated:YES];
            [pickerView reloadComponent:2];
        }break;
        case 2:{
            self.area = self.city.districts[row];
        }break;
        default:
            break;
    }
}
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 3;
}
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    NSInteger count = 0;
    switch (component) {
        case 0:{
            count = self.dataSource.count;
        }break;
        case 1:{
            count = self.province.cities.count;
        }break;
        case 2:{
            count = self.city.districts.count;
        }
        default:
            break;
    }
    return count;
}
- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view {
    UILabel* tView = (UILabel*)view;
    if (!tView){
        tView = [[UILabel alloc] init];
        [tView setFont:[UIFont fontWithName:@"Helvetica" size:16]];
        [tView setTextAlignment:NSTextAlignmentCenter];
        tView.numberOfLines=3;
    }
    switch (component) {
        case 0:{
            tView.text = self.dataSource[row].provinceName;
        }break;
        case 1:{
            tView.text = self.province.cities[row].cityName;
        }break;
        case 2:{
            tView.text = self.city.districts[row].areaName;
        }break;
        default:
            break;
    }
    return tView;
}
#pragma mark- CustomMethod
-(void)confirmAction{
    if (self.completeBlock) {
        self.completeBlock(self.province.provinceName, self.city.cityName, self.area.areaName);
    }
    [self dismiss];
}
-(void)initUI{
    [self addSubview:self.titleView];
    [self.titleView addSubview:self.cancelButton];
    [self.titleView addSubview:self.confirmButton];
    [self addSubview:self.pickerView];
}
-(void)setDefaultSelect{
    for (int i = 0; i < self.dataSource.count; i++) {
        ProvinceModel *province = self.dataSource[i];
        if ([self.defaultProvince isEqualToString:province.provinceName]) {
            self.province = province;
            for (int j = 0; j < province.cities.count; j++) {
                CityModel *city = province.cities[j];
                if ([self.defaultCity isEqualToString:city.cityName]) {
                    self.city = city;
                    for (int k = 0; k < city.districts.count; k++) {
                        AreaModel *area = city.districts[k];
                        if ([self.defaultArea isEqualToString:area.areaName]) {
                            self.area = area;
                            [self.pickerView reloadAllComponents];
                            [self.pickerView selectRow:i inComponent:0 animated:YES];
                            [self.pickerView selectRow:j inComponent:1 animated:YES];
                            [self.pickerView selectRow:k inComponent:2 animated:YES];
                            return;
                        }
                    }
                }
            }
        }
    }
    self.province = self.dataSource[0];
    self.city = self.province.cities[0];
    self.area = self.city.districts[0];
}
#pragma mark- Setter
-(void)setButtonColor:(UIColor *)buttonColor{
    _buttonColor = buttonColor;
    [self.confirmButton setTitleColor:buttonColor forState:UIControlStateNormal];
    [self.cancelButton setTitleColor:buttonColor forState:UIControlStateNormal];
}
-(void)setTitleViewColor:(UIColor *)titleViewColor{
    _titleViewColor = titleViewColor;
    self.titleView.backgroundColor = titleViewColor;
}

#pragma mark- Getter
-(NSArray<ProvinceModel *> *)dataSource{
    if (!_dataSource) {
        NSMutableArray *provinces = [NSMutableArray array];
        NSError *error = nil;
        NSString *jsonStr = [NSString stringWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"area" ofType:@"txt"] encoding:4 error:&error];
        NSArray *provinceArr = [NSArray arrayWithJsonString:jsonStr];
        for (NSDictionary *provinceDict in provinceArr) {
            ProvinceModel *province = [ProvinceModel new];
            province.provinceID = provinceDict[@"id"];
            province.isOpen = provinceDict[@"isOpen"];
            province.letter = provinceDict[@"letter"];
            province.provinceCode = ifNull(provinceDict[@"provinceCode"]);
            province.provinceName = provinceDict[@"provinceName"];
            NSArray *cityArr = provinceDict[@"cities"];
            NSMutableArray *cities = [NSMutableArray array];
            for (NSDictionary *cityDict in cityArr) {
                CityModel *city = [CityModel new];
                city.cityID = cityDict[@"id"];
                city.provinceId = cityDict[@"provinceId"];
                city.cityName = cityDict[@"cityName"];
                city.isHot = cityDict[@"isHot"];
                city.isOpen = cityDict[@"isOpen"];
                city.letter = cityDict[@"letter"];
                city.zipcode = cityDict[@"zipcode"];
                NSMutableArray *areas = [NSMutableArray array];
                NSArray *areaArr = cityDict[@"districts"];
                for (NSDictionary *dict in areaArr) {
                    AreaModel *area = [AreaModel new];
                    area.areaID = dict[@"id"];
                    area.areaName = dict[@"areaName"];
                    area.cityId = dict[@"cityId"];
                    [areas addObject:area];
                }
                city.districts = areas;
                [cities addObject:city];
            }
            province.cities = cities;
            [provinces addObject:province];
        }
        _dataSource = provinces;
    }
    return _dataSource;
}
-(UIView *)titleView{
    if (!_titleView) {
        _titleView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.width, 44)];
        _titleView.backgroundColor = Color(234, 234, 234);
    }
    return _titleView;
}
-(UIButton *)confirmButton{
    if (!_confirmButton) {
        _confirmButton = [UIButton buttonWithType:0];
        _confirmButton.frame = CGRectMake(self.width - 60, 0, 60, 44);
        [_confirmButton setTitle:@"确定" forState:UIControlStateNormal];
        [_confirmButton setTitleColor:Color(13, 95, 255) forState:UIControlStateNormal];
        [_confirmButton addTarget:self action:@selector(confirmAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _confirmButton;
}
-(UIButton *)cancelButton{
    if (!_cancelButton) {
        _cancelButton = [UIButton buttonWithType:0];
        _cancelButton.frame = CGRectMake(0, 0, 60, 44);
        [_cancelButton setTitle:@"取消" forState:UIControlStateNormal];
        [_cancelButton setTitleColor:Color(13, 95, 255) forState:UIControlStateNormal];
        [_cancelButton addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
    }
    return _cancelButton;
}
-(UIPickerView *)pickerView {
    if (!_pickerView) {
        _pickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 44, self.width, self.height - 44 - kSafeAreaBottom)];
        _pickerView.showsSelectionIndicator = YES;
        _pickerView.delegate = self;
        _pickerView.dataSource = self;
    }
    return _pickerView;
}
#pragma mark- LifeCycle
-(instancetype)initWithProvince:(NSString *)province city:(NSString *)city area:(NSString *)area completeBlock:(void(^)(NSString *province, NSString *city, NSString *area))completeBlock{
    if (self = [super initWithFrame:CGRectMake(0, kHeight - kSafeAreaBottom - 300, kWidth, 300 + kSafeAreaBottom)]) {
        self.animationType = kAnimationBottom;
        self.radius = 0.0;
        self.completeBlock = completeBlock;
        self.defaultProvince = province;
        self.defaultCity = city;
        self.defaultArea = area;
        
        [self initUI];
        [self setDefaultSelect];
    }
    return self;
}

@end
