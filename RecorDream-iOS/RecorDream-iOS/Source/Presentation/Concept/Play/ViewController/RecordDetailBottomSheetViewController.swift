//
//  RecordDetailBottomSheetViewController.swift
//  RecorDream-iOS
//
//  Created by 임윤휘 on 2022/07/21.
//

import UIKit

class RecordDetailBottomSheetViewController: BaseViewController {
    @IBOutlet weak var bottomSheetHeight: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureView()
    }
    
    //MARK: - Configure
    private func configureView(){
        self.bottomSheetHeight.constant = 0
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first, self.view == touch.view {
            hideBottomSheet()
        }
    }
    
    @IBAction func shareButtonDidTapped(_ sender: UIButton) {
        guard let captureView = UINib(nibName: "RecordDetailViewController", bundle: nil).instantiate(withOwner: self, options: nil).first as? UIView
        else { return }
        
        if let storyShareURL = URL(string: "instagram-stories://share") {
            if UIApplication.shared.canOpenURL(storyShareURL) {
                let renderer = UIGraphicsImageRenderer(size: captureView.bounds.size)
                let renderImage = renderer.image { _ in
                    captureView.drawHierarchy(in: captureView.bounds, afterScreenUpdates: true)
                }
                
                guard let imageData = renderImage.pngData() else { return }
                
                let pasteboardItems : [String:Any] = [
                    "com.instagram.sharedSticker.stickerImage": imageData,
                    "com.instagram.sharedSticker.backgroundTopColor" : "#636e72",
                    "com.instagram.sharedSticker.backgroundBottomColor" : "#b2bec3",
                ]
                let pasteboardOptions = [
                    UIPasteboard.OptionsKey.expirationDate: Date().addingTimeInterval(300)
                ]
                UIPasteboard.general.setItems([pasteboardItems], options: pasteboardOptions)
                
                UIApplication.shared.open(storyShareURL, options: [:], completionHandler: nil)
            }
            else {
                self.makeRequestAlert(title: "알림", message: "인스타그램이 필요합니다.", okAction: nil)
            }
        }
    }
}

//MARK: - BottomSheet Animation
extension RecordDetailBottomSheetViewController {
    func showBottomSheet(){
        UIView.animate(withDuration: 0.3){
            self.bottomSheetHeight.constant = self.view.frame.height / 3
            self.view.layoutIfNeeded()
        }
    }
    
    private func hideBottomSheet(){
        UIView.animate(withDuration: 0.3){
            self.bottomSheetHeight.constant = 0
            self.view.layoutIfNeeded()
        } completion: {[weak self] _ in
            guard let self = self else { return }
            self.dismiss(animated: false)
        }
    }
}
