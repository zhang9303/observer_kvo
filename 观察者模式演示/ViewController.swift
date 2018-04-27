//
//  ViewController.swift
//  观察者模式演示
//
//  Created by Z_z_z on 2018/4/8.
//  Copyright © 2018年 zzz. All rights reserved.
//


//观察者模式可以让一个对象在不对另一个对象产生依赖的情况下，注册并接收改对象发出的通知。
//观察者模式的定义：观察者模式定义了一种一对多的依赖关系，让多个观察者对象同时监听某一个主题对象。这个主题对象在状态上发生变化时，会通知所有观察者对象，使它们能够自动更新自己。 简而言之，就是A和B，A对B的变化感兴趣，就注册为B的观察者，当B发生变化时通知A，告知B发生了变化。这个也叫做经典观察者模式。
import UIKit


class ViewController: UIViewController {

    var _zzz = ZZZPerson()
    let textField = UITextField()
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        kvo()
        // 输入框监听
        setUI()
    }

    func kvo() -> Void {
        
        _zzz.age = 18
        
        print(_zzz.name,_zzz.age)
        //观察属性age
        _zzz.addObserver(self, forKeyPath:"age", options: [.old,.new], context: nil)
    }
    

    //一旦属性被操作了，这里会自动响应（上面设置观察的属性才会在这响应）
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
 
        print(change![NSKeyValueChangeKey.newKey]!)
        if keyPath == "age" {
            textField.text = _zzz.age.stringValue
            
        }
    }
    
    //输入框
    func setUI( ) -> Void {
        
        textField.frame = CGRect(x:50, y:60, width:200, height:40);
        textField.borderStyle = UITextBorderStyle.roundedRect
        textField.text = _zzz.age.stringValue
        self.view.addSubview(textField)
        
    }
    // 点击屏幕通过kvc给Person里面的name赋值   屏幕为观察者，age为被观察者。 点击屏幕当做获取数据， age值发生改变，触动回调方法
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let num = Int(arc4random()%10000) + 1
        _zzz.age = NSNumber(value: num)
    }
    
    //移除监听
    override func viewWillDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated);
        
        _zzz.removeObserver(self, forKeyPath: "age", context: nil);
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

