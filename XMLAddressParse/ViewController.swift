//
//  ViewController.swift
//  XMLAddressParse
//
//  Created by taeuk on 2020/03/16.
//  Copyright © 2020 김태욱. All rights reserved.
//

import UIKit
class gudata {
    
    var brtccd = ""
    var brtcnm = ""
    var ata: [String] = []
    var tat: [String] = []
}
class ViewController: UITableViewController, XMLParserDelegate {
    
    var datalist: [[String:String]] = []
    var detaildata : [String: String] = [:]
    var elementTemp: String = ""
    var blank: Bool = false
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        //let baseURL = "https://raw.githubusercontent.com/ChoiJinYoung/iphonewithswift2/master/weather.xml"
        let baseURL = "http://openapi.epost.go.kr/postal/retrieveLotNumberAdressAreaCdService/retrieveLotNumberAdressAreaCdService/getBorodCityList?ServiceKey=FlU1bcU7d1hYaiRMhdz8ccgzUVPcy8hRJcdIvCxvCTufUzcZJZkGSS4W8LBHhSVkbsaVmpVtixPh3DFXkg7Cdg%3D%3D"
        
       //let baseURL = "http://openapi.epost.go.kr/postal/retrieveLotNumberAdressAreaCdService/retrieveLotNumberAdressAreaCdService/getSiGunGuList?ServiceKey=FlU1bcU7d1hYaiRMhdz8ccgzUVPcy8hRJcdIvCxvCTufUzcZJZkGSS4W8LBHhSVkbsaVmpVtixPh3DFXkg7Cdg%3D%3D&brtcCd=서울"
        let parser = XMLParser(contentsOf: URL(string: baseURL)!)
        
        parser?.delegate = self
        parser?.parse()
    }
    
    var currentElement="" // 태그를 저장할 문자열
    var b = gudata() // 파싱을 통해 얻은 정보를 저장할 클래스(임의로 생성해줌)
    var busInfoArr = Array<gudata>() // 값이 여러 개일 경우 클래스를 저장할 배열
    
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
        //        print("didStartElement : \(elementName)")
//        elementTemp = elementName
//        blank = true
        currentElement = elementName
        if (elementName == "borodCity"){
            b = gudata()
            
        }
    }
    
    func parser(_ parser: XMLParser, foundCharacters string: String) {
//        if blank == true && elementTemp != "borodCity" && elementTemp != "BorodCityResponse"  {
//            //print("foundCharacters : \(string)")
//            detaildata[elementTemp] = string
//        }
        switch currentElement {
            case "brtcCd":
                //b.brtccd = string
                b.ata = [string]
                //print(b.brtccd)
            case "brtcNm":
                //b.brtcnm = string
                b.tat.append(string)
                print(b.tat)
            default:
               break
        }
    }
    
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
//        if elementName == "borodCity"{
//            datalist += [detaildata]
//            //print(detaildata)
//        }
//        blank = false
//        print("didEndElement : \(elementName)")
        if(elementName == "borodCity"){
           busInfoArr.append(b)
            //print(busInfoArr)
        }
    }
    
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! WeatherCell
        //        print("indexPath : \(indexPath)")
        //        print("indexPath row : \(indexPath.row)")
        print(b.tat)
        let dicTemp = busInfoArr[indexPath.row]
        
        //print(dicTemp)
        
        //cell.textLabel?.text = dicTemp["brtcNm"]
        cell.textLabel?.text = b.tat[indexPath.row]
        //print(b.tat)
//        let weatherStr = dicTemp["weather"]
//
//        cell.weatherLabel.text = weatherStr
//        cell.temperatureLabel.text = dicTemp["temperature"]
//
//        if weatherStr == "맑음"{
//            cell.imgView?.image = UIImage(named: "sunny.png")
//        }else if weatherStr == "비"{
//            cell.imgView?.image = UIImage(named: "rainy.png")
//        }else if weatherStr == "흐림"{
//            cell.imgView?.image = UIImage(named: "cloudy.png")
//        }else if weatherStr == "눈"{
//            cell.imgView?.image = UIImage(named: "snow.png")
//        }else {
//            cell.imgView?.image = UIImage(named: "blizzard.png")
//
//        }
        
        
        return cell
    }
    
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//      if let cell = sender as? UITableViewCell, let indexPath = tableView.indexPath(for: cell) {
//        let target = datalist[indexPath.row]
//
//        if let vc = segue.destination as? GuVC {
//          vc.memo = target
//        }
//      }
//    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
//        var das = gudata()
//        let dicTemp = datalist[indexPath.row]
//        let tdc = dicTemp["brtcNm"]
        
        //print(dicTemp["brtcNm"]!)
    }
}


class WeatherCell: UITableViewCell{
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}
