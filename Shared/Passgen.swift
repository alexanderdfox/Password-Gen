//
//  Passgen.swift
//  SwiftyFoxPassword
//
//  Created by Alexander Fox on 8/9/21.
//  Copyright © 2021 Alexander Fox. All rights reserved.
//

import SwiftUI
import CryptoKit

func password( length:Int,  specialChars:Bool, vowelChars:Bool, constChars:Bool,  numChars:Bool,  upperOnly:Bool,  lowerOnly:Bool, extra:Bool, Extras:String, emoji: Bool) -> String {
    
    var pass :String = ""
    
    for _ in 1...length {
        
        let r = arc4random() % 5
        
        if (upperOnly && lowerOnly) || (!upperOnly && !lowerOnly) {
            if (r % 2 == 1) {
                pass += getChar(specialChars: specialChars,vowelChars: vowelChars,constChars: constChars, numChars: numChars, extra: extra, Extras: Extras, emoji: emoji).lowercased()
            }
            else {
                pass += getChar(specialChars: specialChars,vowelChars: vowelChars,constChars: constChars, numChars: numChars, extra: extra, Extras: Extras, emoji: emoji).uppercased()
            }
        }
        else if (upperOnly && !lowerOnly) {
            pass += getChar(specialChars: specialChars,vowelChars: vowelChars,constChars: constChars, numChars: numChars, extra: extra, Extras: Extras, emoji: emoji).uppercased()
        }
        else if (!upperOnly && lowerOnly) {
            pass += getChar(specialChars: specialChars,vowelChars: vowelChars,constChars: constChars, numChars: numChars, extra: extra, Extras: Extras, emoji: emoji).lowercased()
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

func emojis() -> String {
    let contiguousEmoji: [UnicodeScalar] = {
        let ranges: [ClosedRange<Int>] = [
            0x1f600...0x1f64f,
            0x1f680...0x1f6c5,
            0x1f6cb...0x1f6d2,
            0x1f6e0...0x1f6e5,
            0x1f6f3...0x1f6fa,
            0x1f7e0...0x1f7eb,
            0x1f90d...0x1f93a,
            0x1f93c...0x1f945,
            0x1f947...0x1f971,
            0x1f973...0x1f976,
            0x1f97a...0x1f9a2,
            0x1f9a5...0x1f9aa,
            0x1f9ae...0x1f9ca,
            0x1f9cd...0x1f9ff,
            0x1fa70...0x1fa73,
            0x1fa78...0x1fa7a,
            0x1fa80...0x1fa82,
            0x1fa90...0x1fa95,
        ]
        
        return ranges.reduce([], +).map { return UnicodeScalar($0)! }
    }()

    var allEmojis = ""
    for emoji in contiguousEmoji {
        allEmojis += String(emoji)
    }

    return allEmojis
}

func getChar( specialChars:Bool, vowelChars:Bool, constChars:Bool,  numChars:Bool, extra:Bool, Extras:String, emoji:Bool) -> String {
    
    var emojis = emojis()
    var numbers = "0123456789"
    var consonants = "bcdfghjklmnpqrstvwxyz"
    var vowels = "aeiouy"
    var specials = "!#$&*-_."

    var all = specials + vowels + consonants + numbers + emojis
    var ncve = numbers + consonants + vowels + emojis
    var cnse = consonants + numbers + specials + emojis
    var vnse = vowels + numbers + specials + emojis
    var vcse = vowels + consonants + specials + emojis
    var vce = vowels + consonants + emojis
    var vse = vowels + specials + emojis
    var nce = numbers + consonants + emojis
    var nse = numbers + specials + emojis
    var cse = consonants + specials + emojis
    var vne = vowels + numbers + emojis
    var svcn = specials + vowels + consonants + numbers
    var ncv = numbers + consonants + vowels
    var cns = consonants + numbers + specials
    var vns = vowels + numbers + specials
    var vcs = vowels + consonants + specials
    var vc = vowels + consonants
    var vs = vowels + specials
    var nc = numbers + consonants
    var ns = numbers + specials
    var cs = consonants + specials
    var vn = vowels + numbers
    var ne = numbers + emojis
    var ve = vowels + emojis
    var ce = consonants + emojis
    var se = specials + emojis
    
    var theChar:String = ""

    if (extra) {
        all += Extras
        ncve += Extras
        cnse += Extras
        vnse += Extras
        vcse += Extras
        vce += Extras
        vse += Extras
        nce += Extras
        nse += Extras
        cse += Extras
        vne += Extras
        svcn += Extras
        ncv += Extras
        cns += Extras
        vns += Extras
        vcs += Extras
        vc += Extras
        vs += Extras
        nc += Extras
        ns += Extras
        cs += Extras
        vn += Extras
        ne += Extras
        ve += Extras
        ce += Extras
        se += Extras
        emojis += Extras
        numbers += Extras
        consonants += Extras
        vowels += Extras
        specials += Extras
    }
    
    let A = all.index(all.startIndex, offsetBy: Int(arc4random_uniform(UInt32(all.count))))
    let E = emojis.index(emojis.startIndex, offsetBy: Int(arc4random_uniform(UInt32(emojis.count))))
    let N = numbers.index(numbers.startIndex, offsetBy: Int(arc4random_uniform(UInt32(numbers.count))))
    let V = vowels.index(vowels.startIndex, offsetBy: Int(arc4random_uniform(UInt32(vowels.count))))
    let C = consonants.index(consonants.startIndex, offsetBy: Int(arc4random_uniform(UInt32(consonants.count))))
    let S = specials.index(specials.startIndex, offsetBy: Int(arc4random_uniform(UInt32(specials.count))))
    let NE = ne.index(ne.startIndex, offsetBy: Int(arc4random_uniform(UInt32(ne.count))))
    let VE = ve.index(ve.startIndex, offsetBy: Int(arc4random_uniform(UInt32(ve.count))))
    let CE = ce.index(ce.startIndex, offsetBy: Int(arc4random_uniform(UInt32(ce.count))))
    let SE = se.index(se.startIndex, offsetBy: Int(arc4random_uniform(UInt32(se.count))))
    let VC = vc.index(vc.startIndex, offsetBy: Int(arc4random_uniform(UInt32(vc.count))))
    let VS = vs.index(vs.startIndex, offsetBy: Int(arc4random_uniform(UInt32(vs.count))))
    let NC = nc.index(nc.startIndex, offsetBy: Int(arc4random_uniform(UInt32(nc.count))))
    let NS = ns.index(ns.startIndex, offsetBy: Int(arc4random_uniform(UInt32(ns.count))))
    let CS = cs.index(cs.startIndex, offsetBy: Int(arc4random_uniform(UInt32(cs.count))))
    let VN = vn.index(vn.startIndex, offsetBy: Int(arc4random_uniform(UInt32(vn.count))))
    let VCE = vce.index(vce.startIndex, offsetBy: Int(arc4random_uniform(UInt32(vce.count))))
    let VSE = vse.index(vse.startIndex, offsetBy: Int(arc4random_uniform(UInt32(vse.count))))
    let NCE = nce.index(nce.startIndex, offsetBy: Int(arc4random_uniform(UInt32(nce.count))))
    let NSE = nse.index(nse.startIndex, offsetBy: Int(arc4random_uniform(UInt32(nse.count))))
    let CSE = cse.index(cse.startIndex, offsetBy: Int(arc4random_uniform(UInt32(cse.count))))
    let VNE = vne.index(vne.startIndex, offsetBy: Int(arc4random_uniform(UInt32(vne.count))))
    let NCV = ncv.index(ncv.startIndex, offsetBy: Int(arc4random_uniform(UInt32(ncv.count))))
    let CNS = cns.index(cns.startIndex, offsetBy: Int(arc4random_uniform(UInt32(cns.count))))
    let VNS = vns.index(vns.startIndex, offsetBy: Int(arc4random_uniform(UInt32(vns.count))))
    let VCS = vcs.index(vcs.startIndex, offsetBy: Int(arc4random_uniform(UInt32(vcs.count))))
    let NCVE = ncve.index(ncve.startIndex, offsetBy: Int(arc4random_uniform(UInt32(ncve.count))))
    let CNSE = cnse.index(cnse.startIndex, offsetBy: Int(arc4random_uniform(UInt32(cnse.count))))
    let VNSE = vnse.index(vnse.startIndex, offsetBy: Int(arc4random_uniform(UInt32(vnse.count))))
    let VCSE = vcse.index(vce.startIndex, offsetBy: Int(arc4random_uniform(UInt32(vcse.count))))
    let SVCN = svcn.index(svcn.startIndex, offsetBy: Int(arc4random_uniform(UInt32(svcn.count))))
    let EXTRAS = Extras.index(Extras.startIndex, offsetBy: Int(arc4random_uniform(UInt32(Extras.count))))
    
    if (specialChars && vowelChars && constChars && numChars && emoji) {
        theChar = String(all[A])
    }
    else if (!specialChars && !vowelChars && !constChars && !numChars && emoji) {
        theChar = String(emojis[E])
    }
    else if (!specialChars && !vowelChars && !constChars && numChars && !emoji) {
        theChar = String(numbers[N])
    }
    else if (!specialChars && vowelChars && !constChars && !numChars && !emoji) {
        theChar = String(vowels[V])
    }
    else if (!specialChars && !vowelChars && constChars && !numChars && !emoji) {
        theChar = String(consonants[C])
    }
    else if (specialChars && !vowelChars && !constChars && !numChars && !emoji) {
        theChar = String(specials[S])
    }
    else if (!specialChars && !vowelChars && !constChars && numChars && emoji) {
        theChar = String(ne[NE])
    }
    else if (!specialChars && vowelChars && !constChars && !numChars && emoji) {
        theChar = String(ve[VE])
    }
    else if (!specialChars && !vowelChars && constChars && !numChars && emoji) {
        theChar = String(ce[CE])
    }
    else if (specialChars && !vowelChars && !constChars && !numChars && emoji) {
        theChar = String(se[SE])
    }
    else if (!specialChars && vowelChars && constChars && !numChars && !emoji) {
        theChar = String(vc[VC])
    }
    else if (specialChars && vowelChars && !constChars && !numChars && !emoji) {
        theChar = String(vs[VS])
    }
    else if (!specialChars && !vowelChars && constChars && numChars && !emoji) {
        theChar = String(nc[NC])
    }
    else if (specialChars && !vowelChars && !constChars && numChars && !emoji) {
        theChar = String(ns[NS])
    }
    else if (specialChars && !vowelChars && constChars && !numChars && !emoji) {
        theChar = String(cs[CS])
    }
    else if (!specialChars && vowelChars && !constChars && numChars && !emoji) {
        theChar = String(vn[VN])
    }
    else if (!specialChars && vowelChars && constChars && !numChars && emoji) {
        theChar = String(vce[VCE])
    }
    else if (specialChars && vowelChars && !constChars && !numChars && emoji) {
        theChar = String(vse[VSE])
    }
    else if (!specialChars && !vowelChars && constChars && numChars && emoji) {
        theChar = String(nce[NCE])
    }
    else if (specialChars && !vowelChars && !constChars && numChars && emoji) {
        theChar = String(nse[NSE])
    }
    else if (specialChars && !vowelChars && constChars && !numChars && emoji) {
        theChar = String(cse[CSE])
    }
    else if (!specialChars && vowelChars && !constChars && numChars && emoji) {
        theChar = String(vne[VNE])
    }
    else if (!specialChars && vowelChars && constChars && numChars && !emoji) {
        theChar = String(ncv[NCV])
    }
    else if (specialChars && !vowelChars && constChars && numChars && !emoji) {
        theChar = String(cns[CNS])
    }
    else if (specialChars && vowelChars && !constChars && numChars && !emoji) {
        theChar = String(vns[VNS])
    }
    else if (specialChars && vowelChars && constChars && !numChars && !emoji) {
        theChar = String(vcs[VCS])
    }
    else if (!specialChars && vowelChars && constChars && numChars && emoji) {
        theChar = String(ncve[NCVE])
    }
    else if (specialChars && !vowelChars && constChars && numChars && emoji) {
        theChar = String(cnse[CNSE])
    }
    else if (specialChars && vowelChars && !constChars && numChars && emoji) {
        theChar = String(vnse[VNSE])
    }
    else if (specialChars && vowelChars && constChars && !numChars && emoji) {
        theChar = String(vcse[VCSE])
    }
    else if (specialChars && vowelChars && constChars && numChars && !emoji) {
        theChar = String(svcn[SVCN])
    }
    else if (!specialChars && !vowelChars && !constChars && !numChars && !emoji && extra && !Extras.isEmpty) {
        theChar = String(Extras[EXTRAS])
    }
    else {
        theChar = ""
    }
    
    return theChar
}

func crypt(input: String) -> Array<Any> {
    let data = input.data(using: .utf8)
    let key = SymmetricKey(size: .bits256)
    let encryptdData = try! ChaChaPoly.seal(data!, using: key).combined
    let keyData = key.withUnsafeBytes { return Data(Array($0)) }
    
    return [encryptdData, keyData]
}

func dcrypt(input: Data, key: SymmetricKey) -> Data {
    let sealedBox = try! ChaChaPoly.SealedBox(combined: input)
    let decryptedData = try! ChaChaPoly.open(sealedBox, using: key)
    
    return decryptedData
}

func emctothepowerof(power: Int64, input: String) -> Array<Any> {
    let message = input.data(using: .utf8)
    var array = Array<Any>()
    for _ in 0...power {
        let key = SymmetricKey(size: .bits256)
        let cipher = try! ChaChaPoly.seal(message!, using: key).combined
        let keyData = key.withUnsafeBytes { return Data(Array($0)) }
        let a: Array<Any> = [cipher, keyData]
        array.append(a)
    }
    
    return array
}
