//
//  SoundButton.swift
//  Impindurado
//
//  Created by Vinicius Mesquita on 10/08/21.
//

import UIKit

class SoundButton: UIButton {

    var isMuted: Bool = false {
        didSet {
            self.setImage(isMuted ? R.image.ic_sound_off() : R.image.ic_sound_on(), for: .normal)
            Sound.enabled = !isMuted
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setImage(isMuted ? R.image.ic_sound_off() : R.image.ic_sound_on(), for: .normal)
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
}
