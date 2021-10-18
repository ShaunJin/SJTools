//
//  SJTimeSelectView.m
//  AnJian
//
//  Created by Air on 2021/9/24.
//
// 时间选择页面，精确到分
#import "SJTimeSelectView.h"
@interface SJTimeSelectView()<UIPickerViewDelegate,UIPickerViewDataSource>
@property(nonatomic,strong)UIPickerView *pickerView;
@property(nonatomic,strong)NSArray *years;
@property(nonatomic,assign)int year;
@property(nonatomic,assign)int month;
@property(nonatomic,assign)int day;
@property(nonatomic,assign)int hour;
@property(nonatomic,assign)int minute;
@end
@implementation SJTimeSelectView
#pragma mark- UIPickerViewDelegate
- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component{
    CGFloat width = ceil(kWidth / 6);
    switch (component) {
        case 0:{
            width = ceil(kWidth / 4);
        }break;
        case 1:{
            
        }break;
        case 2:{
            
        }break;
        case 3:{
            
        }break;
        case 4:{
            
        }break;
        default:
            break;
    }
    
    return width;
}
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    switch (component) {
        case 0:{
            self.year = [self.years[row] intValue];
            [self.pickerView reloadComponent:2];
        }break;
        case 1:{
            self.month = (int)row + 1;
            [self.pickerView reloadComponent:2];
        }break;
        case 2:{
            self.day = (int)row + 1;
        }break;
        case 3:{
            self.hour = (int)row;
        }break;
        case 4:{
            self.minute = (int)row;
        }break;
        default:
            break;
    }
}
- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view {
    UILabel* tView = (UILabel*)view;
    if (!tView){
        tView = [[UILabel alloc] init];
        [tView setFont:[UIFont fontWithName:@"Helvetica" size:18]];
        [tView setTextAlignment:NSTextAlignmentCenter];
        tView.numberOfLines=0;
    }
    
    switch (component) {
        case 0:{
            tView.text = [NSString stringWithFormat:@"%@年",self.years[row]];
        }break;
        case 1:{
            tView.text = [NSString stringWithFormat:@"%ld月",row + 1];
        }break;
        case 2:{
            tView.text = [NSString stringWithFormat:@"%ld日",row + 1];
        }break;
        case 3:{
            tView.text = [NSString stringWithFormat:@"%ld时",row ];
        }break;
        case 4:{
            tView.text = [NSString stringWithFormat:@"%ld分",row ];
        }break;
        default:
            break;
    }
    return tView;
}
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 5;
}
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    NSInteger count = 0;
    switch (component) {
        case 0:{
            count = self.years.count;
        }break;
        case 1:{
            count = 12;
        }break;
        case 2:{
            count = [self getDaysWithYear:self.year month:self.month];
        }break;
        case 3:{
            count = 24;
        }break;
        case 4:{
            count = 60;
        }break;
        default:
            break;
    }
    return count;
}
#pragma mark- CustomMethod
-(void)confirmAction{
    if (self.selectBlock) {
        self.selectBlock([self getCurrentTimeStamp]);
    }
    [self dismiss];
}
-(double)getCurrentTimeStamp{
    NSDateFormatter *formatter = [NSDateFormatter new];
    formatter.dateFormat = @"yyyy-MM-dd HH:mm";
    NSString *time = [NSString stringWithFormat:@"%d-%02d-%02d %02d:%02d",self.year,self.month,self.day,self.hour,self.minute];
    NSDate *date = [formatter dateFromString:time];
    return [date timeIntervalSince1970];
}
-(void)reloadView{
    [self.pickerView selectRow:[self.years indexOfObject:[NSString stringWithFormat:@"%d",self.year]] inComponent:0 animated:NO];
    [self.pickerView selectRow:self.month - 1 inComponent:1 animated:NO];
    [self.pickerView selectRow:self.day inComponent:2 animated:NO];
    [self.pickerView selectRow:self.hour inComponent:3 animated:NO];
    [self.pickerView selectRow:self.minute inComponent:4 animated:NO];
}
/** 重置显示时间 */
-(void)resetTimeStamp:(double)timestamp{
    if (timestamp >= self.startTimestamp && timestamp <= self.endTimestamp) {
        NSDate *date = [NSDate dateWithTimeIntervalSince1970:timestamp];
        NSDateFormatter *formatter = [NSDateFormatter new];
        formatter.dateFormat = @"yyyy";
        self.year = [[formatter stringFromDate:date] intValue];
        formatter.dateFormat = @"MM";
        self.month = [[formatter stringFromDate:date] intValue];
        formatter.dateFormat = @"dd";
        self.day = [[formatter stringFromDate:date] intValue];
        formatter.dateFormat = @"HH";
        self.hour = [[formatter stringFromDate:date] intValue];
        formatter.dateFormat = @"mm";
        self.minute = [[formatter stringFromDate:date] intValue];
        [self reloadView];
    }else if (timestamp < self.startTimestamp){
        [self resetTimeStamp:self.startTimestamp];
    }else if (timestamp > self.endTimestamp){
        [self resetTimeStamp:self.endTimestamp];
    }
}
#pragma mark- Setter
-(void)setStartTimestamp:(double)startTimestamp{
    if (startTimestamp >= 0 && startTimestamp < self.endTimestamp) {
        _startTimestamp = startTimestamp;
        double timestamp = [self getCurrentTimeStamp];
        self.years = nil;
        if (timestamp < startTimestamp) {
            [self resetTimeStamp:startTimestamp];
        }else{
            [self reloadView];
        }
    }
}
-(void)setEndTimestamp:(double)endTimestamp{
    if (endTimestamp <= 6311433600 && endTimestamp > self.startTimestamp) {
        double timestamp = [self getCurrentTimeStamp];
        _endTimestamp = endTimestamp;
        self.years = nil;
        if (timestamp > endTimestamp) {
            [self resetTimeStamp:endTimestamp];
        }else{
            [self reloadView];
        }
    }
}
#pragma mark- Getter
-(UIPickerView *)pickerView {
    if (!_pickerView) {
        _pickerView = [[UIPickerView alloc] initWithFrame:CGRectZero];
        _pickerView.showsSelectionIndicator = YES;
        _pickerView.delegate = self;
        _pickerView.dataSource = self;
        [self addSubview:_pickerView];
    }
    return _pickerView;
}
-(NSArray *)years{
    if (!_years) {
        NSMutableArray *mArr = [NSMutableArray array];
        NSDateFormatter *formatter = [NSDateFormatter new];
        formatter.dateFormat = @"yyyy";
        int startYear = [[formatter stringFromDate:[NSDate dateWithTimeIntervalSince1970:self.startTimestamp]] intValue];   // 起始年份
        int endYear = [[formatter stringFromDate:[NSDate dateWithTimeIntervalSince1970:self.endTimestamp]] intValue];       // 终止年份
        NSLog(@"startYear = %d endYear = %d endTimestamp = %f",startYear,endYear,self.endTimestamp);
        for (int i = startYear; i <= endYear; i++) {
            [mArr addObject:[NSString stringWithFormat:@"%d",i]];
        }
        NSLog(@"marr = %@",mArr);
        _years = [mArr copy];
    }
    return _years;
}
//根据年、月判断日期天数
- (NSInteger)getDaysWithYear:(NSInteger)year month:(NSInteger)month{
    switch (month) {
        case 1:
            return 31;
            break;
        case 2:
            if (year%400==0 || (year%100!=0 && year%4 == 0)) {
                return 29;
            }else{
                return 28;
            }
            break;
        case 3:
            return 31;
            break;
        case 4:
            return 30;
            break;
        case 5:
            return 31;
            break;
        case 6:
            return 30;
            break;
        case 7:
            return 31;
            break;
        case 8:
            return 31;
            break;
        case 9:
            return 30;
            break;
        case 10:
            return 31;
            break;
        case 11:
            return 30;
            break;
        case 12:
            return 31;
            break;
        default:
            return 0;
            break;
    }
}
#pragma mark- LifeCycle
-(instancetype)init{
    if (self = [super init]) {
        _endTimestamp = 6311433600;
        self.pickerView.sd_layout.topSpaceToView(self, 44).leftSpaceToView(self, 0).bottomSpaceToView(self, kSafeAreaBottom).rightSpaceToView(self,0);
    }
    return self;
}

+(instancetype)selectViewWithTimestamp:(double)timestamp{
    SJTimeSelectView *selectView = [SJTimeSelectView new];
    [selectView resetTimeStamp:timestamp];
//    NSDate *date = [NSDate dateWithTimeIntervalSince1970:timestamp];
//    NSDateFormatter *formatter = [NSDateFormatter new];
//    formatter.dateFormat = @"yyyy";
//    selectView.year = [[formatter stringFromDate:date] intValue];
//    formatter.dateFormat = @"MM";
//    selectView.month = [[formatter stringFromDate:date] intValue];
//    formatter.dateFormat = @"dd";
//    selectView.day = [[formatter stringFromDate:date] intValue];
//    formatter.dateFormat = @"HH";
//    selectView.hour = [[formatter stringFromDate:date] intValue];
//    formatter.dateFormat = @"mm";
////    NSString *min = [formatter stringFromDate:date];
//    selectView.minute = [[formatter stringFromDate:date] intValue];
//    [selectView reloadView];
    return selectView;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
