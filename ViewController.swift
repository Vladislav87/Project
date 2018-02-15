//
//  ViewController.swift
//  ICoach
//
//  Created by Владислав Ходеев on 02.05.17.
//  Copyright © 2017 Владислав Ходеев. All rights reserved.
//

import UIKit
import Speech


@available(iOS 10.0, *)
class ViewController: UIViewController,SFSpeechRecognizerDelegate {
    
    @IBOutlet weak var question: UILabel!
    @IBOutlet weak var answer: UILabel!
    @IBOutlet weak var goal: UITextView!
    @IBOutlet weak var steps: UITextView!
    
    let audio_engine = AVAudioEngine()
    
var speechRecognizer:SFSpeechRecognizer? = SFSpeechRecognizer()
    
    private var request: SFSpeechAudioBufferRecognitionRequest?
    private var recognitionTask: SFSpeechRecognitionTask?
    
    
    
    
    var goal_question_array = [String]()
    


    override func viewDidLoad() {
        super.viewDidLoad()
        
     speechRecognizer = SFSpeechRecognizer(locale: Locale.init(identifier: "ru-RU"))

         speechRecognizer?.delegate = self
        goal_question_array = ["Чего вы хотите?", "Почему это для вас важно?","Если бы ты знал, что можешь достичь всего, чего пожелаешь, как тогда звучала бы твоя цель?","Как ты узнаешь, что достиг результата?"]
        
        let first_q = goal_question_array[0]
        question.text = first_q
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: recordAndRecognizeSpeech METHOD
    func recordAndRecognizeSpeech(){
        guard let node = audio_engine.inputNode else {return}
        let recordingFormat = node.outputFormat(forBus: 0)
        node.installTap(onBus: 0, bufferSize: 1024, format: recordingFormat){ buffer, _ in
            self.request?.append(buffer)
        }
        audio_engine.prepare()
        do {
            try audio_engine.start()
        }catch {
            return print(error)
        }
        guard let myRecognizer = SFSpeechRecognizer() else {
            return
        }
        if !myRecognizer.isAvailable{
            return
        }
        
        recognitionTask = speechRecognizer?.recognitionTask(with: request!, resultHandler: { result, error in
            if self.question.text == self.goal_question_array[0]{
            
        } else if let result = result {
                let answer_string = result.bestTranscription.formattedString
                self.answer.text = answer_string
                
                
                
            } else if let error = error {
                print(error)
            }
        })
        
    }
    
    func coach_algotithm(){
        
        //написать алгоритм задавания и отвечания
        
        
    }
    
    

    @IBAction func startCoaching(_ sender: UIButton){
        self.recordAndRecognizeSpeech()
        
    }
    

}

