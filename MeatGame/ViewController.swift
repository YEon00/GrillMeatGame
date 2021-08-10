//
//  ViewController.swift
//  MeatGame
//
//  Created by 최연정 on 2021/08/02.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var lifeCount1: UIImageView!
    @IBOutlet weak var lifeCount2: UIImageView!
    @IBOutlet weak var lifeCount3: UIImageView!
    @IBOutlet weak var lifeCount4: UIImageView!
    @IBOutlet weak var lifeCount5: UIImageView!
    
    
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var preScoreLabel: UILabel!
    
    @IBOutlet weak var rawMeat: UIButton!
    
    @IBOutlet weak var meatBtn1: UIButton!
    @IBOutlet weak var meatBtn2: UIButton!
    @IBOutlet weak var meatBtn3: UIButton!
    @IBOutlet weak var meatBtn4: UIButton!
    @IBOutlet weak var meatBtn5: UIButton!
    @IBOutlet weak var meatBtn6: UIButton!
    
    
    let meatImage = [UIImage(named: "gogi3"),UIImage(named: "gogi6"),UIImage(named: "gogi9"),UIImage(named: "gogi12"),UIImage(named: "gogi15"),UIImage(named: "gogi18")]
    let meatImage1 = [UIImage(named: "gogi2"),UIImage(named: "gogi5"),UIImage(named: "gogi8"),UIImage(named: "gogi11"),UIImage(named: "gogi14"),UIImage(named: "gogi17")]
    
    var score = 0
    var prescore = 0
    var lifeCount = 5
    
    // 메인 타이머 선언
    var mainTimerCount : Int = 60
    var mainTimer : Timer!
    var mainTimerStart : Bool = false
    
    var rawMeatClicked : Bool = false
    
    var grillMeatStart : [Bool] = [false,false,false,false,false,false]
    
    var frontMeatTimerCount = [0,0,0,0,0,0]
    var backMeatTimerCount = [0,0,0,0,0,0]
    
    var meatState : [Bool] = [false,false,false,false,false,false]
    var meatRandNumber = [0,0,0,0,0,0]
    
    var meatFrontTimer0:Timer = Timer()
    var meatFrontTimer1:Timer = Timer()
    var meatFrontTimer2:Timer = Timer()
    var meatFrontTimer3:Timer = Timer()
    var meatFrontTimer4:Timer = Timer()
    var meatFrontTimer5:Timer = Timer()
    
    var meatBackTimer0:Timer = Timer()
    var meatBackTimer1:Timer = Timer()
    var meatBackTimer2:Timer = Timer()
    var meatBackTimer3:Timer = Timer()
    var meatBackTimer4:Timer = Timer()
    var meatBackTimer5:Timer = Timer()
    
    
    var meatIndex : Int = -1
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    override func viewDidDisappear(_ animated: Bool) {
        mainTimerCount = 60
        initGame()
        initTimer()
    }
    override func viewDidAppear(_ animated: Bool) {
        mainLoop()
    }
    
    
    //화면 가로로 설정
    override var shouldAutorotate: Bool{
        return true
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask{
        return .landscapeLeft
    }

    override var preferredInterfaceOrientationForPresentation: UIInterfaceOrientation{
        return .landscapeLeft
    }

    //생 모듬고기 선택
    @IBAction func rawMeatClick(_ sender: Any) {
        if !rawMeatClicked {
            rawMeatClicked = true
        } else {
            rawMeatClicked = false
        }
    }
    
    //MARK: 버튼 클릭
    @IBAction func meatBtn1(_ sender: UIButton) {
        meatIndex = 0
        if frontMeatTimerCount[meatIndex] == -1 && backMeatTimerCount[meatIndex] == -1 {
            meatFrontTimer0.invalidate()
            meatBackTimer0.invalidate()
            frontMeatTimerCount[meatIndex] = 0
            backMeatTimerCount[meatIndex] = 0
            grillMeatStart[meatIndex] = false
        }
        if rawMeatClicked {
            if !grillMeatStart[meatIndex] {
                meatState[meatIndex] = true // 고기 앞면이 보이는 상태
                self.meatBtn1.setImage(self.meatImage[0],for: .normal)
                meatBackTimerSetting(meatIndex: meatIndex)
            } else {
                print("이미 굽고 있습니다")
            }
        } else {
            if grillMeatStart[meatIndex] {
                if meatState[meatIndex] { //고기 앞면이 보이는 상태 였다면
                    meatBackTimer0.invalidate()
                    meatState[meatIndex] = false
                    if backMeatTimerCount[meatIndex] >= 0 && backMeatTimerCount[meatIndex] < 3 {
                        self.meatBtn1.setImage(self.meatImage[1],for: .normal)
                    } else if backMeatTimerCount[meatIndex] <= 7{
                        self.meatBtn1.setImage(self.meatImage[3], for: .normal)
                    } else if backMeatTimerCount[meatIndex] > 7 {
                        self.meatBtn1.setImage(self.meatImage[5], for: .normal)
                    }
                    meatFrontTimerSetting(meatIndex: meatIndex)
                } else {
                    meatFrontTimer0.invalidate()
                    meatState[meatIndex] = true
                    if frontMeatTimerCount[meatIndex] >= 0 && frontMeatTimerCount[meatIndex] < 3 {
                        self.meatBtn1.setImage(self.meatImage[0],for: .normal)
                    } else if frontMeatTimerCount[meatIndex] <= 7 {
                        self.meatBtn1.setImage(self.meatImage[2], for: .normal)
                    } else if frontMeatTimerCount[meatIndex] > 7 {
                        self.meatBtn1.setImage(self.meatImage[4], for: .normal)
                    }
                    meatBackTimerSetting(meatIndex: meatIndex)
                }
            } else {
                print("모듬 고기를 선택해 주세요")
            }
        }
        
        
    }

    
    
    @IBAction func meatBtn2(_ sender: Any) {
        meatIndex = 1
        if frontMeatTimerCount[meatIndex] == -1 && backMeatTimerCount[meatIndex] == -1 {
            meatFrontTimer1.invalidate()
            meatBackTimer1.invalidate()
            frontMeatTimerCount[meatIndex] = 0
            backMeatTimerCount[meatIndex] = 0
            grillMeatStart[meatIndex] = false
        }
        if rawMeatClicked {
            if !grillMeatStart[meatIndex] {
                meatState[meatIndex] = true // 고기 앞면이 보이는 상태
                self.meatBtn2.setImage(self.meatImage1[0],for: .normal)
                meatBackTimerSetting(meatIndex: meatIndex)
            } else {
                print("이미 굽고 있습니다")
            }
        } else {
            if grillMeatStart[meatIndex] {
                if meatState[meatIndex] { //고기 앞면이 보이는 상태 였다면
                    meatBackTimer1.invalidate()
                    meatState[meatIndex] = false
                    if backMeatTimerCount[meatIndex] >= 0 && backMeatTimerCount[meatIndex] <= 3 {
                        self.meatBtn2.setImage(self.meatImage1[1],for: .normal)
                    } else if backMeatTimerCount[meatIndex] <= 7 {
                        self.meatBtn2.setImage(self.meatImage1[3], for: .normal)
                    } else if backMeatTimerCount[meatIndex] > 7 {
                        self.meatBtn2.setImage(self.meatImage1[5], for: .normal)
                    }
                    meatFrontTimerSetting(meatIndex: meatIndex)
                } else {
                    meatFrontTimer1.invalidate()
                    meatState[meatIndex] = true
                    if frontMeatTimerCount[meatIndex] >= 0 && frontMeatTimerCount[meatIndex] <= 3 {
                        self.meatBtn2.setImage(self.meatImage1[0],for: .normal)
                    } else if frontMeatTimerCount[meatIndex] <= 7 {
                        self.meatBtn2.setImage(self.meatImage1[2], for: .normal)
                    } else if frontMeatTimerCount[meatIndex] > 7 {
                        self.meatBtn2.setImage(self.meatImage1[4], for: .normal)
                    }
                    meatBackTimerSetting(meatIndex: meatIndex)
                }
            } else {
                print("모듬 고기를 선택해 주세요")
            }
        }
        
    }
    
    
    @IBAction func meatBtn3(_ sender: Any) {
        meatIndex = 2
        if frontMeatTimerCount[meatIndex] == -1 && backMeatTimerCount[meatIndex] == -1 {
            meatFrontTimer2.invalidate()
            meatBackTimer2.invalidate()
            frontMeatTimerCount[meatIndex] = 0
            backMeatTimerCount[meatIndex] = 0
            grillMeatStart[meatIndex] = false
        }
        if rawMeatClicked {
            if !grillMeatStart[meatIndex] {
                meatState[meatIndex] = true // 고기 앞면이 보이는 상태
                self.meatBtn3.setImage(self.meatImage[0],for: .normal)
                meatBackTimerSetting(meatIndex: meatIndex)
            } else {
                print("이미 굽고 있습니다")
            }
        } else {
            if grillMeatStart[meatIndex] {
                if meatState[meatIndex] { //고기 앞면이 보이는 상태 였다면
                    meatBackTimer2.invalidate()
                    meatState[meatIndex] = false
                    if backMeatTimerCount[meatIndex] >= 0 && backMeatTimerCount[meatIndex] <= 3 {
                        self.meatBtn3.setImage(self.meatImage[1],for: .normal)
                    } else if backMeatTimerCount[meatIndex] <= 7 {
                        self.meatBtn3.setImage(self.meatImage[3], for: .normal)
                    } else if backMeatTimerCount[meatIndex] > 7 {
                        self.meatBtn3.setImage(self.meatImage[5], for: .normal)
                    }
                    meatFrontTimerSetting(meatIndex: meatIndex)
                } else {
                    meatFrontTimer2.invalidate()
                    meatState[meatIndex] = true
                    if frontMeatTimerCount[meatIndex] >= 0 && frontMeatTimerCount[meatIndex] <= 3 {
                        self.meatBtn3.setImage(self.meatImage[0],for: .normal)
                    } else if frontMeatTimerCount[meatIndex] <= 7 {
                        self.meatBtn3.setImage(self.meatImage[2], for: .normal)
                    } else if frontMeatTimerCount[meatIndex] > 7 {
                        self.meatBtn3.setImage(self.meatImage[4], for: .normal)
                    }
                    meatBackTimerSetting(meatIndex: meatIndex)
                }
            } else {
                print("모듬 고기를 선택해 주세요")
            }
        }
        
    }
    @IBAction func meatBtn4(_ sender: Any) {
        meatIndex = 3
        if frontMeatTimerCount[meatIndex] == -1 && backMeatTimerCount[meatIndex] == -1 {
            meatFrontTimer3.invalidate()
            meatBackTimer3.invalidate()
            frontMeatTimerCount[meatIndex] = 0
            backMeatTimerCount[meatIndex] = 0
            grillMeatStart[meatIndex] = false
        }
        if rawMeatClicked {
            if !grillMeatStart[meatIndex] {
                meatState[meatIndex] = true // 고기 앞면이 보이는 상태
                self.meatBtn4.setImage(self.meatImage1[0],for: .normal)
                meatBackTimerSetting(meatIndex: meatIndex)
            } else {
                print("이미 굽고 있습니다")
            }
        } else {
            if grillMeatStart[meatIndex] {
                if meatState[meatIndex] { //고기 앞면이 보이는 상태 였다면
                    meatBackTimer3.invalidate()
                    meatState[meatIndex] = false
                    if backMeatTimerCount[meatIndex] >= 0 && backMeatTimerCount[meatIndex] <= 3 {
                        self.meatBtn4.setImage(self.meatImage1[1],for: .normal)
                    } else if backMeatTimerCount[meatIndex] <= 7 {
                        self.meatBtn4.setImage(self.meatImage1[3], for: .normal)
                    } else if backMeatTimerCount[meatIndex] > 7 {
                        self.meatBtn4.setImage(self.meatImage1[5], for: .normal)
                    }
                    meatFrontTimerSetting(meatIndex: meatIndex)
                } else {
                    meatFrontTimer3.invalidate()
                    meatState[meatIndex] = true
                    if frontMeatTimerCount[meatIndex] >= 0 && frontMeatTimerCount[meatIndex] <= 3 {
                        self.meatBtn4.setImage(self.meatImage1[0],for: .normal)
                    } else if frontMeatTimerCount[meatIndex] <= 7 {
                        self.meatBtn4.setImage(self.meatImage1[2], for: .normal)
                    } else if frontMeatTimerCount[meatIndex] > 7 {
                        self.meatBtn4.setImage(self.meatImage1[4], for: .normal)
                    }
                    meatBackTimerSetting(meatIndex: meatIndex)
                }
            } else {
                print("모듬 고기를 선택해 주세요")
            }
        }
    }
    @IBAction func meatBtn5(_ sender: Any) {
        meatIndex = 4
        if frontMeatTimerCount[meatIndex] == -1 && backMeatTimerCount[meatIndex] == -1 {
            meatFrontTimer4.invalidate()
            meatBackTimer4.invalidate()
            frontMeatTimerCount[meatIndex] = 0
            backMeatTimerCount[meatIndex] = 0
            grillMeatStart[meatIndex] = false
        }
        if rawMeatClicked {
            if !grillMeatStart[meatIndex] {
                meatState[meatIndex] = true // 고기 앞면이 보이는 상태
                self.meatBtn5.setImage(self.meatImage[0],for: .normal)
                meatBackTimerSetting(meatIndex: meatIndex)
            } else {
                print("이미 굽고 있습니다")
            }
        } else {
            if grillMeatStart[meatIndex] {
                if meatState[meatIndex] { //고기 앞면이 보이는 상태 였다면
                    meatBackTimer4.invalidate()
                    meatState[meatIndex] = false
                    if backMeatTimerCount[meatIndex] >= 0 && backMeatTimerCount[meatIndex] <= 3 {
                        self.meatBtn5.setImage(self.meatImage[1],for: .normal)
                    } else if backMeatTimerCount[meatIndex] <= 7 {
                        self.meatBtn5.setImage(self.meatImage[3], for: .normal)
                    } else if backMeatTimerCount[meatIndex] > 7 {
                        self.meatBtn5.setImage(self.meatImage[5], for: .normal)
                    }
                    meatFrontTimerSetting(meatIndex: meatIndex)
                } else {
                    meatFrontTimer4.invalidate()
                    meatState[meatIndex] = true
                    if frontMeatTimerCount[meatIndex] >= 0 && frontMeatTimerCount[meatIndex] <= 3 {
                        self.meatBtn5.setImage(self.meatImage[0],for: .normal)
                    } else if frontMeatTimerCount[meatIndex] <= 7 {
                        self.meatBtn5.setImage(self.meatImage[2], for: .normal)
                    } else if frontMeatTimerCount[meatIndex] > 7 {
                        self.meatBtn5.setImage(self.meatImage[4], for: .normal)
                    }
                    meatBackTimerSetting(meatIndex: meatIndex)
                }
            } else {
                print("모듬 고기를 선택해 주세요")
            }
        }
    }
    
    @IBAction func meatBtn6(_ sender: Any) {
        meatIndex = 5
        if frontMeatTimerCount[meatIndex] == -1 && backMeatTimerCount[meatIndex] == -1 {
            meatFrontTimer5.invalidate()
            meatBackTimer5.invalidate()
            frontMeatTimerCount[meatIndex] = 0
            backMeatTimerCount[meatIndex] = 0
            grillMeatStart[meatIndex] = false
        }
        if rawMeatClicked {
            if !grillMeatStart[meatIndex] {
                meatState[meatIndex] = true // 고기 앞면이 보이는 상태
                self.meatBtn6.setImage(self.meatImage1[0],for: .normal)
                meatBackTimerSetting(meatIndex: meatIndex)
            } else {
                print("이미 굽고 있습니다")
            }
        } else {
            if grillMeatStart[meatIndex] {
                if meatState[meatIndex] { //고기 앞면이 보이는 상태 였다면
                    meatBackTimer5.invalidate()
                    meatState[meatIndex] = false
                    if backMeatTimerCount[meatIndex] >= 0 && backMeatTimerCount[meatIndex] <= 3 {
                        self.meatBtn6.setImage(self.meatImage1[1],for: .normal)
                    } else if backMeatTimerCount[meatIndex] <= 7 {
                        self.meatBtn6.setImage(self.meatImage1[3], for: .normal)
                    } else if frontMeatTimerCount[meatIndex] > 7 {
                        self.meatBtn6.setImage(self.meatImage1[5], for: .normal)
                    }
                    meatFrontTimerSetting(meatIndex: meatIndex)
                } else {
                    meatFrontTimer5.invalidate()
                    meatState[meatIndex] = true
                    if frontMeatTimerCount[meatIndex] >= 0 && frontMeatTimerCount[meatIndex] <= 3 {
                        self.meatBtn6.setImage(self.meatImage1[0],for: .normal)
                    } else if frontMeatTimerCount[meatIndex] <= 7 {
                        self.meatBtn6.setImage(self.meatImage1[2], for: .normal)
                    } else if frontMeatTimerCount[meatIndex] > 7 {
                        self.meatBtn6.setImage(self.meatImage1[4], for: .normal)
                    }
                    meatBackTimerSetting(meatIndex: meatIndex)
                }
            } else {
                print("모듬 고기를 선택해 주세요")
            }
        }
    }
    
    //MARK: 결과버튼
    @IBAction func btnResult1(_ sender: Any) {
        meatResultScore(meatIndex: 0)
        meatBackTimer0.invalidate()
        meatFrontTimer0.invalidate()
        meatBtn1.setImage(nil, for: .normal)
        setLifeImage()
    }
    
    @IBAction func btnResult2(_ sender: Any) {
        meatResultScore(meatIndex: 1)
        meatBackTimer1.invalidate()
        meatFrontTimer1.invalidate()
        meatBtn2.setImage(nil, for: .normal)
        setLifeImage()
    }
    
    @IBAction func btnResult3(_ sender: Any) {
        meatResultScore(meatIndex: 2)
        meatBackTimer2.invalidate()
        meatFrontTimer2.invalidate()
        meatBtn3.setImage(nil, for: .normal)
        setLifeImage()
    }
    
    @IBAction func btnResult4(_ sender: Any) {
        meatResultScore(meatIndex: 3)
        meatBackTimer3.invalidate()
        meatFrontTimer3.invalidate()
        meatBtn4.setImage(nil, for: .normal)
        setLifeImage() }
    
    @IBAction func btnResult5(_ sender: Any) {
        meatResultScore(meatIndex: 4)
        meatBackTimer4.invalidate()
        meatFrontTimer4.invalidate()
        meatBtn5.setImage(nil, for: .normal)
        setLifeImage()
        
    }
    
    @IBAction func btnResult6(_ sender: Any) {
        meatResultScore(meatIndex: 5)
        meatBackTimer5.invalidate()
        meatFrontTimer5.invalidate()
        meatBtn6.setImage(nil, for: .normal)
        setLifeImage()
        
    }
    
    //MARK: 목숨처리
    func setLifeImage(){
        if lifeCount == 5 {
            print("성공")
        }else if lifeCount == 4 {
            lifeCount1.image = UIImage(named: "gogicount2")
        } else if lifeCount == 3 {
            lifeCount2.image = UIImage(named: "gogicount2")
        } else if lifeCount == 2 {
            lifeCount3.image = UIImage(named: "gogicount2")
        } else if lifeCount == 1 {
            lifeCount4.image = UIImage(named: "gogicount2")
        } else if lifeCount == 0 {
            lifeCount5.image = UIImage(named: "gogicount2")
        } else {
            mainTimer.invalidate()
            mainTimerStart = false
            guard let gameOverVC = storyboard?.instantiateViewController(identifier: "GameOverViewController") as? GameOverViewController else {
                return
            }
            gameOverVC.score = score
            gameOverVC.modalPresentationStyle = .fullScreen
            present(gameOverVC, animated: true)
        }
        scoreLabel.text = String(score)
    }
    
    //MARK: 점수계산
    func meatResultScore(meatIndex : Int) {
        if grillMeatStart[meatIndex] {
            if frontMeatTimerCount[meatIndex] >= 7 && backMeatTimerCount[meatIndex] >= 7 {
                lifeCount -= 1
                prescore = -40
                score -= -40
            } else if frontMeatTimerCount[meatIndex] >= 7 || backMeatTimerCount[meatIndex] >= 7{
                lifeCount -= 1
                prescore = -20
                score -= 20
            } else {
                if frontMeatTimerCount[meatIndex] >= 0 && frontMeatTimerCount[meatIndex] < 3 {
                    if backMeatTimerCount[meatIndex] >= 0 && backMeatTimerCount[meatIndex] < 3 {
                        lifeCount -= 1
                    } else if backMeatTimerCount[meatIndex] >= 3 {
                        score += 20
                        prescore = 20
                    }
                } else if frontMeatTimerCount[meatIndex] >= 3 {
                    if backMeatTimerCount[meatIndex] >= 0 && backMeatTimerCount[meatIndex] < 3 {
                        score += 20
                        prescore = 20
                    } else if backMeatTimerCount[meatIndex] >= 3 {
                        score += 100
                        prescore = 100
                        mainTimerCount += 5
                    }
                }
            }
        } else {
            print("고기 존재 x")
        }
        
        frontMeatTimerCount[meatIndex] = -1
        backMeatTimerCount[meatIndex] = -1
        if prescore >= 0 {
            preScoreLabel.text = "+\(prescore)"
        } else {
            preScoreLabel.text = String(prescore)
        }
        grillMeatStart[meatIndex] = false
    }
    
    
    //MARK: 고기 양면 굽는 타이머 셋팅
    func meatBackTimerSetting(meatIndex : Int){
        DispatchQueue.global(qos: .userInitiated).async { [self] in
            grillMeatStart[meatIndex] = true
            let runLoop = RunLoop.current
            setBackMeatTimer(meatIndex: meatIndex) // 뒷면 굽는 타이머
            while grillMeatStart[meatIndex] {
                runLoop.run(until: Date().addingTimeInterval(0.1))
            }
        }
    }
    
    func meatFrontTimerSetting(meatIndex : Int){
            DispatchQueue.global(qos: .userInitiated).async { [self] in
            let runLoop = RunLoop.current
            setFrontMeatTimer(meatIndex: meatIndex)
            while grillMeatStart[meatIndex] {
                runLoop.run(until: Date().addingTimeInterval(0.1))
            }
        }
    }
    
    
    //MARK: 타이머 선언
    func setFrontMeatTimer(meatIndex : Int){
        switch meatIndex {
        case 0:
            meatFrontTimer0 = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(frontMeatTimerStart), userInfo: meatIndex, repeats: true)
        case 1:
            meatFrontTimer1 = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(frontMeatTimerStart), userInfo: meatIndex, repeats: true)
        case 2:
            meatFrontTimer2 = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(frontMeatTimerStart), userInfo: meatIndex, repeats: true)
        case 3:
            meatFrontTimer3 = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(frontMeatTimerStart), userInfo: meatIndex, repeats: true)
        case 4:
            meatFrontTimer4 = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(frontMeatTimerStart), userInfo: meatIndex, repeats: true)
        case 5:
            meatFrontTimer5 = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(frontMeatTimerStart), userInfo: meatIndex, repeats: true)
        default:
            return
        }
    }

    func setBackMeatTimer(meatIndex : Int){
        switch meatIndex {
        case 0:
            meatBackTimer0 = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(backMeatTimerStart), userInfo: meatIndex, repeats: true)
        case 1:
            meatBackTimer1 = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(backMeatTimerStart), userInfo: meatIndex, repeats: true)
        case 2:
            meatBackTimer2 = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(backMeatTimerStart), userInfo: meatIndex, repeats: true)
        case 3:
            meatBackTimer3 = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(backMeatTimerStart), userInfo: meatIndex, repeats: true)
        case 4:
            meatBackTimer4 = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(backMeatTimerStart), userInfo: meatIndex, repeats: true)
        case 5:
            meatBackTimer5 = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(backMeatTimerStart), userInfo: meatIndex, repeats: true)
        default:
            return
        }
    }
    
    
    //MARK: 타이머 카운트 동작
    @objc func frontMeatTimerStart(timer : Timer) {
        meatIndex = timer.userInfo as! Int
        frontMeatTimerCount[meatIndex] += 1
        //print("\(meatIndex)번 앞면고기 굽는중 : \(frontMeatTimerCount[meatIndex])")
    }
    
    @objc func backMeatTimerStart(timer : Timer) {
        meatIndex = timer.userInfo as! Int
        backMeatTimerCount[meatIndex] += 1
        //print("\(meatIndex)번 뒷면고기 굽는중 : \(backMeatTimerCount[meatIndex])")
        
    }
    

    
    // MARK: MainTimerSetting
    func mainLoop(){
        mainTimerStart = true
        let runLoop = RunLoop.current
        mainTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(setMainTimer), userInfo: nil, repeats: true)
        
        while mainTimerStart{
            runLoop.run(until: Date().addingTimeInterval(0.1))
        }
    }
    
    @objc func setMainTimer() -> Void
        {
            mainTimerCount -= 1
            
        if mainTimerCount >= 0 {
            timerLabel.text = String(mainTimerCount)
        }
        else {
            mainTimer.invalidate()
            mainTimerStart = false
            
            guard let gameOverVC = storyboard?.instantiateViewController(identifier: "GameOverViewController") as? GameOverViewController else {
                return
            }
            gameOverVC.score = score
            gameOverVC.modalPresentationStyle = .fullScreen
            present(gameOverVC, animated: true)
            
        }
    }
    
    //MARK: 게임 초기화
    func initGame(){
        initTimer()
        score = 0
        lifeCount = 5
        meatState = [false,false,false,false,false,false]
        frontMeatTimerCount = [0,0,0,0,0,0]
        backMeatTimerCount = [0,0,0,0,0,0]
        mainTimerCount = 60
        scoreLabel.text = "점수 : \(score) 점"
        lifeCount1.image = UIImage(named: "gogicount")
        lifeCount2.image = UIImage(named: "gogicount")
        lifeCount3.image = UIImage(named: "gogicount")
        lifeCount4.image = UIImage(named: "gogicount")
        lifeCount5.image = UIImage(named: "gogicount")
        meatBtn1.setImage(nil, for: .normal)
        meatBtn2.setImage(nil, for: .normal)
        meatBtn3.setImage(nil, for: .normal)
        meatBtn4.setImage(nil, for: .normal)
        meatBtn5.setImage(nil, for: .normal)
        meatBtn6.setImage(nil, for: .normal)
        
    }
    
    //MARK: 타이머 초기화
    func initTimer() {
        for i in 0...5 {
            if grillMeatStart[i]{
                switch i {
                case 0:
                    meatFrontTimer0.invalidate()
                    meatBackTimer0.invalidate()
                case 1:
                    meatFrontTimer1.invalidate()
                    meatBackTimer1.invalidate()
                case 2:
                    meatFrontTimer2.invalidate()
                    meatBackTimer2.invalidate()
                case 3:
                    meatFrontTimer3.invalidate()
                    meatBackTimer3.invalidate()
                case 4:
                    meatFrontTimer4.invalidate()
                    meatBackTimer4.invalidate()
                case 5:
                    meatFrontTimer5.invalidate()
                    meatBackTimer5.invalidate()
                default:
                    return
                }
            }
            grillMeatStart[i] = false
            frontMeatTimerCount[i] = 0
            backMeatTimerCount[i] = 0
        }
        if mainTimerStart {
            mainTimerCount = 0
            mainTimerStart = false
            mainTimer.invalidate()
        }
    }

}


// MARK: setImage
extension ViewController {
//    func setNewMeatImage(meatIndex : Int, meatState: Bool){
//        let randomNumber = Int.random(in: 1...3)
//        meatRandNumber[meatIndex] = randomNumber
//        switch meatIndex {
//        case 0:
//            self.meatBtn1.setImage(UIImage(named: "gogi\(randomNumber)"), for: .normal)
//        case 1:
//            self.meatBtn2.setImage(UIImage(named: "gogi\(randomNumber)"), for: .normal)
//        case 2:
//            self.meatBtn3.setImage(UIImage(named: "gogi\(randomNumber)"), for: .normal)
//        case 3:
//            self.meatBtn4.setImage(UIImage(named: "gogi\(randomNumber)"), for: .normal)
//        case 4:
//            self.meatBtn5.setImage(UIImage(named: "gogi\(randomNumber)"), for: .normal)
//        case 5:
//            self.meatBtn6.setImage(UIImage(named: "gogi\(randomNumber)"), for: .normal)
//        default:
//            return
//        }
//
//    }
//
//    func setMeatImage(meatIndex : Int, meatState: Bool ) {
//        if meatState {
//            if frontMeatTimerCount[meatIndex] >= 0 && frontMeatTimerCount[meatIndex] < 5 {
//                switch meatIndex {
//                case 0:
//                    self.meatBtn1.setImage(self.meatImage[meatRandNumber[meatIndex]-1], for: .normal)
//                case 1:
//                    self.meatBtn2.setImage(self.meatImage[meatRandNumber[meatIndex]-1], for: .normal)
//                case 2:
//                    self.meatBtn3.setImage(self.meatImage[meatRandNumber[meatIndex]-1], for: .normal)
//                case 3:
//                    self.meatBtn4.setImage(self.meatImage[meatRandNumber[meatIndex]-1], for: .normal)
//                case 4:
//                    self.meatBtn5.setImage(self.meatImage[meatRandNumber[meatIndex]-1], for: .normal)
//                case 5:
//                    self.meatBtn6.setImage(self.meatImage[meatRandNumber[meatIndex]-1], for: .normal)
//                default:
//                    return
//                }
//            }  else if frontMeatTimerCount[meatIndex] == -1 {
//                switch meatIndex {
//                case 0:
//                    self.meatBtn1.setImage(self.meatImage[meatRandNumber[meatIndex]+11], for: .normal)
//                case 1:
//                    self.meatBtn2.setImage(self.meatImage[meatRandNumber[meatIndex]+11], for: .normal)
//                case 2:
//                    self.meatBtn3.setImage(self.meatImage[meatRandNumber[meatIndex]+11], for: .normal)
//                case 3:
//                    self.meatBtn4.setImage(self.meatImage[meatRandNumber[meatIndex]+11], for: .normal)
//                case 4:
//                    self.meatBtn5.setImage(self.meatImage[meatRandNumber[meatIndex]+11], for: .normal)
//                case 5:
//                    self.meatBtn6.setImage(self.meatImage[meatRandNumber[meatIndex]+11], for: .normal)
//                default:
//                    return
//                }
//
//            } else if frontMeatTimerCount[meatIndex] <= 5 {
//                switch meatIndex {
//                case 0:
//                    self.meatBtn1.setImage(self.meatImage[meatRandNumber[meatIndex]+5], for: .normal)
//                case 1:
//                    self.meatBtn2.setImage(self.meatImage[meatRandNumber[meatIndex]+5], for: .normal)
//                case 2:
//                    self.meatBtn3.setImage(self.meatImage[meatRandNumber[meatIndex]+5], for: .normal)
//                case 3:
//                    self.meatBtn4.setImage(self.meatImage[meatRandNumber[meatIndex]+5], for: .normal)
//                case 4:
//                    self.meatBtn5.setImage(self.meatImage[meatRandNumber[meatIndex]+5], for: .normal)
//                case 5:
//                    self.meatBtn6.setImage(self.meatImage[meatRandNumber[meatIndex]+5], for: .normal)
//                default:
//                    return
//                }
//
//            }
//
//        } else {
//            if backMeatTimerCount[meatIndex] >= 0 && backMeatTimerCount[meatIndex] < 5{
//                switch meatIndex {
//                case 0:
//                    print("뒤집어진 고기 \(meatRandNumber[0]+3)")
//                    self.meatBtn1.setImage(self.meatImage[meatRandNumber[meatIndex]+2], for: .normal)
//                case 1:
//                    self.meatBtn2.setImage(self.meatImage[meatRandNumber[meatIndex]+2], for: .normal)
//                case 2:
//                    self.meatBtn3.setImage(self.meatImage[meatRandNumber[meatIndex]+2], for: .normal)
//                case 3:
//                    self.meatBtn4.setImage(self.meatImage[meatRandNumber[meatIndex]+2], for: .normal)
//                case 4:
//                    self.meatBtn5.setImage(self.meatImage[meatRandNumber[meatIndex]+2], for: .normal)
//                case 5:
//                    self.meatBtn6.setImage(self.meatImage[meatRandNumber[meatIndex]+2], for: .normal)
//                default:
//                    return
//                }
//            } else if backMeatTimerCount[meatIndex] == -1 {
//                switch meatIndex {
//                case 0:
//                    self.meatBtn1.setImage(self.meatImage[meatRandNumber[meatIndex]+14], for: .normal)
//                case 1:
//                    self.meatBtn2.setImage(self.meatImage[meatRandNumber[meatIndex]+14], for: .normal)
//                case 2:
//                    self.meatBtn3.setImage(self.meatImage[meatRandNumber[meatIndex]+14], for: .normal)
//                case 3:
//                    self.meatBtn4.setImage(self.meatImage[meatRandNumber[meatIndex]+14], for: .normal)
//                case 4:
//                    self.meatBtn5.setImage(self.meatImage[meatRandNumber[meatIndex]+14], for: .normal)
//                case 5:
//                    self.meatBtn6.setImage(self.meatImage[meatRandNumber[meatIndex]+14], for: .normal)
//                default:
//                    return
//
//                }
//
//            } else if backMeatTimerCount[meatIndex] <= 5 {
//                switch meatIndex {
//                case 0:
//                    self.meatBtn1.setImage(self.meatImage[meatRandNumber[meatIndex]+8], for: .normal)
//                case 1:
//                    self.meatBtn2.setImage(self.meatImage[meatRandNumber[meatIndex]+8], for: .normal)
//                case 2:
//                    self.meatBtn3.setImage(self.meatImage[meatRandNumber[meatIndex]+8], for: .normal)
//                case 3:
//                    self.meatBtn4.setImage(self.meatImage[meatRandNumber[meatIndex]+8], for: .normal)
//                case 4:
//                    self.meatBtn5.setImage(self.meatImage[meatRandNumber[meatIndex]+8], for: .normal)
//                case 5:
//                    self.meatBtn6.setImage(self.meatImage[meatRandNumber[meatIndex]+8], for: .normal)
//                default:
//                    return
//
//                }
//
//            }
//
//        }
//    }
}

