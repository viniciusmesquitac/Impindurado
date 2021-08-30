//
//  SpeechRecognizer.swift
//  Impindurado
//
//  Created by Brena Amorim on 29/08/21.
//

import Speech
import UIKit

class SpeechRecognizer {
    
    public var answer: String = ""
    public var lastAnswer: String = ""
    
    // process input audio from microphone
    let audioEngine = AVAudioEngine()
    let speechRecognizer = SFSpeechRecognizer()
    let request = SFSpeechAudioBufferRecognitionRequest()
    var recognitionTask: SFSpeechRecognitionTask?

    var mostRecentlyProcessedSegmentDuration: TimeInterval = 0

    init() {
        
    }
    
    @objc func micButtonPressed(micButton: UIButton) {
        micButton.isSelected = !micButton.isSelected

        if micButton.isSelected {
            // request authorization
            SFSpeechRecognizer.requestAuthorization { [unowned self] (authStatus) in
              switch authStatus {
              case .authorized:
                do {
                  try self.startRecording()
                } catch let error {
                  print("There was a problem starting recording: \(error.localizedDescription)")
                }
              case .denied:
                print("Speech recognition authorization denied")
              case .restricted:
                print("Not available on this device")
              case .notDetermined:
                print("Not determined")
              @unknown default:
                print("Another type error occur")
              }
            }
        } else {
            stopRecording()
        }
        
        print(micButton.isSelected)
        print("button pressed!")
    }
    
    fileprivate func startRecording() throws {
        // reset the tracked duration each time recording starts
        mostRecentlyProcessedSegmentDuration = 0

        let node = audioEngine.inputNode
        let recordingFormat = node.outputFormat(forBus: 0)
        
        node.removeTap(onBus: 0)

        node.installTap(onBus: 0, bufferSize: 32, format: recordingFormat) { [unowned self] (buffer, _) in
            self.request.append(buffer)
        }
        
        audioEngine.prepare()
        try audioEngine.start()
        
        recognitionTask = speechRecognizer?.recognitionTask(with: request) { [unowned self] (result, _) in
          if let transcription = result?.bestTranscription {
            
            self.updateUIWithTranscription(transcription)
            //TEST
            lastAnswer = answer
          }
        }
    }
    
    fileprivate func updateUIWithTranscription(_ transcription: SFTranscription) {
      if let lastSegment = transcription.segments.last,
        lastSegment.duration >= mostRecentlyProcessedSegmentDuration {
        mostRecentlyProcessedSegmentDuration = lastSegment.duration
        self.answer = lastSegment.substring.lowercased()
        print(lastSegment.substring.lowercased())
        if lastSegment.substring.lowercased() != lastAnswer {
            //TEST
            verifyAnswer(userAnswer: answer)
        }
      }
    }
    
    // stop transcription and recording
    fileprivate func stopRecording() {
      audioEngine.stop()
      request.endAudio()
      recognitionTask?.cancel()
    }
    
    func verifyAnswer(userAnswer: String) {
    
    }

}
