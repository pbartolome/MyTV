//: Playground - noun: a place where people can play

import IDZSwiftCommonCrypto

let contentPk = "20161217-EPISODE-00004-false"
let time = String(1484376342)
let data = contentPk.appending(time)
let key = "b2zN:Pzf:>WTiC=j$;_e!D.L"
let hash = HMAC(algorithm: .md5, key: key).update(string: data)?.final()

print(hexString(fromArray: hash!) == "a56629ac2788830f24967fa74dcef888")

