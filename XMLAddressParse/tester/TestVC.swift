//
//  TestVC.swift
//  XMLAddressParse
//
//  Created by taeuk on 2020/03/18.
//  Copyright © 2020 김태욱. All rights reserved.
//

import UIKit
struct PassData {
    
    var list: [String] = []
    var gulist: [String] = []
    var donglist: [String] = []
}
class TestVC: UITableViewController, XMLParserDelegate {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        //let baseURL = "http://openapi.epost.go.kr/postal/retrieveLotNumberAdressAreaCdService/retrieveLotNumberAdressAreaCdService/getBorodCityList?ServiceKey=FlU1bcU7d1hYaiRMhdz8ccgzUVPcy8hRJcdIvCxvCTufUzcZJZkGSS4W8LBHhSVkbsaVmpVtixPh3DFXkg7Cdg%3D%3D"
        
        let baseURL = "http://openapi.epost.go.kr/postal/retrieveLotNumberAdressAreaCdService/retrieveLotNumberAdressAreaCdService/getBorodCityList?ServiceKey=\(app)"
        let sas = baseURL.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        //print(sas!)
        let parser = XMLParser(contentsOf: URL(string: baseURL)!)
        parser?.delegate = self
        parser?.parse()
        
    }

    
    var currentElement = ""
    var listed = PassData()
    var infoArr = [PassData]()
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
        //print(listed)
        currentElement = elementName
        if (elementName == "borodCity"){
            _ = PassData()
            
        }
    }
    
    func parser(_ parser: XMLParser, foundCharacters string: String) {
        
        switch currentElement {
            //case "brtcCd":
                //listed.list.append(string)
            case "brtcNm":
                listed.list.append(string)
            
            default:
               break
        }
        
    }
    
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        
        if(elementName == "borodCity"){
            infoArr.append(listed)
            //print(infoArr)
        }
    }
    
    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return infoArr.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        cell.textLabel?.text = listed.list[indexPath.row]
        return cell
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "Table", sender: self)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! EstVC
        
        
        if let indexPath = tableView.indexPathForSelectedRow {
            destinationVC.parsing = listed.list[indexPath.row]

        }
    }
}
