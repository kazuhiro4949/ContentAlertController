//: Playground - noun: a place where people can play

import XCPlayground

import UIKit
import ContentAlertController

class ViewController: UIViewController {
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)

        let button = UIButton(type: .System)
        button.setTitle("show alert", forState: .Normal)
        button.addTarget(self, action: #selector(ViewController.didTapShowAlert(_:)), forControlEvents: .TouchUpInside)
        button.center = view.center
        button.bounds.size = CGSize(width: 100, height: 44)
        view.addSubview(button)
    }
    
    func didTapShowAlert(sender: UIButton) {
        
        
        
        let alertVC = HeadlineAlertController(title: "Sevilla signs Sirigu on loan from Paris SG", message: "On Friday, French capital football club Paris Saint-Getmain announced they loaned Italian goalkeeper Salvatore Sirigu to Spanish club Sevilla F.C. till the season end.", imageUrl: NSURL(string: "https://upload.wikimedia.org/wikipedia/commons/thumb/a/a2/Salvatore_Sirigu.jpg/220px-Salvatore_Sirigu.jpg")!, preferredStyle: .Alert)
        alertVC.addAction(AlertAction(title: "Cancel", style: .Cancel, handler: nil))
        presentViewController(alertVC, animated: true, completion: nil)
    }
}


let vc = ViewController()
vc.view.backgroundColor = .whiteColor()
let nvc = UINavigationController(rootViewController: vc)

XCPlaygroundPage.currentPage.liveView = nvc
