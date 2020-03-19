//
//  StVC.swift
//  XMLAddressParse
//
//  Created by taeuk on 2020/03/19.
//  Copyright © 2020 김태욱. All rights reserved.
//

import UIKit

class StVC: UITableViewController, XMLParserDelegate {

    var gu = ""
    var dong = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(gu)
        print(dong)
        
        let encodeG = gu.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        let encodeD = dong.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        
        let baseURL = "http://openapi.epost.go.kr/postal/retrieveLotNumberAdressAreaCdService/retrieveLotNumberAdressAreaCdService/getEupMyunDongList?ServiceKey=\(app)&brtcCd=\(encodeG)&signguCd=\(encodeD)"
        let parse = XMLParser(contentsOf: URL(string: baseURL)!)
        
        parse?.delegate = self
        parse?.parse()
    }

    var currentElement = ""
    var listed = PassData()
    var infoArr = [PassData]()
    
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
        print(listed)
        currentElement = elementName
        if (elementName == "eupMyunDongList"){
            _ = PassData()
            
        }
    }
    
    func parser(_ parser: XMLParser, foundCharacters string: String) {
        
        switch currentElement {
            //case "brtcCd":
        //listed.list.append(string)
        case "emdCd":
            listed.donglist.append(string)
            print(listed.donglist)
        default:
            break
        }
        
    }
    
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        
        if(elementName == "eupMyunDongList"){
            infoArr.append(listed)
        }
    }
    
    // MARK: - Table view data source


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return infoArr.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = listed.donglist[indexPath.row]
        
        return cell
    }
    var urlss = ""
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("\(gu)+\(dong)+\(listed.donglist[indexPath.row])")
        urlss = "https://apis.openapi.sk.com/weather/current/minutely?version=2&city=\(gu)&county=\(dong)&village=\(listed.donglist[indexPath.row])&appKey=l7xx522b5771a40d42a59a3fafcdeadf41cb"
        print(urlss)
        self.dismiss(animated: true, completion: nil)
    }
}
