//
//  HHComposeViewController.m
//  HaHaWeiBo
//
//  Created by Pengtong on 15/7/6.
//  Copyright (c) 2015年 Pengtong. All rights reserved.
//
#import "UIBarButtonItem+HHBarButtonItem.h"
#import "HHComposeViewController.h"
#import "HHAccount.h"
#import "HHAccountTool.h"
#import "HHTextView.h"
#import "MBProgressHUD+MJ.h"
#import "StatusBarHUD.h"
#import "HHInputToolView.h"
#import "QLAssetManager.h"
#import "QLAssetsModel.h"
#import "HHComposePhotoListView.h"
#import "HHEmotionTextView.h"
#import "HHComposeTool.h"
#import "HHEmotionKeyboard.h"
#import "HHEmotion.h"


#define HHInputViewH        44

@interface HHComposeViewController ()<UITextViewDelegate, HHInputToolViewDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate, HHComposePhotoListViewDelegate>

@property (nonatomic, strong) HHEmotionTextView *textView;

@property (nonatomic, strong) HHInputToolView *toolView;

@property (nonatomic, strong) NSMutableArray *dataSource;

@property (nonatomic, strong) HHEmotionKeyboard *emotionKeyBoard;

@property (nonatomic, strong) HHComposePhotoListView *photosView;

@property (nonatomic, assign) BOOL switchKeyboard;

@property (nonatomic, assign) CGFloat keyboardHeight;

@end

@implementation HHComposeViewController

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        _photoImage = [[UIImage alloc] init];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setupNav];
    
    [self setupView];
    
    [self setupTitle];
    
    [self setupText];
    
    [self setupTool];
    
    [self setupPhontsView];
}

- (void)setPhotoImage:(UIImage *)photoImage
{
    _photoImage = photoImage;
    QLAssetsModel *assetModel = [[QLAssetsModel alloc] init];
    assetModel.thumbnail = photoImage;
    [self.dataSource addObject:assetModel];
}

- (NSMutableArray *)dataSource
{
    if (!_dataSource)
    {
        _dataSource = [NSMutableArray array];
    }
    return _dataSource;
}

- (HHEmotionKeyboard *)emotionKeyBoard
{
    if (!_emotionKeyBoard)
    {
        _emotionKeyBoard = [[HHEmotionKeyboard alloc] init];
        _emotionKeyBoard.width = self.view.width;
        _emotionKeyBoard.height = self.keyboardHeight;
    }
    return _emotionKeyBoard;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationItem.rightBarButtonItem.enabled = NO;
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self.textView becomeFirstResponder];
}

- (void)setupNav
{
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStyleDone target:self action:@selector(cancal)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"发送" style:UIBarButtonItemStyleDone target:self action:@selector(send)];
}

- (void)setupTitle
{
    HHAccount *account = [HHAccountTool account];
    UILabel *title = [[UILabel alloc] init];
    title.height = 40;
    title.width = [UIScreen mainScreen].bounds.size.width - 40;
    title.textAlignment = NSTextAlignmentCenter;
    title.numberOfLines = 0;
    NSString *mainTitle = @"发微博";

    NSMutableAttributedString *attr = [[NSMutableAttributedString alloc] initWithString:mainTitle];
    [attr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:14] range:NSMakeRange(0, mainTitle.length)];
    
    if (account.userName)
    {
        NSString *subTitle = [NSString stringWithFormat:@"\n%@", account.userName];
        NSMutableAttributedString *subAttr = [[NSMutableAttributedString alloc] initWithString:subTitle];
        [subAttr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:11] range:NSMakeRange(0, subTitle.length)];
        [attr appendAttributedString:subAttr];
    }
    
    [title setAttributedText:attr];
    self.navigationItem.titleView = title;
}

- (void)setupView
{
    self.view.backgroundColor = [UIColor whiteColor];
}

- (void)setupTool
{
    HHInputToolView *toolView = [[HHInputToolView alloc] init];
    toolView.frame = CGRectMake(0, self.view.height - HHInputViewH, self.view.width, HHInputViewH);
    toolView.delegate = self;
    [self.view addSubview:toolView];
    self.toolView = toolView;
}

- (void)setupPhontsView
{
    HHComposePhotoListView *photosView = [[HHComposePhotoListView alloc] init];
    photosView.frame = CGRectMake(0, 120, self.view.width, self.view.height);
    photosView.delegate = self;
    [self.textView addSubview:photosView];
    self.photosView = photosView;
    
    if (self.dataSource.count)
    {
        self.photosView.photos = self.dataSource;
    }
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)textChange
{
    self.navigationItem.rightBarButtonItem.enabled = self.textView.hasText;
}


- (void)setupText
{
    HHEmotionTextView *textView = [[HHEmotionTextView alloc] init];
    textView.frame = self.view.bounds;
    textView.delegate = self;
    textView.font = [UIFont systemFontOfSize:18];
    textView.placeholder = @"分享新事物...";
    textView.placeholderColor = [UIColor lightGrayColor];
    [self.view addSubview:textView];
    self.textView = textView;
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textChange) name:UITextViewTextDidChangeNotification object:self.textView];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(emotionDidSelected:) name:HHEmotionDidSelectNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(emotionDelete) name:HHEmotionDeleteNotification object:nil];
}

- (void)keyboardWillShow:(NSNotification *)note
{
    if (self.switchKeyboard) return;
    
    double duration = [note.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    CGRect keybarRect = [note.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    self.keyboardHeight = keybarRect.size.height;
    [UIView animateWithDuration:duration animations:^{
        self.toolView.transform = CGAffineTransformMakeTranslation(0, -keybarRect.size.height);
    }];
}

- (void)keyboardWillHide:(NSNotification *)note
{
    if (self.switchKeyboard) return;
    
    double duration = [note.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    [UIView animateWithDuration:duration animations:^{
        self.toolView.transform = CGAffineTransformIdentity;
    }];
}

- (void)emotionDidSelected:(NSNotification *)notification
{
    HHEmotion *emotion = notification.userInfo[HHEmotionKey];
    [self.textView insertEmotion:emotion];
    self.navigationItem.rightBarButtonItem.enabled = self.textView.hasText;
}

- (void)emotionDelete
{
    [self.textView deleteBackward];
}


- (void)cancal
{
    [self.textView resignFirstResponder];
    [self.dataSource removeAllObjects];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)send
{
    if (self.photosView.photos.count)
    {
        [self sendImageStatus];
    }
    else
    {
        [self sendTextStatus];
    }
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)sendImageStatus
{
    HHComposeParame *parame = [[HHComposeParame alloc] init];
    parame.access_token = [HHAccountTool account].access_token;
    parame.status = self.textView.fullText;

    [StatusBarHUD showLoading:@"正在发送..."];
    
    [HHComposeTool sendImageStatusWithParame:parame fileArray:self.photosView.photos success:^(HHComposeRelust *result)
    {
        [StatusBarHUD showSuccess:@"发送成功"];
    }
    failure:^(NSError *error)
    {
        [StatusBarHUD showError:@"发送失败"];
        HHLog(@"请求失败%@", error);
    }];
}

- (void)sendTextStatus
{
    HHComposeParame *parame = [[HHComposeParame alloc] init];
    parame.access_token = [HHAccountTool account].access_token;
    parame.status = self.textView.fullText;
    
    [StatusBarHUD showLoading:@"正在发送..."];
    
    [HHComposeTool sendStatusWithParame:parame success:^(HHComposeRelust *result)
    {
        [StatusBarHUD showSuccess:@"发送成功"];
    }
    failure:^(NSError *error)
    {
        [StatusBarHUD showError:@"发送失败"];
        HHLog(@"请求失败%@", error);
    }];
}

- (void)openCamera
{
    UIImagePickerController *ipc = [[UIImagePickerController alloc] init];
    ipc.sourceType = UIImagePickerControllerSourceTypeCamera;
    ipc.delegate = self;
    
    [self presentViewController:ipc animated:YES completion:nil];
}

- (void)openPhotosAlbum
{
    __unsafe_unretained typeof(self) weakSelf = self;
    [QLAssetManager showAssetGroupViewOnViewController:self presentAnimation:YES maxCountCanSelect:HHStatusPhotoCounts - self.dataSource.count finishSelBlock:^(NSArray *selArr) {
        [weakSelf.dataSource addObjectsFromArray:selArr];
        weakSelf.photosView.photos = weakSelf.dataSource;
    }];
}

- (void)switchEmotionView
{
    self.switchKeyboard = YES;
    
    [self.textView resignFirstResponder];
    
    self.switchKeyboard = NO;
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(.15f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        self.textView.inputView=self.textView.inputView ? nil : self.emotionKeyBoard;
        self.toolView.emotionBtnIsSelect = !self.toolView.emotionBtnIsSelect;
        [self.textView becomeFirstResponder];
    });
}


#pragma mark --UITextViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [self.view endEditing:YES];
}
#pragma mark --HHInputToolViewDelegate
- (void)inputToolView:(HHInputToolView *)toolView didClickedButtonType:(HHInputToolButtonType)buttonType
{
    switch (buttonType) {
        case HHInputToolButtonCamera:
            [self openCamera];
            break;
        case HHInputToolButtonPicture:
            [self openPhotosAlbum];
            break;
        case HHInputToolButtonMention:
            
            break;
        case HHInputToolButtonTrend:
            
            break;
        case HHInputToolButtonEmoticon:
            [self switchEmotionView];
            break;
        default:
            break;
    }
}
#pragma mark --UIImagePickerControllerDelegate
- (void) imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    QLAssetsModel *assetModel = [[QLAssetsModel alloc] init];
    assetModel.thumbnail = info[UIImagePickerControllerOriginalImage];
    [self.dataSource addObject:assetModel];
    if (self.photosView.photos.count < HHStatusPhotoCounts)
    {
        self.photosView.photos = self.dataSource;
    }
    
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark --HHComposePhotoListViewDelegate
- (void)composePhotoListView:(HHComposePhotoListView *)photosView clickPhotosIndex:(NSUInteger)index
{
    __unsafe_unretained typeof(self) weakSelf = self;
    [QLAssetManager showAssetFullScreenBrowerView:self.navigationController presentAnimation:YES currentShowIndex:index assetsModels:self.dataSource finishSelBlock:^(NSArray *selArr) {
        [weakSelf.dataSource removeAllObjects];
        [weakSelf.dataSource addObjectsFromArray:selArr];
        weakSelf.photosView.photos = weakSelf.dataSource;
    }];
}

@end
