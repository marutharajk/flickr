//
//  Speech.swift
//  ImageDetector
//
//  Created by Marutharaj K on 17/09/21.
//

import Speech
import SwiftUI

public class Speech: ObservableObject {
    
    /* Variables **/
    @Published public var isRecording: Bool = false
    
    private let speechRecognizer = SFSpeechRecognizer(locale: Locale(identifier: "en-US"))
    private var recognitionRequest: SFSpeechAudioBufferRecognitionRequest?
    private let authStatus = SFSpeechRecognizer.authorizationStatus()
    private var recognitionTask: SFSpeechRecognitionTask?
    private let audioEngine = AVAudioEngine()
    public var outputText: String = .init()
    
    public init() {
        recognitionTask?.cancel()
        self.recognitionTask = nil
    }
    
    // starts the recording sequence
    public func startRecording() {
        
        // restarts the text
        outputText = ""
        
        // Configure the audio session for the app.
        let audioSession = AVAudioSession.sharedInstance()
        let inputNode = audioEngine.inputNode
        
        // try catch to start audio session
        do {
            try audioSession.setCategory(.record, mode: .measurement, options: .duckOthers)
            try audioSession.setActive(true, options: .notifyOthersOnDeactivation)
        } catch {
            Log.e("ERROR: - Audio Session Failed!")
        }
        
        // Configure the microphone input and request auth
        let recordingFormat = inputNode.outputFormat(forBus: 0)
        inputNode.installTap(onBus: 0, bufferSize: 1024, format: recordingFormat) { (buffer: AVAudioPCMBuffer, when: AVAudioTime) in
            self.recognitionRequest?.append(buffer)
        }
        
        audioEngine.prepare()
        
        do {
            try audioEngine.start()
        } catch {
            Log.e("ERROR: - Audio Engine failed to start")
        }
        
        // Create and configure the speech recognition request.
        recognitionRequest = SFSpeechAudioBufferRecognitionRequest()
        guard let recognitionRequest = recognitionRequest else {
            fatalError("Unable to create a SFSpeechAudioBufferRecognitionRequest object")
        }
        
        recognitionRequest.shouldReportPartialResults = true
        
        // Create a recognition task for the speech recognition session.
        recognitionTask = speechRecognizer?.recognitionTask(with: recognitionRequest) { result, error in
            if result != nil {
                self.outputText = (result?.transcriptions[0].formattedString)!
            }
            if let result = result {
                // Update the text view with the results.
                self.outputText = result.transcriptions[0].formattedString
            }
            if error != nil {
                // Stop recognizing speech if there is a problem.
                self.audioEngine.stop()
                inputNode.removeTap(onBus: 0)
                self.recognitionRequest = nil
                self.recognitionTask = nil
                
            }
        }
    }
    
    /// End recording
    public func stopRecording() {
        
        audioEngine.stop()
        recognitionRequest?.endAudio()
        self.audioEngine.inputNode.removeTap(onBus: .zero)
        self.recognitionTask?.cancel()
        self.recognitionTask = nil
    }
    
    // gets the status of authorization
    public func getSpeechStatus() -> SFSpeechRecognizerAuthorizationStatus {
        return authStatus
    }
    
    /// Speech authorization
    public func requestTranscribePermissions() {
        SFSpeechRecognizer.requestAuthorization { authStatus in
            DispatchQueue.main.async {
                if authStatus == .authorized {
                    Log.i("Speech: Good to go!")
                } else {
                    Log.i("Transcription permission was declined.")
                }
            }
        }
    }
}
