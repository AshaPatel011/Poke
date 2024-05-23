//
//  HomeVC.swift
//  Poke
//
//  Created by Apple on 23/05/24.
//

import UIKit

class HomeVC: UIViewController {
    
    //MARK: outlets ---------------------------------------------------------
    
    @IBOutlet weak var tblPoke: UITableView!
    @IBOutlet weak var vwFilter: UIView!

//    @IBOutlet weak var lblNodata: UILabel!

    //MARK: properties ---------------------------------------------------------
    
    let layout = UICollectionViewFlowLayout()
    var pokeHelper_Parser = PokeHelper_Parser()
    let pagingSpinner = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.medium)

    //MARK: view controller life cycle ---------------------------------------------------------
    
    override func viewDidLoad() {
        super.viewDidLoad()
                
        setupLoadMoreDataSpinner()
        
        //call data api
        getPokeList()
    }
    
    func getPokeList(){
        
        self.view.endEditing(true)
        pokeHelper_Parser.initWith(helperDelegate: self)
        pokeHelper_Parser.getPokeList(viewController: self)
    }
    
    //MARK: Others ---------------------------------------------------------
    
    // manage empty data screen
    func noDataFound(){
//        lblNodata.isHidden = pokeHelper_Parser.arrPoke.count == 0 ? false : true
    }
    
    func setupLoadMoreDataSpinner(){
        pagingSpinner.startAnimating()
        pagingSpinner.hidesWhenStopped = true
        tblPoke.tableFooterView = pagingSpinner
    }
    
    //MARK: Action ---------------------------------------------------------

    @IBAction func btnFilterClicked(_ sender : UIButton){
        vwFilter.isHidden = !vwFilter.isHidden
    }
    
    
    @IBAction func btnFilterOptionClicked(_ sender : UIButton){
        vwFilter.isHidden = true
        
        var array: [Poke] = pokeHelper_Parser.arrPoke
        array.sort { $0.name ?? "" < $1.name ?? "" }
        
        if pokeHelper_Parser.arrPoke.first?.name == array.first?.name
        {
            pokeHelper_Parser.arrPoke = pokeHelper_Parser.arrPoke.reversed()
        }
        else{
            pokeHelper_Parser.arrPoke.sort { $0.name ?? "" < $1.name ?? "" }
        }
        
        tblPoke.reloadData()
    }
}


//MARK: tableView Delegate ---------------------------------------------------------

extension HomeVC : UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pokeHelper_Parser.arrPoke.count 
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PokeTblCell") as! PokeTblCell
        cell.setupData(pokeHelper_Parser.arrPoke[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let url = pokeHelper_Parser.arrPoke[indexPath.row].url{
            pokeHelper_Parser.getPokeDetail(url: url, viewController: self)
        }

    }
    
}

//MARK: Poke Helper Parser Delegate ---------------------------------------------------------

extension HomeVC : PokeHelperParserDelegate{
    
    func Success() {
        tblPoke.reloadData()
        self.noDataFound()
        pokeHelper_Parser.page += 1
        pagingSpinner.stopAnimating()
    }
    
    func Failed(errormessage: String) {
        CommonMethodsClass.showAlertViewOnWindow(titleStr: "Alert", messageStr: errormessage, okBtnTitleStr: "OK")
        self.noDataFound()
    }
    
    func SuccessPokeDetails() {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "HomeDetailsVC") as! HomeDetailsVC
        vc.objPoke = pokeHelper_Parser.objPokeDetails
        self.navigationController?.pushViewController(vc, animated: true)
    }
    func FailedPokeDetails(errormessage: String) {
        CommonMethodsClass.showAlertViewOnWindow(titleStr: "Alert", messageStr: errormessage, okBtnTitleStr: "OK")
    }
    
}

//MARK: scrollView Delegate ---------------------------------------------------------

extension HomeVC{
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
           let Y = scrollView.contentOffset.y
           let scrollViewContentHeight = scrollView.contentSize.height
           if Y > scrollViewContentHeight - scrollView.frame.height {
               pokeHelper_Parser.getPokeList(viewController: self)
               pagingSpinner.startAnimating()
           }
       }
    
}
