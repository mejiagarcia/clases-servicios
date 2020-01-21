//
//  ViewController.swift
//  Aprendiendo-Seevicios
//
//  Created by Luis Carlos Mejia Garcia on 21/01/20.
//  Copyright © 2020 Platzi. All rights reserved.
//

import UIKit
import Alamofire

// 1. Crear modelo Codable (estructura) - OK
// 2. Utilizar JSONDecoder para serializar Data a Modelo - OK

struct Human: Codable {
    let user: String
    let age: Int
    let isHappy: Bool
}

class ViewController: UIViewController {
    // MARK: - Referencias UI
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchService()
    }
    
    // Endpoint: http://www.mocky.io/v2/5e2674472f00002800a4f417
    // 1. Crear expeción de seguridad - Ok
    // 2. Crear URL con el endpoint. - OK
    // 3. Hacer request con la ayuda de URLSession - OK
    // 4. Transformar respuesta a diccionario - OK
    // 5. Ejecutar Request - OK
    private func fetchService() {
        let endpointString = "http://www.mocky.io/v2/5e2674472f00002800a4f417"
        
        guard let endpoint = URL(string: endpointString) else {
            return
        }
        
        // Iniciamos el Loader
        activityIndicator.startAnimating()
        
        AF.request(endpoint, method: .get, parameters: nil).responseData { (response: AFDataResponse<Data>) in
            // Detener el loader
            DispatchQueue.main.async {
                self.activityIndicator.stopAnimating()
            }
            
            
            if response.error != nil {
                print("Hubo un error!")
                
                return
            }
            
            guard
                let dataFromService = response.data,
                let model: Human = try? JSONDecoder().decode(Human.self, from: dataFromService) else {
                    
                return
            }
            
            // Importante: TODOS los llamados a la UI, se hacen en el main thread (pregunta de entrevista)
            DispatchQueue.main.async {
                self.nameLabel.text = model.user
                self.statusLabel.text = model.isHappy ? "Es feliz!" : "Es triste!"
            }
        }
    }
}

