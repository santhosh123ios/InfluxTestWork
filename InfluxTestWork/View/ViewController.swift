//
//  ViewController.swift
//  InfluxTestWork
//
//  Created by santhosh t on 21/12/22.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var gridView: UICollectionView!
    var gridArray = [GridItems]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.gridView.register(UINib(nibName: "GridCell", bundle: nil),
                               forCellWithReuseIdentifier: "GridCell")
        let flow = gridView?.collectionViewLayout as! UICollectionViewFlowLayout
        flow.minimumInteritemSpacing = CGFloat(10.0)
        flow.minimumLineSpacing = CGFloat(10.0)
        
        initializeData()
    }
    
    
    func initializeData()
    {
        for i in (0..<10)
        {
            gridArray.append(GridItems(image:"dsffs",
                                       selactionFlag:false,
                                       id:i,
                                       title:"Location Name A",
                                       subTitle:"600*600",
                                       message:"Lorem ipsum dolor sit amet, consectetur adipiscing elit. Quisque non tortor non tortor bibendum tincidunt.",
                                       messageBoxFlag:false,
                                       showFlag:true,
                                       selactionIndex:0
                                      ))
            if i % 2 != 0 {
                print("\(i) is odd number")
                gridArray.append(GridItems(image:"",
                                           selactionFlag:false,
                                           id:0,
                                           title:"",
                                           subTitle:"",
                                           message:"",
                                           messageBoxFlag:true,
                                           showFlag:false,
                                           selactionIndex:0
                                          ))
            }
            
        }
    }
}

extension ViewController: UICollectionViewDelegate , UICollectionViewDataSource , UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        gridArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "GridCell", for: indexPath) as! GridCell
        
        let screen_width = (self.view.frame.size.width)-10
        cell.imageWidth.constant = screen_width/2
        cell.imageHeight.constant = screen_width/2
        cell.configure(data: gridArray[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if gridArray[indexPath.row].messageBoxFlag! != true
        {
            if gridArray[indexPath.row].selactionFlag!
            {
                messageBoxStatusSet(insex:indexPath.row,status:false)
            }
            else
            {
                for i in (0..<gridArray.count-1)
                {
                    messageBoxStatusSet(insex:i,status:false)
                }
                messageBoxStatusSet(insex:indexPath.row,status:true)
            }
            
            gridView.reloadData()
        }
        
        
    }
    
    func messageBoxStatusSet(insex:Int,status:Bool)
    {
        gridArray[insex].selactionFlag! = status
        
        if gridArray[insex].id! % 2 == 0
        {
            //is even number
            gridArray[insex+2].showFlag! = status
            gridArray[insex+2].selactionIndex! = 0
            
            gridArray[insex+2].title! = gridArray[insex].title!
            gridArray[insex+2].subTitle! = gridArray[insex].subTitle!
            gridArray[insex+2].message! = gridArray[insex].message!
            
        }
        else
        {
            //is odd number
            gridArray[insex+1].showFlag! = status
            gridArray[insex+1].selactionIndex! = 1
            
            gridArray[insex+1].title! = gridArray[insex].title!
            gridArray[insex+1].subTitle! = gridArray[insex].subTitle!
            gridArray[insex+1].message! = gridArray[insex].message!
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let screen_width = (self.view.frame.size.width)-10
        let width : CGFloat
        let height : CGFloat
        
        if gridArray[indexPath.row].messageBoxFlag!
        {
            if gridArray[indexPath.row].showFlag!
            {
                width = screen_width
                height = screen_width/2 - 20
            }
            else
            {
                width = screen_width
                height = 0
            }
            
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
