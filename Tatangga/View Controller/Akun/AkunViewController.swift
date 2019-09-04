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
    var userData: CKRecord!
    
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
        segmentedControl.tintColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        return segmentedControl
    }()
    
    //MARK: My table
    var myTableView: UITableView = {
        let tableView = UITableView()
        return tableView
    }()
    var cellID = "cellID"
    var groupNameList = ["RT 05, Puri Indah", "RW 07, Puri Indah"]
    var arrayOfGroup = [GroupList(groupName: "RT 05, Puri Indah", groupMember: "15 Anggota"), GroupList(groupName: "RW 07, Puri Indah", groupMember: "89 Orang")]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let islogin: Bool = UserDefaults.standard.bool(forKey: "isLogin")
        if islogin {
            getUserData()
        } else {
            let login = LoginVC()
            navigationController?.pushViewController(login, animated: true)
        }
        // Do any additional setup after loading the view.
        navigationItem.title = "Akun"
        configureLogoutButton()
        
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
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.isHidden = false
        let islogin: Bool = UserDefaults.standard.bool(forKey: "isLogin")
        if islogin {
            getUserData()
        }
    }
    
    // Use for getDataUser and Check Group
    func getUserData() {
        let recordName = UserDefaults.standard.string(forKey: "recordNameUser")
        let predicateLogin = NSPredicate(format: "recordID = %@", CKRecord.ID(recordName: recordName!))
        let queryUser = CKQuery(recordType: RemoteRecords.user, predicate: predicateLogin)
            if (recordName != nil) {
                CKContainer.init(identifier: "iCloud.com.team8.Tatangga").publicCloudDatabase.perform(queryUser, inZoneWith: nil) {
                    record, error in
                    if error != nil {
                        print(error!.localizedDescription)
                    } else {
                        guard let record = record else { return }
                        let data = record[0]
                        self.userData = record[0]
                        print(self.userData)
                        print(self.userData[RemoteUser.username])
                        let dataGroup = data["Group"]
                        if dataGroup != nil {
                            print("Punya Group dia")
                        } else {
                            print("Gak Punya Group")
                        }
                        
                        DispatchQueue.main.async {
                            self.setDataUser()
                        }
                    }
                }
            }
    }
    
    func setDataUser() {
        if let asset = self.userData[RemoteUser.photoUser] as? CKAsset, let data = try? Data(contentsOf: asset.fileURL!) {
            let decodedImage = UIImage(data: data as Data)
            let originalImage = decodedImage!.withRenderingMode(.alwaysOriginal)
            
            profilePhoto.layer.cornerRadius = profilePhoto.frame.width / 2
            profilePhoto.layer.masksToBounds = true
            profilePhoto.layer.borderColor = UIColor.black.cgColor
            profilePhoto.layer.borderWidth = 1
            profilePhoto.setImage(originalImage, for: .normal)
        }
        userNameText.text = self.userData[RemoteUser.username]! as String
        statusText.text = self.userData[RemoteUser.status]! as String
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
    
//    @objc func handleGroupDetail()
//    {
//        let groupDetail = ContactListCell()
//        self.navigationController?.pushViewController(groupDetail, animated: true)
//    }
    
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
//                //try Auth.auth().signOut()
                UserDefaults.standard.set(false, forKey: "isLogin")
                let loginVC = LoginVC()
//                guard let navigationController = self.navigationController else { return }
//                var controllers = navigationController.viewControllers
//                print(controllers.count)
//                controllers.remove(at: controllers.count - 1)
//                self.navigationController?.viewControllers = controllers
                self.navigationController?.pushViewController(loginVC, animated: true)
            } catch {
                print("Failed to sign out")
            }
        }))
        
        alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        present(alertController, animated: true, completion: nil)    }
    
    func configureLogoutButton() {
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Keluar", style: .plain, target: self, action: #selector(handleLogout))
    }
}
