//
//  EstVC.swift
//  XMLAddressParse
//
//  Created by taeuk on 2020/03/18.
//  Copyright © 2020 김태욱. All rights reserved.
//

import UIKit

class EstVC: UITableViewController, XMLParserDelegate {
    
    var parsing = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let encodeC = parsing.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        
        let basedURL = "http://openapi.epost.go.kr/postal/retrieveLotNumberAdressAreaCdService/retrieveLotNumberAdressAreaCdService/getSiGunGuList?ServiceKey=\(app)&brtcCd=\(String(describing: encodeC))"
        //print(basedURL)
        
        let myURL = XMLParser(contentsOf: URL(string: basedURL)!)
        myURL?.delegate = self
        myURL?.parse()
        
    }
    
    var currentElement = ""
    var listed = PassData()
    var infoArr = [PassData]()
    
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
        //print(listed)
        currentElement = elementName
        if (elementName == "siGunGuList"){
            _ = PassData()
            
        }
    }
    
    func parser(_ parser: XMLParser, foundCharacters string: String) {
        
        switch currentElement {
            //case "brtcCd":
        //listed.list.append(string)
        case "signguCd":
            listed.gulist.append(string)
            //print(listed.gulist)
        default:
            break
        }
        
    }
    
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        
        if(elementName == "siGunGuList"){
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
        cell.textLabel?.text = listed.gulist[indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "dong", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let nextVC = segue.destination as! StVC
        if let indexPath = tableView.indexPathForSelectedRow{
            nextVC.gu = parsing
            nextVC.dong = listed.gulist[indexPath.row]
        }
    }
}
