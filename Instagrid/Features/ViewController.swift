//
//  ViewController.swift
//  Instagrid
//
//  Created by Mohammad Olwan on 31/08/2021.
//

import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var image1: UIButton!
    @IBOutlet weak var image2: UIButton!
    @IBOutlet weak var image3: UIButton!
    @IBOutlet weak var image4: UIButton!
    @IBOutlet weak var selectAllImage: UIImageView!
    @IBOutlet weak var selectUpImage: UIImageView!
    @IBOutlet weak var selectDownImage: UIImageView!
  
    @IBOutlet weak var view2: UIView!
    @IBOutlet weak var view4: UIView!
    @IBOutlet weak var selectAll: UIButton!
    @IBOutlet weak var selectDown: UIButton!
    @IBOutlet weak var selectUp: UIButton!
    
    var anyButton = 1
    
    var swipeGesture: UISwipeGestureRecognizer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        swipeGesture = UISwipeGestureRecognizer(target: self, action: #selector(shareImage(_:)))
        swipeGesture.direction = .up
        self.view.addGestureRecognizer(swipeGesture)
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        

        if UIDevice.current.orientation.isLandscape {
            swipeGesture.direction = .left
        } else {
            swipeGesture.direction = .up
        }
    }
    

   @objc func shareImage(_ sender: UISwipeGestureRecognizer) {
        moveForword()
    
       // if UIDevice.current.orientation.isPortrait {
            let imageToShare = UIImage.image(with: mainView)
            let activityController = UIActivityViewController(activityItems: [imageToShare!],
                                                              applicationActivities: nil)
            activityController.completionWithItemsHandler = { (_, _, _, _) in
                self.moveBack()
            }
            self.present(activityController, animated: true, completion: nil)
    }
    
    @IBAction func selectImage(_ sender: UIButton) {
        anyButton = sender.tag
        openAlert()
    }
    
    @IBAction func selectUpRect(_ sender: Any) {
        setUpmainView(status: .rectangleUp)
    }
    
    @IBAction func selectAllRect(_ sender: Any) {
        setUpmainView(status: .fourSquare)
    }
    
    @IBAction func selectDownRect(_ sender: Any) {
        setUpmainView(status: .rectangleDown)
    }
    
    
    func setUpmainView(status: Layout) {
       switch status {

       case .fourSquare:
        
        selectAllImage.isHidden = false
        selectUpImage.isHidden = true
        selectDownImage.isHidden = true
        view2.isHidden = false
        view4.isHidden = false
        
       case .rectangleUp:
        
        selectAllImage.isHidden = true
        selectUpImage.isHidden = false
        selectDownImage.isHidden = true
        view4.isHidden = false
        view2.isHidden = true
        
       case .rectangleDown:
        
        selectAllImage.isHidden = true
        selectUpImage.isHidden = true
        selectDownImage.isHidden = false
        view2.isHidden = false
        view4.isHidden = true
       }
    }
    
    func openAlert(){
        let image = UIImagePickerController()
        image.delegate = self
        // Alert to ask user camera or librairie
        let alert = UIAlertController(title: "Source des photos", message: "Choisissez une source", preferredStyle: .actionSheet)
        
        alert.addAction(UIAlertAction(title: "Galerie de photos", style: .default, handler: { (action:UIAlertAction) in
            image.sourceType = .photoLibrary
            image.allowsEditing = true
            self.present(image, animated: true)}))
        
        // If the camera isn't available, no need to showing this option
        if UIImagePickerController.isSourceTypeAvailable(.camera){
            alert.addAction(UIAlertAction(title: "Caméra", style: .default, handler: { (action:UIAlertAction) in
                image.sourceType = .camera
                image.allowsEditing = true
                self.present(image, animated: true)}))
        }
        alert.addAction(UIAlertAction(title: "Annuler", style: .cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true)
            if let imageSelected = info[.editedImage] as? UIImage {
            switch anyButton {
            case 1: image1.setImage(imageSelected, for: .normal)
            case 2: image2.setImage(imageSelected, for: .normal)
            case 3: image3.setImage(imageSelected, for: .normal)
            case 4: image4.setImage(imageSelected, for: .normal)
            default: return
            }
        }
    }
    
   
    func moveForword() {
        let width = self.view.frame.width
        let height = self.view.frame.height
        
        if UIDevice.current.orientation == UIDeviceOrientation.landscapeLeft || UIDevice.current.orientation == UIDeviceOrientation.landscapeRight {
            UIView.animate(withDuration: 0.5, delay: 0.0, options: [], animations: {
                self.mainView.transform = CGAffineTransform(translationX: -width, y: 0)
            },completion: nil)
        }
        
         if UIDevice.current.orientation == UIDeviceOrientation.portrait
        {
            UIView.animate(withDuration: 0.5, delay: 0.0, options: [], animations: {
                self.mainView.transform = CGAffineTransform(translationX: 0, y: -height)
            }, completion: nil)
        }
        else if UIDevice.current.orientation == UIDeviceOrientation.portraitUpsideDown
        {
            UIView.animate(withDuration: 0.5, delay: 0.0, options: [], animations: {
                self.mainView.transform = CGAffineTransform(translationX: -width, y: 0)
            }, completion: nil)
        }
    }
    
    func moveBack(){
        UIView.animate(withDuration: 0.5, delay: 0.0, options: [], animations: { self.mainView.transform = .identity
        }, completion: nil)
    }
    
}
