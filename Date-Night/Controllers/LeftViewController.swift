//
//  LeftViewController.swift
//  Date-Night
//
//  Created by Phoenix McKnight on 2/12/20.
//  Copyright © 2020 Michelle Cueva. All rights reserved.
//

import UIKit
import FirebaseFirestore



class LeftViewController: UIViewController {
    
    let sendInviteVC = OBSendInviteVC()
    let waitingForResponseVC = WaitingForResponseVC()
    let partnerProfileVC = PartnerSettingVC()

    var leftScreenStatus:LeftScreenStatus = .sendInvite {
        didSet {
            determineLeftVC()
        }
    }
    
    var leftScreenPartner:AppUser? {
        didSet {
            print("leftScreen received partner")
            guard leftScreenPartner != nil else {return}
            partnerProfileVC.profilePartnerUser = leftScreenPartner
            
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    private func determineLeftVC() {
          switch leftScreenStatus {
          case .partnerProfile:
        
              addAndRemoveChild(currentChild: partnerProfileVC)
          case .sendInvite:
              sendInviteVC.delegate = self
              addAndRemoveChild(currentChild: sendInviteVC)
          case .waitingForResponse:
            waitingForResponseVC.delegate = self
              addAndRemoveChild(currentChild: waitingForResponseVC)
          }
      }
      
    private func addAndRemoveChild(currentChild:UIViewController) {
           for child in children {
               child.remove()
           }
        self.add(currentChild)
       }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
extension LeftViewController:SendInviteDelegate {
    func changeStatus(status: LeftScreenStatus) {
        leftScreenStatus = status
    }
}

extension LeftViewController:WaitingForResponseDelegate {
    func changeStatusWaiting(status: LeftScreenStatus) {
        leftScreenStatus = status
    }
}
