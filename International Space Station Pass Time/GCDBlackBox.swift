//
//  GCDBlackBox.swift
//  International Space Station Pass Time
//
//  Created by Yugandhara Lad More on 1/11/18.
//  Copyright © 2018 Yugandhara Lad. All rights reserved.
//

import Foundation

func performUIUpdateOnMain(_ updates: @escaping () -> Void) {
    
    DispatchQueue.main.async {
        updates()
    }
}




