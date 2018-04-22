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
        
        btAddProduct.isEnabled = true
        btAddProduct.backgroundColor = .blue
        
        tfValue.keyboardType = .decimalPad
        
        if product != nil {
            tfProductName.text = product.name
            tfPruductState.text = product.states?.name
            tfValue.text = String(product.value)
            swCard.setOn(product.card, animated: false)
            btAddProduct.setTitle("Atualizar", for: .normal)
            if let imagePoster = product.title as? UIImage {
                ivImage.image = imagePoster
            }
            btAddProduct.isEnabled = true
            btAddProduct.backgroundColor = .green
        }
        let tap = UITapGestureRecognizer(target: self, action: #selector(AddProductViewController.changePoster))
        
        ivImage.addGestureRecognizer(tap)
        setupPickerView()
        
        
    }
    deinit {
        tfProductName.removeTarget(self, action: #selector(editingChanged), for: .editingChanged)
        tfPruductState.removeTarget(self, action: #selector(editingChanged), for: .editingChanged)
        tfValue.removeTarget(self, action: #selector(editingChanged), for: .editingChanged)
        
    }
    
  @objc  func editingChanged(_ textField: UITextField) {
        guard
            let productName = tfProductName.text, !productName.isEmpty,
            let stateProduct = tfPruductState.text, !stateProduct.isEmpty,
            let valor = tfValue.text, !valor.isEmpty
            else {
                btAddProduct.isEnabled = false
                btAddProduct.backgroundColor = .gray
                return
        }
        btAddProduct.isEnabled = true
        btAddProduct.backgroundColor = .blue
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //Dessa forma, podemos voltar à tela anterior
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        dismiss(animated: true, completion: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        loadStates()
    }
    
    func selectPicture(sourceType: UIImagePickerControllerSourceType) {
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = sourceType
        imagePicker.delegate = self
        present(imagePicker, animated: true, completion: nil)
    }
    
    func loadStates() {
        let fetchRequest: NSFetchRequest<State> = State.fetchRequest()
        let sortDescriptor = NSSortDescriptor(key: "name", ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptor]
        do {
            data = try context.fetch(fetchRequest)
        } catch {
            print(error.localizedDescription)
        }
    }
    
  @objc  func changePoster() {
        let alert = UIAlertController(title: "Selecionar poster", message: "De onde você quer escolher o poster?", preferredStyle: .actionSheet)
        
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            let cameraAction = UIAlertAction(title: "Câmera", style: .default, handler: { (action: UIAlertAction) in
                self.selectPicture(sourceType: .camera)
            })
            alert.addAction(cameraAction)
        }
        
        let libraryAction = UIAlertAction(title: "Biblioteca de fotos", style: .default) { (action: UIAlertAction) in
            self.selectPicture(sourceType: .photoLibrary)
        }
        alert.addAction(libraryAction)
        
        let photosAction = UIAlertAction(title: "Álbum de fotos", style: .default) { (action: UIAlertAction) in
            self.selectPicture(sourceType: .savedPhotosAlbum)
        }
        alert.addAction(photosAction)
        
        let cancelAction = UIAlertAction(title: "Cancelar", style: .cancel, handler: nil)
        alert.addAction(cancelAction)
        
        present(alert, animated: true, completion: nil)
    }
    
    func setupPickerView() {
        pickerView = UIPickerView()
        pickerView.backgroundColor = .white
        pickerView.delegate = self
        pickerView.dataSource = self
        
        let toolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 44))
        let btCancel = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(tfPruductState.resignFirstResponder))
        let btSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let btDone = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(fubtDone))
        toolbar.items = [btCancel, btSpace, btDone]
        
        tfPruductState.inputView = pickerView
        tfPruductState.inputAccessoryView = toolbar
    }
    
    @objc func fubtDone() {
        tfPruductState.text = data[pickerView.selectedRow(inComponent:0)].name
        tfPruductState.resignFirstResponder()
    }
    
    

    
    @IBAction func btAddProduct(_ sender: Any) {
        if product == nil { product = Product(context: context) }
        product.name = tfProductName.text
        product.title = ivImage.image
        if let indexState = data.index(where: { $0.name  == tfPruductState.text!}) {
            product.states = data[indexState]
        }
        product.value = Double( tfValue.text! )!
        product.card = swCard.isOn
        if smallImage != nil {
            product.title = smallImage
        }
        do {
            try context.save()
            navigationController?.popViewController(animated: true)
            
        } catch {
            print(error.localizedDescription)
            navigationController?.popViewController(animated: true)
        }
    }
    
}

// MARK: - extensions
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



