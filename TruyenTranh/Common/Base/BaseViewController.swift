//
//  BaseViewController.swift
//  MicroInvest
//
//  Created by Trung Hoang Van on 12/5/19.
//  Copyright © 2019 Funtap JSC. All rights reserved.
//

import UIKit
import SDWebImage

class BaseViewController: UIViewController {

    private let indicatorSize:CGFloat = 28.0
    private let loadingProgressLineWidth:CGFloat = 3.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let image = UIImage(named: "ic_left_arrow")
        self.navigationController?.navigationBar.backIndicatorImage = image
        self.navigationController?.navigationBar.backIndicatorTransitionMaskImage = image
        self.navigationController?.navigationBar.tintColor = .white
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: UIBarButtonItem.Style.plain, target: nil, action: nil)
    }
    
    func downloadFileFromUrl(url: String) {
        let fileManager = FileManager.default
        do {
            let documentDirectory = try fileManager.url(for: .documentDirectory, in: .userDomainMask, appropriateFor:nil, create:false)
            let filename = fileName(from: url)
            let fileURL = documentDirectory.appendingPathComponent(filename)
            print("File path: \(fileURL.absoluteString)")
            let message = "Tài liệu sẽ được lưu trong thư mục share của app. Bạn có thể sử dụng iTunes để trích xuất tài liệu."
            let alertControler = UIAlertController.Style.alert.controller(title: "Tải tài liệu?", message: message, actions: [
                "TẢI VỀ".alertAction(style: .default, handler: { (_) in
                    self.showLoading()
                    downloadFileFrom(url: URL(string: url)!, to: fileURL) { (isSuccess) in
                        Toast.showSuccess("Đã tải xong tài liệu")
                        self.hideLoading()
                    }
                }),
                "THÔI".alertAction(style: .cancel, handler: nil)
                ])
            self.present(alertControler, animated: true, completion: nil)
            
        } catch {
            print(error)
        }
    }
    
    func fileName(from url: String) -> String {
        if let filename = URL(string: url)?.lastPathComponent {
            return filename
        }
        return Date().toString()!
    }
    
    func showProgress(color:UIColor? = nil) -> MKActivityIndicator? {
        let loadingProgress = MKActivityIndicator(frame: CGRect(x:0,y:0,width: indicatorSize,height:indicatorSize))
        if let color = color {
            loadingProgress.color = color
        }
        loadingProgress.center = self.view.center
        loadingProgress.lineWidth = loadingProgressLineWidth
        loadingProgress.autoresizingMask = [.flexibleTopMargin, .flexibleLeftMargin, .flexibleBottomMargin, .flexibleRightMargin]
        view.addSubview(loadingProgress)
        loadingProgress.startAnimating()
        return loadingProgress
    }
    
    func hideProgress(_ loadingProgress:MKActivityIndicator?) {
        loadingProgress?.stopAnimating()
        loadingProgress?.removeFromSuperview()
    }
}
