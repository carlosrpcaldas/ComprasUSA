//
//  AddProductViewController.swift
//  ComprasUSA
//
//  Created by admin on 4/19/18.
//  Copyright © 2018 Carlos P Caldas. All rights reserved.
//

import UIKit

class AddProductViewController: UIViewController {
    
    
    @IBOutlet weak var tfProductName: UITextField!
    

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
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
