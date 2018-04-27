//
//  ViewController.swift
//  ThumbnailPractice
//
//  Created by 梶田悠 on 2018/04/24.
//  Copyright © 2018年 梶田悠. All rights reserved.
//

//----------------------------------------
//動画からサムネイルを作成するサンプルプロジェクト
//----------------------------------------

import UIKit
import AVKit
import AVFoundation

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    let imagePickerController = UIImagePickerController()
    var videoURL: URL?
    
    
    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func tapSelectVideoButton(_ sender: Any) {
        print("UIBarButtonItem。カメラロールから動画を選択")
        imagePickerController.sourceType = .photoLibrary
        imagePickerController.delegate = self
        imagePickerController.mediaTypes = ["public.image", "public.movie"]
        present(imagePickerController, animated: true, completion: nil)
    }
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {

        //動画はこっち
        if info[UIImagePickerControllerMediaURL] != nil {
            print("動画あるよ！")
            
            let url = info[UIImagePickerControllerMediaURL] as! URL
            print(url)
            imageView.image = getThumbnail(url)
            
        } else {
            print("動画nilだよ！")
        }
        
        imagePickerController.dismiss(animated: true, completion: nil)
    }
    
    func getThumbnail(_ url: URL) -> UIImage? {
        print("サムネイル作ります！")
        let asset = AVAsset(url: url)
        print(asset.duration)//アセットできてるっぽい
        let imageGenerator = AVAssetImageGenerator(asset: asset)
        var time = asset.duration
        time.value = min(time.value, 2)
        do{
            let imageRef = try imageGenerator.copyCGImage(at: time, actualTime: nil)
            print("サムネ作成できたよ！")
            return UIImage(cgImage: imageRef)
        }catch{
            print("失敗じゃ...")
        }
        return nil
    }
    
}
