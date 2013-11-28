//  MAINBPickerView.h
//  MyTestApp
//
//  Created by Lacutos on 13/6/11.
//  Copyright (c) 2013年 Jason.Cai. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MainSliderView: UIView {
	NSString *sTitle;            // 設定 PickerView 的顯示標題
	NSString *sDone;             // 設定右側按鈕文字，預設為「Done」
	NSString *sCancel;           // 設定左側按鈕文字，預設為「Cancel」	
	UIBarButtonItem *btnDone;
	UIBarButtonItem *btnCancel;
	UILabel *lbTitle;
    
    
    UIButton    *m_SliderButton;
    UIButton    *m_CloseButton;
}

@property (nonatomic, copy) NSString *sTitle;
@property (nonatomic, copy) NSString *sDone;
@property (nonatomic, copy) NSString *sCancel;
@property (nonatomic, assign) UILabel *lbTitle;
@property (nonatomic, retain) UIBarButtonItem *btnDone;
@property (nonatomic, retain) UIBarButtonItem *btnCancel;
@property (nonatomic, retain) UIButton* m_SliderButton;
@property (nonatomic, retain) UIButton* m_CloseButton;


-(void) reSetMMBPickerViewTitle:(NSString *)sItemTitle;

-(void) removeCancelBtn;
-(void) AddCancelBtn;

@end