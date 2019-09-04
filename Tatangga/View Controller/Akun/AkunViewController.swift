//
//  AkunViewController.swift
//  Tatangga
//
//  Created by Mirza Fachreza 2 on 23/08/19.
//  Copyright © 2019 Mirza Fachreza. All rights reserved.
//

import UIKit
import CloudKit

class AkunViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
    var userRecord = [CKRecord]()
    let profilePhoto: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(#imageLiteral(resourceName: "camera").withRenderingMode(.alwaysOriginal), for: .normal)
        return button
    }()
    let userNameText: UILabel = {
        let label = UILabel()
        label.text = "Username"
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = .black
        return label
    }()
    let statusText: UILabel = {
        let label = UILabel()
        label.text = "status"
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = UIColor.lightGray
        return label
    }()
    let ubahProfile: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Ubah Profil", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = .clear
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.black.cgColor
        button.layer.cornerRadius = 8
        button.addTarget(self, action: #selector(handleEditProfile), for: .touchUpInside)
        return button
    }()
    let segmentedControl: UISegmentedControl = {
        let items = ["Laporan Saya" , "Grup Saya","Alamat Saya"]
        let segmentedControl = UISegmentedControl(items : items)
        segmentedControl.selectedSegmentIndex = 0
        segmentedControl.addTarget(self, action: #selector(AkunViewController.indexChanged(_:)), for: .valueChanged)
        segmentedControl.layer.cornerRadius = 5.0
        segmentedControl.backgroundColor = .clear
        segmentedControl.tintColor = .blue
        return segmentedControl
    }()
    
    //MARK: My table
    var myTableView: UITableView = {
        let tableView = UITableView()
        return tableView
    }()
    var animalArray: [String] = ["Dog","Cat","Fish"]
    var cellID = "cellID"
    var groupNameList = ["RT 05, Puri Indah", "RW 07, Puri Indah"]
    var arrayOfGroup = [GroupList(groupName: "RT 05, Puri Indah", groupMember: "15 Anggota"), GroupList(groupName: "RW 07, Puri Indah", groupMember: "89 Orang")]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        let login = LoginVC()
//        navigationController?.pushViewController(login, animated: true)
        // Do any additional setup after loading the view.
        navigationItem.title = "Akun"
       // configureLogoutButton()
        
        view.addSubview(profilePhoto)
        profilePhoto.anchor(top: view.topAnchor, left: nil, bottom: nil, right: nil, paddingTop: 112, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 140, height: 140)
        profilePhoto.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        view.addSubview(userNameText)
        userNameText.anchor(top: profilePhoto.bottomAnchor, left: nil, bottom: nil, right: nil, paddingTop: 20, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 100, height: 30)
        userNameText.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        view.addSubview(statusText)
        statusText.anchor(top: userNameText.bottomAnchor, left: nil, bottom: nil, right: nil, paddingTop: 2, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 100, height: 30)
        statusText.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        view.addSubview(ubahProfile)
        ubahProfile.anchor(top: statusText.bottomAnchor, left: nil, bottom: nil, right: nil, paddingTop: 5, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 150, height: 35)
        ubahProfile.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        view.addSubview(segmentedControl)
        segmentedControl.anchor(top: ubahProfile.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 5, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 416, height: 35)
        segmentedControl.centerXAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        
        //MARK: table view
        view.backgroundColor = UIColor.white
        myTableView.frame = view.frame
        myTableView.register(GroupListCell.self, forCellReuseIdentifier: cellID)
        myTableView.delegate = self
        myTableView.dataSource = self
        view.addSubview(myTableView)
        myTableView.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: view.topAnchor, right: view.rightAnchor, paddingTop: 415, paddingLeft: 0, paddingBottom: 786, paddingRight: 0, width: 410, height: 383)
        myTableView.isHidden = true
    
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //return animalArray.count
        //return arrayOfGroup.count
        return groupNameList.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: GroupListCell = GroupListCell(style: UITableViewCell.CellStyle.default, reuseIdentifier: cellID, group: arrayOfGroup[indexPath.row])
//       cell.textLabel?.text = arrayOfGroup[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    
    @objc func indexChanged(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex{
        case 0:
            print("Laporan saya");
            myTableView.isHidden = true
        case 1:
            print("Grup Saya")
            myTableView.isHidden = false
        case 2:
            print("Alamat Saya")
            myTableView.isHidden = true
        default:
            break
        }
    }
    @objc func handleEditProfile(){
        let editVC = EditProfileController()
        self.navigationController?.pushViewController(editVC, animated: true)
    }
    @objc func handleCancel() {
        let cancel = AkunViewController()
        self.navigationController?.pushViewController(cancel, animated: true)
          _ = navigationController?.popViewController(animated: true)
    }
    
    @objc func handleGroupDetail()
    {
        let groupDetail = ContactListCell()
        self.navigationController?.pushViewController(groupDetail, animated: true)
          _ = navigationController?.popViewController(animated: true)
    }
    
    @objc func handleDone() {
        
        view.endEditing(true)
        
//        if usernameChanged {
//            updateUsername()
//        }
//
//        if imageChanged {
//            updateProfileImage()
//        }
    }
    @objc func handleLogout(){
        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        alertController.addAction(UIAlertAction(title: "Keluar", style: .destructive, handler: { (_) in
            
            do {
                //try Auth.auth().signOut()
//                let loginVC = LoginVC()
//                let navController = UINavigationController(rootViewController: loginVC)
//                self.present(navController, animated: true, completion: nil)
                
                let loginVC = LoginVC()
                self.navigationController?.pushViewController(loginVC, animated: true)
            } catch {
                print("Failed to sign out")
            }
        }))
        
        alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        present(alertController, animated: true, completion: nil)    }
    
    func configureLogoutButton() {
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Keluar", style: .plain, target: self, action: #selector(handleLogout))
        let edit = LoginVC()
        navigationController?.pushViewController(edit, animated: true)
    }
    func authentication() {
        for index in 1...userRecord.count {
            let user = userRecord[index - 1]
            let email = user[RemoteUser.email] as! String
            let password = user[RemoteUser.password] as! String
            OperationQueue.main.addOperation {
                //                if (email == self.edtEmail.text && password == self.edtPassword.text) {
                // When Data Email & Password Input == Database data
                // Success
                //                    let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                //                    let viewCon = storyBoard.instantiateViewController(withIdentifier: "mainTabBar")
                //                    self.present(viewCon, animated: true, completion: nil)
                //                    UserDefaults.standard.set(true, forKey: "isLogin")
                //                    UserDefaults.standard.set(String(user.recordID.recordName), forKey: "recordNameUser")
                //                    let archivedData = NSMutableData()
                //                    do {
                //                        let archiver = try NSKeyedArchiver.archivedData(withRootObject: user, requiringSecureCoding: true)
                //                        let userDefaults = UserDefaults.standard
                //                        userDefaults.set(archiver, forKey: "use rRecord")
                //                        userDefaults.synchronize()
                //                    } catch {
                //                        print(error)
                //                    }
                //                } else {
                // Error Login
                //                }
            }
        }
       let login = LoginVC()
       navigationController?.pushViewController(login, animated: true)

    }
    
}
