//
//  ViewController.swift
//  SpeechSynthesizeExample
//
//  Created by Hiroki Ishiura on 2020/07/11.
//  Copyright © 2020 Hiroki Ishiura. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController, AVSpeechSynthesizerDelegate {
	
	@IBOutlet weak var utteranceTextField: UITextField!
	@IBOutlet weak var speedSlider: UISlider!
	@IBOutlet weak var pitchSlider: UISlider!
	@IBOutlet weak var sayButton: UIButton!
	
	private let AVSpeechUtteranceMinimumSpeechPitch: Float = 0.5
	private let AVSpeechUtteranceMaximumSpeechPitch: Float = 2.0
	private let AVSpeechUtteranceDefaultSpeechPitch: Float = 1.0
	
	private var speechSynthesizer: AVSpeechSynthesizer!
	
	
	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view.
		
		utteranceTextField.text = "こんにちわ、世界。"
		utteranceTextField.contentVerticalAlignment = .top
		speedSlider.minimumValue = AVSpeechUtteranceMinimumSpeechRate
		speedSlider.maximumValue = AVSpeechUtteranceMaximumSpeechRate
		speedSlider.value = AVSpeechUtteranceDefaultSpeechRate
		pitchSlider.minimumValue = AVSpeechUtteranceMinimumSpeechPitch
		pitchSlider.maximumValue = AVSpeechUtteranceMaximumSpeechPitch
		pitchSlider.value = AVSpeechUtteranceDefaultSpeechPitch
		
		speechSynthesizer = AVSpeechSynthesizer()
		speechSynthesizer.delegate = self
	}
	
	@IBAction func say(_ sender: Any) {
		guard let text = utteranceTextField.text, !text.isEmpty else {
			return
		}
		
		let utterance = AVSpeechUtterance(string: text)
		utterance.voice = AVSpeechSynthesisVoice(language: "ja-JP")
		
		utterance.rate = speedSlider.value
		utterance.pitchMultiplier = pitchSlider.value
		print("utterance: rate=\(utterance.rate), pitch=\(utterance.pitchMultiplier)")
		
		enableControls(false)
		speechSynthesizer.speak(utterance)
	}
	
	func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer, didFinish utterance: AVSpeechUtterance) {
		enableControls(true)
	}
	
	private func enableControls(_ enable: Bool) {
		utteranceTextField.isEnabled = enable
		speedSlider.isEnabled = enable
		pitchSlider.isEnabled = enable
		sayButton.isEnabled = enable
	}
	
	
}
