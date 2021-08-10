//
//  GameOverViewController.swift
//  MeatGame
//
//  Created by 최연정 on 2021/08/03.
//
import Foundation
import UIKit

class GameOverViewController: UIViewController {

    @IBOutlet weak var ImageView: UIImageView!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var scoreText: UILabel!
    var score : Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if score >= 5000 {
            scoreText.text = "성공!"
            scoreLabel.text = "\(score)"
        } else {
            scoreText.text = "실패!"
            scoreLabel.text = "\(score)"
        }
        	
    }
    @IBAction func RestartBtn(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    override var shouldAutorotate: Bool{
        return true
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask{
        return .landscapeLeft
    }
    
    override var preferredInterfaceOrientationForPresentation: UIInterfaceOrientation{
        return .landscapeLeft
    }
}
