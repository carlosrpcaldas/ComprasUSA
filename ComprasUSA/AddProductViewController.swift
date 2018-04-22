//
//  AddProductViewController.swift
//  ComprasUSA
//
//  Created by admin on 4/19/18.
//  Copyright © 2018 Carlos P Caldas. All rights reserved.
//
import CoreData
import UIKit

class AddProductViewController: UIViewController {
    
    
    @IBOutlet weak var tfProductName: UITextField!
    @IBOutlet weak var ivImage: UIImageView!
    @IBOutlet weak var tfPruductState: UITextField!
    @IBOutlet weak var tfValue: UITextField!
    @IBOutlet weak var swCard: UISwitch!
    @IBOutlet weak var btAddProduct: UIButton!
    
    // MARK: - Properties
    var data: [State] = []
    var product: Product!
    var pickerView: UIPickerView!
    var smallImage: UIImage!
    
    
   // MARK: - viewDidLoad

    override func viewDidLoad() {
        super.viewDidLoad()

  // Ajuste das bordas do botao
        self.tfProductName.layer.borderColor = UIColor(red: 100/255, green: 100/255, blue: 100/255, alpha: 1).cgColor
        self.tfProductName.layer.borderWidth = CGFloat(Float(1.0));
        self.tfProductName.layer.cornerRadius = CGFloat(Float(5.0))
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //Dessa forma, podemos voltar à tela anterior
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        dismiss(animated: true, completion: nil)
    }
    


}


extension AddProductViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingImage image: UIImage, editingInfo: [String: AnyObject]?) {
        
        let smallSize = CGSize(width: 300, height: 280)
        UIGraphicsBeginImageContext(smallSize)
        image.draw(in: CGRect(x: 0, y: 0, width: smallSize.width, height: smallSize.height))
        smallImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        ivImage.image = smallImage
        dismiss(animated: true, completion: nil)
    }
}

extension AddProductViewController: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return data[row].name
    }
}

extension AddProductViewController: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return data.count
    }
}



