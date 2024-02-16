//
//  ViewController3.swift
//  MemoryGame
//
//  Created by Batu Dursun on 9.12.2023.
//


//Seviye 2 için
import UIKit

class ViewController3: UIViewController {

    @IBOutlet var player1Label:UILabel!
    @IBOutlet var imageView:UIImageView!
    
    @IBOutlet var timerLabel:UILabel!
    
    @IBOutlet var labelofHataSayisi:UILabel!
    @IBOutlet var button1 : UIButton!
    @IBOutlet var button2 : UIButton!
    @IBOutlet var button3 : UIButton!
    @IBOutlet var button4 : UIButton!
    @IBOutlet var button5 : UIButton!
    @IBOutlet var button6 : UIButton!
    @IBOutlet var button7 : UIButton!
    @IBOutlet var button8 : UIButton!
     
    @IBOutlet var tolevel3 : UIBarButtonItem!
    @IBOutlet var tebrikler: UILabel!
    
    
    var images = [
        "image1","image2","image3","image4",
        "image1","image2","image3","image4"]
    
    
    
    var buttons = [UIButton]()
    
    var click = 1
    
    var click1 = 0
    var click2 = 0
    
    var points1 = 0
    var points2 = 0
    
    var hataSayisi = 0
    
    var myTimer = Timer()
    var counter : Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        myTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(timerRun), userInfo: nil, repeats: true)
        //shuffle the images
        images.shuffle()
        
        
        
        //add buttons to an array
        buttons.append(button1)
        buttons.append(button2)
        buttons.append(button3)
        buttons.append(button4)
        buttons.append(button5)
        buttons.append(button6)
        buttons.append(button7)
        buttons.append(button8)

        // Bu kısım, buttons adlı bir dizide bulunan her bir düğme için, images dizisindeki resimlerin sırasına göre bir resim atar. Yani, her düğme başlangıçta farklı bir resimle atanır.
           for (index, button) in buttons.enumerated() {
               button.setImage(UIImage(named: images[index]), for: .normal)
           }

           // Tüm butonlara atanan imageleri 1 saniye boyunca gösterir.
           DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1.0) {
               for button in self.buttons {
                   button.setImage(UIImage(named: "image"), for: .normal)
               }
           }
    }

    @IBAction func button1Action(_ sender: Any) {
        butonGetir(var: 1, var: button1)
    }
    @IBAction func button2Action(_ sender: Any) {
        butonGetir(var: 2, var: button2)
    }
    @IBAction func button3Action(_ sender: Any) {
        butonGetir(var: 3, var: button3)
    }
    
    @IBAction func button4Action(_ sender: Any) {
        butonGetir(var: 4, var: button4)
    }
    @IBAction func button5Action(_ sender: Any) {
        butonGetir(var: 5, var: button5)
    }
    @IBAction func button6Action(_ sender: Any) {
        butonGetir(var: 6, var: button6)
    }
    
    
    @IBAction func button7Action(_ sender: Any) {
        butonGetir(var: 7, var: button7)
    }
    @IBAction func button8Action(_ sender: Any) {
        butonGetir(var: 8, var: button8)
    }
    
    func compare() {
        if images[click1-1] == images[click2-1] {
            //same images
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1) {
                //hide image
                self.buttons[self.click1-1].alpha = 0
                self.buttons[self.click2-1].alpha = 0
                
                self.click = 1
                
                self.points1 = self.points1 + 1 //Skor sayaci
                self.points2 = self.points2 + 1 //Hamle sayaci
                    
                self.levelUp()
                //no player switch when images are the same
                //self.switchPlayer()
                self.emotes()
                self.player1Label.text = "SKOR/HAMLE: \(self.points1) /  \(self.points2)"
            }
        } else {
            //different images
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1) {
                //hide images
                
                self.buttons[self.click1-1].setImage(UIImage(named: "image"), for: .normal)
                self.buttons[self.click2-1].setImage(UIImage(named: "image"), for: .normal)
                
                self.click = 1
                
                
                self.emotes()
                self.points2 = self.points2 + 1 //Hamle sayaci
                self.player1Label.text = "SKOR/HAMLE: \(self.points1) /  \(self.points2)"
                
                self.hataSayisi = self.points1 - self.points2
                self.labelofHataSayisi.text = "Hata: \(self.hataSayisi * -1)"
            }
        }
    }
    
    func levelUp() {
        if  self.points1 == 4 {
            tolevel3.isEnabled = true
            tebrikler.text = "TEBRIKLER!"
            
            myTimer.invalidate()
            
            toplamSure.shared.sure1 = toplamSure.shared.sure1 + counter   
            
        }
    }
    
    func emotes() {
        if images[click1-1] == images[click2-1] {
            if let image = UIImage(named: "image14") {
                imageView.image = image
            }
        } else {
            if let image = UIImage(named: "image13") {
                imageView.image = image
            }
        }
        
        // ImageView a atanan alkis veya ofke emojisini 1 saniye sonra sil
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1.0) {
            self.imageView.image = nil
        }
    }
    
    
    func butonGetir( var clickerScore:Int, var button:UIButton ){
        
        if click == 1  {
           
            
            button.setImage(UIImage(named: images[clickerScore-1]), for: .normal)
            click = click + 1
            click1 = clickerScore
        } else if click == 2 && (click1 != clickerScore)  {
            button.setImage(UIImage(named: images[clickerScore-1]), for: .normal)
            click = click + 1
            click2 = clickerScore
            
            compare()
        }
        
    }
    
    
    
    @objc func timerRun() {
    counter += 1
    timerLabel.text = "Süre: \(String(counter - 1))sn" }

    
    
}
    
    
    
    



