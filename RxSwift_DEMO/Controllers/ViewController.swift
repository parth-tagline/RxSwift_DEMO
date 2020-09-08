//
//  ViewController.swift
//  RxSwift_DEMO
//
//  Created by tagline13 on 05/09/20.
//  Copyright © 2020 tagline13. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import SwiftSpinner

class ViewController: UIViewController , UICollectionViewDelegate , UICollectionViewDelegateFlowLayout {
   
    
    
    @IBOutlet weak var notes_collectionview: UICollectionView!
    
    let disposeBag = DisposeBag()
    let notes: BehaviorRelay<[NoteData]> = BehaviorRelay(value: [])
    var NotesArray =  NSMutableArray()
    
    var db:DBHelper = DBHelper()
    var _notedata:[NoteData] = []
    var CurrentNote = NoteData.init(id: "id", title: "title", content: "content", date: "")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self._notedata = db.read()
        setData()
        notes_collectionview.rx.setDelegate(self).disposed(by: disposeBag)
        //        registerHeaderCell()
        registerCollectionViewCell()
        bindViewModelToCollectionView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self._notedata = db.read()
        self.notes.accept(self._notedata)
        setData()
    }
    
    
    func setData(){
        
        if (self._notedata.isEmpty ){
            getNotesDetails()
            self._notedata = db.read()
            self.notes.accept(self._notedata)
        }else{
            print("OLD DATA")
            self._notedata = db.read()
            self.notes.accept(self._notedata)
        }
    }
    
    private func registerHeaderCell() {
        let nib = UINib(nibName: "NoteHeaderReusableView", bundle: nil)
        notes_collectionview.register(nib, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "NoteHeaderReusableView")
    }
    
    private func registerCollectionViewCell() {
        let nib = UINib(nibName:"NoteCollectionViewCell", bundle: nil)
        notes_collectionview.register(nib, forCellWithReuseIdentifier: "NoteCollectionViewCell")
    }
    
    private func bindViewModelToCollectionView() {
        
        //itemaatindexpath method
        
        
        self.notes.bind(to: notes_collectionview.rx.items(cellIdentifier: "NoteCollectionViewCell", cellType: NoteCollectionViewCell.self)){ (row,item,cell) in
            self.CurrentNote = item
            cell.cell_titlelbl.text = item.title
            cell.cell_description.text = item.content
            let df = DateFormatter()
            df.locale = Locale(identifier: "en_US_POSIX")
            df.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
            let date = df.date(from: item.date)
            df.dateFormat = "MMM d yyyy"
            let date2 = df.string(from: date!)
            cell.cell_date.text = date2
            cell.cell_datelbl.text = TimeHelper.timeAgoSinceDate( date!, currentDate: Date(), numericDates: true)
            cell.cell_btn_remove.tag = Int(item.id)!
            cell.cell_btn_remove.addTarget(self, action: #selector(self.removeAction), for: .touchUpInside)
            
        }.disposed(by: disposeBag)
        
        //didselectmethod
        notes_collectionview.rx.modelSelected(NoteData.self).subscribe(onNext: { item in
            
            print("SelectedItem: \(item.id)")
            let vc  = Storyboards.mainStoryboard.instantiateViewController(identifier: "DetailViewController") as! DetailViewController
            vc.detailData = item
            self.navigationController?.pushViewController(vc, animated: true)
        }).disposed(by: disposeBag)
        
        
    }
    @objc func removeAction(_ sender: UIButton) {
        print(sender.tag)
        db.deleteByID(id: String(sender.tag))
        self._notedata = db.read()
        self.notes.accept(self._notedata)
    }
    
    func getNotesDetails(){
        print("fetchData called")
        
        if let url = URL(string: AppUrls.getNotes) {
            SwiftSpinner.show("Getting Notes...")
            URLSession.shared.dataTask(with: url) { data, response, error in
                
                guard let data = data, error == nil, response != nil else {
                    // Add DispatchQueue
                    DispatchQueue.main.async {
                        print(error.debugDescription)
                        if error!.localizedDescription == "The Internet connection appears to be offline."{
                            let alert = UIAlertController(title: "Network error", message: "Unable to contact the server", preferredStyle: UIAlertController.Style.alert)
                            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
                            self.present(alert, animated: true, completion: nil)
                            
                        }else{
                            let alert = UIAlertController(title: "Error ", message: error!.localizedDescription, preferredStyle: UIAlertController.Style.alert)
                            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
                            self.present(alert, animated: true, completion: nil)
                        }
                        SwiftSpinner.show("Getting Notes...").addTapHandler({
                                                     SwiftSpinner.hide()
                                                   }, subtitle: error!.localizedDescription)
                    }
                    return
                }
                
                do {
                    print("fetchData called")
                    let notes = try JSONDecoder().decode([NoteData].self, from: data)
                    self.notes.accept(notes)
                    for note in self.notes.value {
                        self.db.insert(id: note.id, title: note.title, content: note.content, date: note.date)
                        self._notedata = self.db.read()
                    }
                    SwiftSpinner.hide()
                } catch let error {
                    print(error)
                }
                
            }.resume()
        }
    }
    
    
}

