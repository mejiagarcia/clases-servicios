//
//  ViewController.swift
//  Aprendiendo-Seevicios
//
//  Created by Luis Carlos Mejia Garcia on 21/01/20.
//  Copyright © 2020 Platzi. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    // MARK: - Referencias UI
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    // Endpoint: http://www.mocky.io/v2/5e2674472f00002800a4f417
    // 1. Crear expeción de seguridad - Ok
    // 2. Crear URL con el endpoint. - OK
    // 3. Hacer request con la ayuda de URLSession
    // 4. Transformar respuesta a diccionario
    // 5. Ejecutar Request
    private func fetchService() {
        let endpointString = "http://www.mocky.io/v2/5e2674472f00002800a4f417"
        
        guard let endpoint = URL(string: endpointString) else {
            return
        }
        
        URLSession.shared.dataTask(with: endpoint) { (data: Data?, _, error: Error?) in
            if error != nil {
                print("Hubo un error!")
                
                return
            }
            
            guard let dataFromService = data,
                let dictionary = try? JSONSerialization.jsonObject(with: dataFromService, options: []) as? [String: Any] else {
                    
                return
            }
            
            self.nameLabel.text = dictionary["user"] as? String
        }
    }
}

