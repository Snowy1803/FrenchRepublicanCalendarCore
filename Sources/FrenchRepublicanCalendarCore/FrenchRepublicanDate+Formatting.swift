//
//  FrenchRepublicanCalendarCalculator.swift
//  FrenchRepublicanCalendar Shared
//
//  Created by Emil on 06/03/2020.
//  Copyright © 2020 Snowy_1803. All rights reserved.
//

import Foundation

extension FrenchRepublicanDate: CustomDebugStringConvertible {
    static let allMonthNames = ["Vendémiaire", "Brumaire", "Frimaire", "Nivôse", "Pluviôse", "Ventôse", "Germinal", "Floréal", "Prairial", "Messidor", "Thermidor", "Fructidor", "Sansculottide"]
    static let sansculottidesDayNames = ["Jour de la vertu", "Jour du génie", "Jour du travail", "Jour de l'opinion", "Jour des récompenses", "Jour de la révolution"]

    static let shortMonthNames = ["Vend.r", "Brum.r", "Frim.r", "Niv.ô", "Pluv.ô", "Vent.ô", "Germ.l", "Flo.l", "Prai.l", "Mes.or", "Ther.or", "Fru.or", "Ss.cu"]
    static let sansculottidesShortNames = ["Jr vertu", "Jr génie", "Jr travail", "Jr opinion", "Jr récompenses", "Jr révolution"]
    
    static let allWeekdays = ["Primidi", "Duodi", "Tridi", "Quartidi", "Quintidi", "Sextidi", "Septidi", "Octidi", "Nonidi", "Décadi"]
    
    static let allDayNames = ["Raisin", "Safran", "Châtaigne", "Colchique", "Cheval", "Balsamine", "Carotte", "Amaranthe", "Panais", "Cuve", "Pomme de terre", "Immortelle", "Potiron", "Réséda", "Ane", "Belle de nuit", "Citrouille", "Sarrasin", "Tournesol", "Pressoir", "Chanvre", "Pêche", "Navet", "Amaryllis", "Bœuf", "Aubergine", "Piment", "Tomate", "Orge", "Tonneau", "Pomme", "Céleri", "Poire", "Betterave", "Oie", "Héliotrope", "Figue", "Scorsonère", "Alisier", "Charrue", "Salsifis", "Macre", "Topinambour", "Endive", "Dindon", "Chervis", "Cresson", "Dentelaire", "Grenade", "Herse", "Bacchante", "Azerole", "Garance", "Orange", "Faisan", "Pistache", "Macjonc", "Coing", "Cormier", "Rouleau", "Raiponce", "Turneps", "Chicorée", "Nèfle", "Cochon", "Mâche", "Chou-fleur", "Miel", "Genièvre", "Pioche", "Cire", "Raifort", "Cèdre", "Sapin", "Chevreuil", "Ajonc", "Cyprès", "Lierre", "Sabine", "Hoyau", "Erable sucré", "Bruyère", "Roseau", "Oseille", "Grillon", "Pignon", "Liège", "Truffe", "Olive", "Pelle", "Tourbe", "Houille", "Bitume", "Soufre", "Chien", "Lave", "Terre végétale", "Fumier", "Salpêtre", "Fléau", "Granit", "Argile", "Ardoise", "Grès", "Lapin", "Silex", "Marne", "Pierre à chaux", "Marbre", "Van", "Pierre à Plâtre", "Sel", "Fer", "Cuivre", "Chat", "Étain", "Plomb", "Zinc", "Mercure", "Crible", "Lauréole", "Mousse", "Fragon", "Perce Neige", "Taureau", "Laurier thym", "Amadouvier", "Mézéréon", "Peuplier", "Cognée", "Ellébore", "Brocoli", "Laurier", "Avelinier", "Vache", "Buis", "Lichen", "If", "Pulmonaire", "Serpette", "Thlaspi", "Thimèle", "Chiendent", "Trainasse", "Lièvre", "Guède", "Noisetier", "Cyclamen", "Chélidoine", "Traineau", "Tussilage", "Cornouiller", "Violier", "Troëne", "Bouc", "Asaret", "Alaterne", "Violette", "Marceau", "Bêche", "Narcisse", "Orme", "Fumeterre", "Vélar", "Chèvre", "Épinard", "Doronic", "Mouron", "Cerfeuil", "Cordeau", "Mandragore", "Persil", "Cochléaire", "Pâquerette", "Thon", "Pissenlit", "Sylve", "Capillaire", "Frêne", "Plantoir", "Primevère", "Platane", "Asperge", "Tulipe", "Poule", "Blette", "Bouleau", "Jonquille", "Aulne", "Couvoir", "Pervenche", "Charme", "Morille", "Hêtre", "Abeille", "Laitue", "Mélèze", "Cigüe", "Radis", "Ruche", "Gainier", "Romaine", "Marronnier", "Roquette", "Pigeon", "Lilas", "Anémone", "Pensée", "Myrtille", "Greffoir", "Rose", "Chêne", "Fougère", "Aubépine", "Rossignol", "Ancolie", "Muguet", "Champignon", "Hyacinthe", "Râteau", "Rhubarbe", "Sainfoin", "Bâton d'or", "Chamerops", "Ver à soie", "Consoude", "Pimprenelle", "Corbeille d'or", "Arroche", "Sarcloir", "Statice", "Fritillaire", "Bourache", "Valériane", "Carpe", "Fusain", "Civette", "Buglosse", "Sénevé", "Houlette", "Luzerne", "Hémérocalle", "Trèfle", "Angélique", "Canard", "Mélisse", "Fromental", "Martagon", "Serpolet", "Faux", "Fraise", "Bétoine", "Pois", "Acacia", "Caille", "Œillet", "Sureau", "Pavot", "Tilleul", "Fourche", "Barbeau", "Camomille", "Chèvre-feuille", "Caille-lait", "Tanche", "Jasmin", "Verveine", "Thym", "Pivoine", "Chariot", "Seigle", "Avoine", "Oignon", "Véronique", "Mulet", "Romarin", "Concombre", "Échalotte", "Absinthe", "Faucille", "Coriandre", "Artichaut", "Girofle", "Lavande", "Chamois", "Tabac", "Groseille", "Gesse", "Cerise", "Parc", "Menthe", "Cumin", "Haricot", "Orcanète", "Pintade", "Sauge", "Ail", "Vesce", "Blé", "Chalémie", "Épeautre", "Bouillon blanc", "Melon", "Ivraie", "Bélier", "Prêle", "Armoise", "Carthame", "Mûre", "Arrosoir", "Panis", "Salicorne", "Abricot", "Basilic", "Brebis", "Guimauve", "Lin", "Amande", "Gentiane", "Écluse", "Carline", "Câprier", "Lentille", "Aunée", "Loutre", "Myrte", "Colza", "Lupin", "Coton", "Moulin", "Prune", "Millet", "Lycoperdon", "Escourgeon", "Saumon", "Tubéreuse", "Sucrion", "Apocyn", "Réglisse", "Échelle", "Pastèque", "Fenouil", "Épine vinette", "Noix", "Truite", "Citron", "Cardère", "Nerprun", "Tagette", "Hotte", "Églantier", "Noisette", "Houblon", "Sorgho", "Écrevisse", "Bigarade", "Verge d'or", "Maïs", "Marron", "Panier", "Vertu", "Génie", "Travail", "Opinion", "Récompenses", "Révolution"]
    
    static let allQuarters = ["Automne", "Hiver", "Printemps", "Été", "Sansculottides"]

    /// Returns string as EEEE d MMMM "An" yyyy
    func toVeryLongString() -> String {
        if components.month == 13 {
            return toLongString()
        }
        return "\(weekdayName) \(toLongString())"
    }
    
    /// Returns string as d MMMM "An" yyyy
    func toLongString() -> String {
        return "\(toLongStringNoYear()) An \(formattedYear)"
    }
    
    /// Returns string as d MMMM
    func toLongStringNoYear() -> String {
        if components.month == 13 {
            return "\(FrenchRepublicanDate.sansculottidesDayNames[components.day! - 1])"
        }
        return "\(components.day!) \(monthName)"
    }
    
    /// Returns string as d MMM
    func toShortString() -> String {
        if components.month == 13 {
            return "\(FrenchRepublicanDate.sansculottidesShortNames[components.day! - 1])"
        }
        return "\(components.day!) \(shortMonthName)"
    }
    
    /// Returns string as dd/MM/yyy
    func toShortenedString() -> String {
        return "\(components.day! >= 10 ? "" : "0")\(components.day!)/\(components.month! >= 10 ? "" : "0")\(components.month!)/\(formattedYear)"
    }
    
    /// Localized month name
    var monthName: String {
        FrenchRepublicanDate.allMonthNames[components.month! - 1]
    }
    
    /// Localized shortened month name
    var shortMonthName: String {
        FrenchRepublicanDate.shortMonthNames[components.month! - 1]
    }
    
    /// the day of the week's name
    var weekdayName: String {
        FrenchRepublicanDate.allWeekdays[components.weekday! - 1]
    }
    
    /// the name given to the day
    var dayName: String {
        FrenchRepublicanDate.allDayNames[dayInYear - 1]
    }
    
    /// the name of the quarter, or season
    var quarter: String {
        FrenchRepublicanDate.allQuarters[components.quarter! - 1]
    }
    
    /// the year, formatted according to this converter's options (roman numerals, or simply an interpolated Int)
    var formattedYear: String {
        if options.romanYear {
            // Inspired from https://learnappmaking.com/roman-numerals-swift/
            
            let numerals = [
                (1000, "M"),
                (900, "CM"),
                (500, "D"),
                (400, "CD"),
                (100, "C"),
                (90, "XC"),
                (50, "L"),
                (40, "XL"),
                (10, "X"),
                (9, "IX"),
                (5, "V"),
                (4, "IV"),
                (1, "I"),
            ]

            var result = ""
            var number = components.year!

            while number > 0 {
                for (decimal, numeral) in numerals {
                    if number >= decimal {
                        number -= decimal
                        result += numeral
                        break
                    }
                }
            }

            return result
        } else {
            return String(components.year!)
        }
    }
    
    /// the debug description of this value
    var debugDescription: String {
        return "\(toVeryLongString()), quarter \(components.quarter!), decade \(components.weekOfMonth!) of month, decade \(components.weekOfYear!) of year, day \(dayInYear) of year"
    }
    
    /// Returns the wiktionary or wikipedia page link associated with the day name.
    var descriptionURL: URL? {
        let wikipediaOverrides = [
            "Belle de nuit": "Mirabilis_jalapa",
            "Amaryllis": "Amaryllis_(plante)",
            "Erable sucré": "%C3%89rable_%C3%A0_sucre",
            "Perce Neige": "Perce-neige",
            "Laurier thym": "Viorne_tin",
            "Thimèle": "Daphn%C3%A9_garou",
            "Bâton d'or": "Girofl%C3%A9e_des_murailles",
            "Chamerops": "Chamaerops_humilis",
            "Épine vinette": "%C3%89pine-vinette",
            "Verge d'or": "Solidago"
        ]
        if let override = wikipediaOverrides[dayName] {
            return URL(string: "https://fr.wikipedia.org/wiki/\(override)")
        }
        guard let sanitizedName = dayName.lowercased().addingPercentEncoding(withAllowedCharacters: .urlPathAllowed) else {
            return nil
        }
        return URL(string: "https://fr.wiktionary.org/wiki/\(sanitizedName)")
    }
}
