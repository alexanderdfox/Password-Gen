import Cocoa

func password( length:Int,  specialChars:Bool, vowelChars:Bool, constChars:Bool,  numChars:Bool,  upperOnly:Bool,  lowerOnly:Bool, extra:Bool, Extras:String) -> String {
    
    var pass :String = ""
    
    for _ in 1...length {
        
        let r = arc4random() % 5
        
        if (upperOnly && lowerOnly) || (!upperOnly && !lowerOnly) {
            if (r % 2 == 1) {
                pass += getChar(specialChars: specialChars,vowelChars: vowelChars,constChars: constChars, numChars: numChars, extra: extra, Extras: Extras).lowercased()
            }
            else {
                pass += getChar(specialChars: specialChars,vowelChars: vowelChars,constChars: constChars, numChars: numChars, extra: extra, Extras: Extras).uppercased()
            }
        }
        else if (upperOnly && !lowerOnly) {
            pass += getChar(specialChars: specialChars,vowelChars: vowelChars,constChars: constChars, numChars: numChars, extra: extra, Extras: Extras).uppercased()
        }
        else if (!upperOnly && lowerOnly) {
            pass += getChar(specialChars: specialChars,vowelChars: vowelChars,constChars: constChars, numChars: numChars, extra: extra, Extras: Extras).lowercased()
        }
        else {
            pass = ""
        }
        
    }
    
    if (pass == "") {
        pass = ""
    }
    
    return pass
    
}

func getChar( specialChars:Bool, vowelChars:Bool, constChars:Bool,  numChars:Bool, extra:Bool, Extras:String) -> String {
    
    let numbers = "0123456789"
    let constanants = "bcdfghjklmnpqrstvwxyz"
    let vowels = "aeiouy"
    let specials = "!#$&*-_."
    let all = specials + vowels + constanants + numbers
    let ncv = numbers + constanants + vowels
    let cns = constanants + numbers + specials
    let vns = vowels + numbers + specials
    let vcs = vowels + constanants + specials
    let vc = vowels + constanants
    let vs = vowels + specials
    let nc = numbers + constanants
    let ns = numbers + specials
    let cs = constanants + specials
    let vn = vowels + numbers
    let n = numbers.index(numbers.startIndex, offsetBy: Int(arc4random_uniform(UInt32(numbers.count))))
    let v = vowels.index(vowels.startIndex, offsetBy: Int(arc4random_uniform(UInt32(vowels.count))))
    let c = constanants.index(constanants.startIndex, offsetBy: Int(arc4random_uniform(UInt32(constanants.count))))
    let s = specials.index(specials.startIndex, offsetBy: Int(arc4random_uniform(UInt32(specials.count))))
    let a = all.index(all.startIndex, offsetBy: Int(arc4random_uniform(UInt32(all.count))))
    let NCV = ncv.index(ncv.startIndex, offsetBy: Int(arc4random_uniform(UInt32(ncv.count))))
    let CNS = cns.index(cns.startIndex, offsetBy: Int(arc4random_uniform(UInt32(cns.count))))
    let VNS = vns.index(vns.startIndex, offsetBy: Int(arc4random_uniform(UInt32(vns.count))))
    let VCS = vcs.index(vcs.startIndex, offsetBy: Int(arc4random_uniform(UInt32(vcs.count))))
    let VC = vc.index(vc.startIndex, offsetBy: Int(arc4random_uniform(UInt32(vc.count))))
    let VS = vs.index(vs.startIndex, offsetBy: Int(arc4random_uniform(UInt32(vs.count))))
    let NC = nc.index(nc.startIndex, offsetBy: Int(arc4random_uniform(UInt32(nc.count))))
    let NS = ns.index(ns.startIndex, offsetBy: Int(arc4random_uniform(UInt32(ns.count))))
    let CS = cs.index(cs.startIndex, offsetBy: Int(arc4random_uniform(UInt32(cs.count))))
    let VN = vn.index(vn.startIndex, offsetBy: Int(arc4random_uniform(UInt32(vn.count))))
    
    var theChar:String = ""
    
    if (specialChars && vowelChars && constChars && numChars && !extra) {
        theChar = String(all[a])
    }
    else if (!specialChars && !vowelChars && !constChars && numChars && !extra) {
        theChar = String(numbers[n])
    }
    else if (!specialChars && !vowelChars && constChars && !numChars && !extra) {
        theChar = String(constanants[c])
    }
    else if (!specialChars && vowelChars && !constChars && !numChars && !extra) {
        theChar = String(vowels[v])
    }
    else if (specialChars && !vowelChars && !constChars && !numChars && !extra) {
        theChar = String(specials[s])
    }
    else if (!specialChars && vowelChars && constChars && numChars && !extra) {
        theChar = String(ncv[NCV])
    }
    else if (specialChars && !vowelChars && constChars && numChars && !extra) {
        theChar = String(cns[CNS])
    }
    else if (specialChars && vowelChars && !constChars && numChars && !extra) {
        theChar = String(vns[VNS])
    }
    else if (specialChars && vowelChars && constChars && !numChars && !extra) {
        theChar = String(vcs[VCS])
    }
    else if (!specialChars && vowelChars && constChars && !numChars && !extra) {
        theChar = String(vc[VC])
    }
    else if (!specialChars && !vowelChars && constChars && numChars && !extra) {
        theChar = String(nc[NC])
    }
    else if (!specialChars && vowelChars && !constChars && numChars && !extra) {
        theChar = String(vn[VN])
    }
    else if (specialChars && !vowelChars && !constChars && numChars && !extra) {
        theChar = String(ns[NS])
    }
    else if (specialChars && vowelChars && !constChars && !numChars && !extra) {
        theChar = String(vs[VS])
    }
    else if (specialChars && !vowelChars && constChars && !numChars && !extra) {
        theChar = String(cs[CS])
    }
    else if (extra) {
        let alle = all + Extras
        let ne = numbers + Extras
        let ce = constanants + Extras
        let ve = vowels + Extras
        let se = specials + Extras
        let ncve = ncv + Extras
        let cnse = cns + Extras
        let vnse = vns + Extras
        let vcse = vcs + Extras
        let vce = vc + Extras
        let vse = vs + Extras
        let nce = nc + Extras
        let nse = ns + Extras
        let cse = cs + Extras
        let vne = vn + Extras
        let NE = ne.index(ne.startIndex, offsetBy: Int(arc4random_uniform(UInt32(ne.count))))
        let VE = ve.index(ve.startIndex, offsetBy: Int(arc4random_uniform(UInt32(ve.count))))
        let CE = ce.index(ce.startIndex, offsetBy: Int(arc4random_uniform(UInt32(ce.count))))
        let SE = se.index(se.startIndex, offsetBy: Int(arc4random_uniform(UInt32(se.count))))
        let AE = alle.index(alle.startIndex, offsetBy: Int(arc4random_uniform(UInt32(alle.count))))
        let NCVE = ncve.index(ncve.startIndex, offsetBy: Int(arc4random_uniform(UInt32(ncve.count))))
        let CNSE = cnse.index(cnse.startIndex, offsetBy: Int(arc4random_uniform(UInt32(cnse.count))))
        let VNSE = vnse.index(vnse.startIndex, offsetBy: Int(arc4random_uniform(UInt32(vnse.count))))
        let VCSE = vcse.index(vcse.startIndex, offsetBy: Int(arc4random_uniform(UInt32(vcse.count))))
        let VCE = vce.index(vce.startIndex, offsetBy: Int(arc4random_uniform(UInt32(vce.count))))
        let VSE = vse.index(vse.startIndex, offsetBy: Int(arc4random_uniform(UInt32(vse.count))))
        let NCE = nce.index(nce.startIndex, offsetBy: Int(arc4random_uniform(UInt32(nce.count))))
        let NSE = nse.index(nse.startIndex, offsetBy: Int(arc4random_uniform(UInt32(nse.count))))
        let CSE = cse.index(cse.startIndex, offsetBy: Int(arc4random_uniform(UInt32(cse.count))))
        let VNE = vne.index(vne.startIndex, offsetBy: Int(arc4random_uniform(UInt32(vne.count))))
        let e = Extras
        let E = e.index(e.startIndex, offsetBy: Int(arc4random_uniform(UInt32(e.count))))
        if (specialChars && vowelChars && constChars && numChars && extra) {
            theChar = String(alle[AE])
        }
        else if (!specialChars && !vowelChars && !constChars && numChars && extra) {
            theChar = String(ne[NE])
        }
        else if (!specialChars && !vowelChars && constChars && !numChars && extra) {
            theChar = String(ce[CE])
        }
        else if (!specialChars && vowelChars && !constChars && !numChars && extra) {
            theChar = String(ve[VE])
        }
        else if (specialChars && !vowelChars && !constChars && !numChars && extra) {
            theChar = String(se[SE])
        }
        else if (!specialChars && vowelChars && constChars && numChars && extra) {
            theChar = String(ncve[NCVE])
        }
        else if (specialChars && !vowelChars && constChars && numChars && extra) {
            theChar = String(cnse[CNSE])
        }
        else if (specialChars && vowelChars && !constChars && numChars && extra) {
            theChar = String(vnse[VNSE])
        }
        else if (specialChars && vowelChars && constChars && !numChars && extra) {
            theChar = String(vcse[VCSE])
        }
        else if (!specialChars && vowelChars && constChars && !numChars && extra) {
            theChar = String(vce[VCE])
        }
        else if (!specialChars && !vowelChars && constChars && numChars && extra) {
            theChar = String(nce[NCE])
        }
        else if (!specialChars && vowelChars && !constChars && numChars && extra) {
            theChar = String(vne[VNE])
        }
        else if (specialChars && !vowelChars && !constChars && numChars && extra) {
            theChar = String(nse[NSE])
        }
        else if (specialChars && vowelChars && !constChars && !numChars && extra) {
            theChar = String(vse[VSE])
        }
        else if (specialChars && !vowelChars && constChars && !numChars && extra) {
            theChar = String(cse[CSE])
        }
        else if (!specialChars && !vowelChars && !constChars && !numChars && extra && Extras != "") {
            theChar = String(e[E])
        }
        else {
            theChar = ""
        }
    }
    else {
        theChar = ""
    }
    
    return theChar
    
}
