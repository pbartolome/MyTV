//: Playground - noun: a place where people can play

import IDZSwiftCommonCrypto

let contentPk = "20161217-EPISODE-00004-false"
let time = String(1484376342)
let data = contentPk.appending(time)
let key = "b2zN:Pzf:>WTiC=j$;_e!D.L"
let hash = HMAC(algorithm: .md5, key: key).update(string: data)?.final()

print(hexString(fromArray: hash!) == "a56629ac2788830f24967fa74dcef888")


let url = URL(string: "http://mvodt.lvlt.rtve.es/resources/TE_GLESP/mp4/9/4/1473694817049.mp4?nvb=20170309034419=20170309094419=0693b73ec9f7516c85822")!
let tokens = url.query!.components(separatedBy: "=")
let token = "nvb=\(tokens[1])&=nva=\(tokens[2])&=token=\(tokens[3])"

"http://\(url.host!)\(url.path)?\(token)"
