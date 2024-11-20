//
//  Currency.swift
//  CurrencyConverterApp
//
//  Created by Duong Tran Minh Hoang on 17/11/2024.
//

import Foundation

enum Currency: String, CaseIterable, Codable {
    case aed = "AED", afn = "AFN", all = "ALL", amd = "AMD", ang = "ANG", aoa = "AOA", ars = "ARS"
    case aud = "AUD", awg = "AWG", azn = "AZN", bam = "BAM", bbd = "BBD", bdt = "BDT", bgn = "BGN"
    case bhd = "BHD", bif = "BIF", bmd = "BMD", bnd = "BND", bob = "BOB", brl = "BRL", bsd = "BSD"
    case btn = "BTN", bwp = "BWP", byn = "BYN", bzd = "BZD", cad = "CAD", cdf = "CDF", chf = "CHF"
    case clp = "CLP", cny = "CNY", cop = "COP", crc = "CRC", cup = "CUP", cve = "CVE", czk = "CZK"
    case djf = "DJF", dkk = "DKK", dop = "DOP", dzd = "DZD", egp = "EGP", ern = "ERN", etb = "ETB"
    case eur = "EUR", fjd = "FJD", fkp = "FKP", fok = "FOK", gbp = "GBP", gel = "GEL", ggp = "GGP"
    case ghs = "GHS", gip = "GIP", gmd = "GMD", gnf = "GNF", gtq = "GTQ", gyd = "GYD", hkd = "HKD"
    case hnl = "HNL", hrk = "HRK", htg = "HTG", huf = "HUF", idr = "IDR", ils = "ILS", imp = "IMP"
    case inr = "INR", iqd = "IQD", irr = "IRR", isk = "ISK", jep = "JEP", jmd = "JMD", jod = "JOD"
    case jpy = "JPY", kes = "KES", kgs = "KGS", khr = "KHR", kid = "KID", kmf = "KMF", krw = "KRW"
    case kwd = "KWD", kyd = "KYD", kzt = "KZT", lak = "LAK", lbp = "LBP", lkr = "LKR", lrd = "LRD"
    case lsl = "LSL", lyd = "LYD", mad = "MAD", mdl = "MDL", mga = "MGA", mkd = "MKD", mmk = "MMK"
    case mnt = "MNT", mop = "MOP", mru = "MRU", mur = "MUR", mvr = "MVR", mwk = "MWK", mxn = "MXN"
    case myr = "MYR", mzn = "MZN", nad = "NAD", ngn = "NGN", nio = "NIO", nok = "NOK", npr = "NPR"
    case nzd = "NZD", omr = "OMR", pab = "PAB", pen = "PEN", pgk = "PGK", php = "PHP", pkr = "PKR"
    case pln = "PLN", pyg = "PYG", qar = "QAR", ron = "RON", rsd = "RSD", rub = "RUB", rwf = "RWF"
    case sar = "SAR", sbd = "SBD", scr = "SCR", sdg = "SDG", sek = "SEK", sgd = "SGD", shp = "SHP"
    case sle = "SLE", sos = "SOS", srd = "SRD", ssp = "SSP", stn = "STN", syp = "SYP", szl = "SZL"
    case thb = "THB", tjs = "TJS", tmt = "TMT", tnd = "TND", top = "TOP", try_ = "TRY", ttd = "TTD"
    case tvd = "TVD", twd = "TWD", tzs = "TZS", uah = "UAH", ugx = "UGX", usd = "USD", uyu = "UYU"
    case uzs = "UZS", ves = "VES", vnd = "VND", vuv = "VUV", wst = "WST", xaf = "XAF", xcd = "XCD"
    case xdr = "XDR", xof = "XOF", xpf = "XPF", yer = "YER", zar = "ZAR", zmw = "ZMW", zwl = "ZWL"

    var symbol: String {
        switch self {
        case .usd: return "$"
        case .eur: return "€"
        case .gbp: return "£"
        case .jpy: return "¥"
        case .cny: return "¥"
        case .krw: return "₩"
        case .inr: return "₹"
        case .rub: return "₽"
        case .try_: return "₺"
        default: return rawValue
        }
    }
}
