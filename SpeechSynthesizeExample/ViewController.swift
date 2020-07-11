//
//  ViewController.swift
//  SpeechSynthesizeExample
//
//  Created by Hiroki Ishiura on 2020/07/11.
//  Copyright © 2020 Hiroki Ishiura. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
	
	@IBOutlet weak var utteranceTextField: UITextField!
	@IBOutlet weak var speedSlider: UISlider!
	@IBOutlet weak var pitchSlider: UISlider!
	
	private let AVSpeechUtteranceMinimumSpeechPitch: Float = 0.5
	private let AVSpeechUtteranceMaximumSpeechPitch: Float = 2.0
	private let AVSpeechUtteranceDefaultSpeechPitch: Float = 1.0
	
	private let speechSynthesizer = AVSpeechSynthesizer()
	
	
	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view.
		
		utteranceTextField.text = "こんにちわ、世界。"
		utteranceTextField.contentVerticalAlignment = .top
		speedSlider.value = normalizedValue(min: AVSpeechUtteranceMinimumSpeechRate, max: AVSpeechUtteranceMaximumSpeechRate, value: AVSpeechUtteranceDefaultSpeechRate)
		pitchSlider.value = normalizedValue(min: AVSpeechUtteranceMinimumSpeechPitch, max: AVSpeechUtteranceMaximumSpeechPitch, value: AVSpeechUtteranceDefaultSpeechPitch)
	}
	
	@IBAction func say(_ sender: Any) {
		guard let text = utteranceTextField.text, !text.isEmpty else {
			return
		}
		
		let utterance = AVSpeechUtterance(string: text)
		utterance.voice = AVSpeechSynthesisVoice(language: "ja-JP")
		
		utterance.rate = scaledValue(min: AVSpeechUtteranceMinimumSpeechRate, max: AVSpeechUtteranceMaximumSpeechRate, value: speedSlider.value)
		utterance.pitchMultiplier = scaledValue(min: AVSpeechUtteranceMinimumSpeechPitch, max: AVSpeechUtteranceMaximumSpeechPitch, value: pitchSlider.value)
		print("utterance: rate=\(utterance.rate), pitch=\(utterance.pitchMultiplier)")
		
		speechSynthesizer.speak(utterance)
	}
	
	private func normalizedValue(min: Float, max: Float, value: Float) -> Float {
		return (value - min) / (max - min)
	}
	
	private func scaledValue(min: Float, max: Float, value: Float) -> Float {
		return (max - min) * value + min
	}
	
	
}
