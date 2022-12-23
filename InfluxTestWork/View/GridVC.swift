//
//  GridVC.swift
//  InfluxTestWork
//
//  Created by santhosh t on 23/12/22.
//

import UIKit
import ImageLoader

class GridVC: UIViewController {
    
    @IBOutlet weak var gridView: UICollectionView!
    

    var viewModel = GridViewModel()
    var gridData:GridModel?
    
    var gridCount = 0
    var gridArray = [GridSelectionModel]()
    //var selectionStatus = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        
        self.gridView.register(UINib(nibName: "GridCell", bundle: nil),
                               forCellWithReuseIdentifier: "GridCell")
        
        viewModel.apiToGetQuestionData { [weak self] in
            self?.gridData = self?.viewModel.gridData
            
            DispatchQueue.main.async {
                //self?.gridView.reloadData()
                self?.gridCount = (self!.gridData?.photos?.photo.count)!
                self?.initializeData()
            }
            
        }
    }
    
    func initializeData()
    {
        for i in (0..<gridCount)
        {
            gridArray.append(GridSelectionModel(selactionFlag: false,messageBoxFlag: false,selactedItemIndex: 0,arrow_index: 0))
        }
        gridView.reloadData()
    }
    

}

extension GridVC: UICollectionViewDelegate , UICollectionViewDataSource , UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        gridCount//gridData?.photos?.photo.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "GridCell", for: indexPath) as! GridCell
        
        
        let screen_width = (self.view.frame.size.width)-15
        cell.imageWidth.constant = screen_width/2
        cell.imageHeight.constant = screen_width/2
        cell.indexPaths = indexPath.row
        
        if gridArray[indexPath.row].messageBoxFlag!
        {
            //selectionStatus = true
            cell.nameView.text = "name"
            cell.configure(selaction_data: gridArray[indexPath.row], image_url: "")
            return cell
        }
        else
        {
            let server = gridData?.photos?.photo[indexPath.row].server
            let id = "e620531a70d0bb5f1c5069c4a37ae533_24baf0407c45f185_w"
            
            let imageUrl = "https://live.staticflickr.com/"+server!+"/"+id+".jpg"
            
            cell.nameView.text = "name \(indexPath.row)"
            cell.configure(selaction_data: gridArray[indexPath.row],image_url:"https://smaller-pictures.appspot.com/images/dreamstime_xxl_65780868_small.jpg")
            
            return cell
            
        }
            
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        
        if gridArray[indexPath.row].messageBoxFlag! != true
        {
            if gridArray[indexPath.row].selactionFlag!
            {
                gridArray[indexPath.row].selactionFlag! = false
                if indexPath.row % 2 == 0
                {
                    //is even number
                    gridArray[indexPath.row+2].messageBoxFlag! = false
                }
                else
                {
                    //is odd number
                    gridArray[indexPath.row+1].messageBoxFlag! = false
                }
                gridArray.remove(at: indexPath.row)
                
            }
            else
            {
                for i in (0..<gridArray.count-1)
                {
                    gridArray[i].selactionFlag! = false
                    //gridArray[i].messageBoxFlag! = false
                    
                    if gridArray[i].messageBoxFlag!
                    {
                        gridArray.remove(at: i)
                        gridData?.photos?.photo.remove(at: i)
                        
                    }
                }
                gridArray[indexPath.row].selactionFlag! = true
                
                
                if indexPath.row % 2 == 0
                {
                    //is even number
                    gridArray[indexPath.row+2].messageBoxFlag! = true
                    gridArray[indexPath.row+2].selactedItemIndex! = indexPath.row
                    gridArray[indexPath.row+2].arrow_index! = 0
                    //gridData?.photos?.photo.remove(at: indexPath.row+2)
                    let photoData = Photo(id: "0",owner: "0", secret: "0", server: "0", farm: 0, title: "0", ispublic: 0, isfriend: 0, isfamily: 0)
                    gridData?.photos?.photo.insert(photoData, at: indexPath.row+2)
                }
                else
                {
                    //is odd number
                    gridArray[indexPath.row+1].messageBoxFlag! = true
                    gridArray[indexPath.row+1].selactedItemIndex! = indexPath.row
                    gridArray[indexPath.row+1].arrow_index! = 1
                    //gridData?.photos?.photo.remove(at: indexPath.row+1)
                    let photoData = Photo(id: "0",owner: "0", secret: "0", server: "0", farm: 0, title: "0", ispublic: 0, isfriend: 0, isfamily: 0)
                    gridData?.photos?.photo.insert(photoData, at: indexPath.row+1)
                }
                
                gridArray.append(GridSelectionModel(selactionFlag: true,messageBoxFlag: false,selactedItemIndex: 0,arrow_index: 0))
                
                
            }
            print("SANTHOSH ARRAT COUNT IS : ",gridArray.count)
            gridView.reloadData()
        }
         
    }
    

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let screen_width = (self.view.frame.size.width)-15
        let width : CGFloat
        let height : CGFloat

        if gridArray[indexPath.row].messageBoxFlag!
        {
            width = screen_width
            height = screen_width/2 - 20
        }
        else
        {
            width = screen_width/2
            height = screen_width/2 - 20
        }

        return CGSizeMake(width, height)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets.zero
    }
    
}

extension UIImageView {
    func downloaded(from url: URL, contentMode mode: ContentMode = .scaleAspectFit) {
        contentMode = mode
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
                else { return }
            DispatchQueue.main.async() { [weak self] in
                self?.image = image
            }
        }.resume()
    }
    func downloaded(from link: String, contentMode mode: ContentMode = .scaleAspectFit) {
        guard let url = URL(string: link) else { return }
        downloaded(from: url, contentMode: mode)
    }
}
