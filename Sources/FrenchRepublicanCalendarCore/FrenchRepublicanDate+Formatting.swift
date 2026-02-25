//
//  FrenchRepublicanCalendarCalculator.swift
//  FrenchRepublicanCalendarCore
//
//  Created by Emil on 06/03/2020.
//  Copyright © 2020 Snowy_1803. All rights reserved.
//
//  This Source Code Form is subject to the terms of the Mozilla Public
//  License, v. 2.0. If a copy of the MPL was not distributed with this
//  file, You can obtain one at https://mozilla.org/MPL/2.0/.
//

import Foundation

extension FrenchRepublicanDate: CustomDebugStringConvertible {
    public static let allMonthNames = ["Vendémiaire", "Brumaire", "Frimaire", "Nivôse", "Pluviôse", "Ventôse", "Germinal", "Floréal", "Prairial", "Messidor", "Thermidor", "Fructidor", "Sansculottide"]
    public static let sansculottidesDayNames = ["Jour de la vertu", "Jour du génie", "Jour du travail", "Jour de l'opinion", "Jour des récompenses", "Jour de la révolution"]

    public static let shortMonthNames = ["Vend.r", "Brum.r", "Frim.r", "Niv.ô", "Pluv.ô", "Vent.ô", "Germ.l", "Flo.l", "Prai.l", "Mes.or", "Ther.or", "Fru.or", "Ss.cu"]
    public static let sansculottidesShortNames = ["Jr vertu", "Jr génie", "Jr travail", "Jr opinion", "Jr récompenses", "Jr révolution"]
    
    public static let allWeekdays = ["Primidi", "Duodi", "Tridi", "Quartidi", "Quintidi", "Sextidi", "Septidi", "Octidi", "Nonidi", "Décadi"]
    
    public static let allDayNames = ["Raisin", "Safran", "Châtaigne", "Colchique", "Cheval", "Balsamine", "Carotte", "Amaranthe", "Panais", "Cuve", "Pomme de terre", "Immortelle", "Potiron", "Réséda", "Ane", "Belle de nuit", "Citrouille", "Sarrasin", "Tournesol", "Pressoir", "Chanvre", "Pêche", "Navet", "Amaryllis", "Bœuf", "Aubergine", "Piment", "Tomate", "Orge", "Tonneau", "Pomme", "Céleri", "Poire", "Betterave", "Oie", "Héliotrope", "Figue", "Scorsonère", "Alisier", "Charrue", "Salsifis", "Macre", "Topinambour", "Endive", "Dindon", "Chervis", "Cresson", "Dentelaire", "Grenade", "Herse", "Bacchante", "Azerole", "Garance", "Orange", "Faisan", "Pistache", "Macjonc", "Coing", "Cormier", "Rouleau", "Raiponce", "Turneps", "Chicorée", "Nèfle", "Cochon", "Mâche", "Chou-fleur", "Miel", "Genièvre", "Pioche", "Cire", "Raifort", "Cèdre", "Sapin", "Chevreuil", "Ajonc", "Cyprès", "Lierre", "Sabine", "Hoyau", "Erable sucré", "Bruyère", "Roseau", "Oseille", "Grillon", "Pignon", "Liège", "Truffe", "Olive", "Pelle", "Tourbe", "Houille", "Bitume", "Soufre", "Chien", "Lave", "Terre végétale", "Fumier", "Salpêtre", "Fléau", "Granit", "Argile", "Ardoise", "Grès", "Lapin", "Silex", "Marne", "Pierre à chaux", "Marbre", "Van", "Pierre à Plâtre", "Sel", "Fer", "Cuivre", "Chat", "Étain", "Plomb", "Zinc", "Mercure", "Crible", "Lauréole", "Mousse", "Fragon", "Perce Neige", "Taureau", "Laurier thym", "Amadouvier", "Mézéréon", "Peuplier", "Cognée", "Ellébore", "Brocoli", "Laurier", "Avelinier", "Vache", "Buis", "Lichen", "If", "Pulmonaire", "Serpette", "Thlaspi", "Thimèle", "Chiendent", "Trainasse", "Lièvre", "Guède", "Noisetier", "Cyclamen", "Chélidoine", "Traineau", "Tussilage", "Cornouiller", "Violier", "Troëne", "Bouc", "Asaret", "Alaterne", "Violette", "Marceau", "Bêche", "Narcisse", "Orme", "Fumeterre", "Vélar", "Chèvre", "Épinard", "Doronic", "Mouron", "Cerfeuil", "Cordeau", "Mandragore", "Persil", "Cochléaire", "Pâquerette", "Thon", "Pissenlit", "Sylve", "Capillaire", "Frêne", "Plantoir", "Primevère", "Platane", "Asperge", "Tulipe", "Poule", "Blette", "Bouleau", "Jonquille", "Aulne", "Couvoir", "Pervenche", "Charme", "Morille", "Hêtre", "Abeille", "Laitue", "Mélèze", "Cigüe", "Radis", "Ruche", "Gainier", "Romaine", "Marronnier", "Roquette", "Pigeon", "Lilas", "Anémone", "Pensée", "Myrtille", "Greffoir", "Rose", "Chêne", "Fougère", "Aubépine", "Rossignol", "Ancolie", "Muguet", "Champignon", "Hyacinthe", "Râteau", "Rhubarbe", "Sainfoin", "Bâton d'or", "Chamerops", "Ver à soie", "Consoude", "Pimprenelle", "Corbeille d'or", "Arroche", "Sarcloir", "Statice", "Fritillaire", "Bourache", "Valériane", "Carpe", "Fusain", "Civette", "Buglosse", "Sénevé", "Houlette", "Luzerne", "Hémérocalle", "Trèfle", "Angélique", "Canard", "Mélisse", "Fromental", "Martagon", "Serpolet", "Faux", "Fraise", "Bétoine", "Pois", "Acacia", "Caille", "Œillet", "Sureau", "Pavot", "Tilleul", "Fourche", "Barbeau", "Camomille", "Chèvre-feuille", "Caille-lait", "Tanche", "Jasmin", "Verveine", "Thym", "Pivoine", "Chariot", "Seigle", "Avoine", "Oignon", "Véronique", "Mulet", "Romarin", "Concombre", "Échalotte", "Absinthe", "Faucille", "Coriandre", "Artichaut", "Girofle", "Lavande", "Chamois", "Tabac", "Groseille", "Gesse", "Cerise", "Parc", "Menthe", "Cumin", "Haricot", "Orcanète", "Pintade", "Sauge", "Ail", "Vesce", "Blé", "Chalémie", "Épeautre", "Bouillon blanc", "Melon", "Ivraie", "Bélier", "Prêle", "Armoise", "Carthame", "Mûre", "Arrosoir", "Panis", "Salicorne", "Abricot", "Basilic", "Brebis", "Guimauve", "Lin", "Amande", "Gentiane", "Écluse", "Carline", "Câprier", "Lentille", "Aunée", "Loutre", "Myrte", "Colza", "Lupin", "Coton", "Moulin", "Prune", "Millet", "Lycoperdon", "Escourgeon", "Saumon", "Tubéreuse", "Sucrion", "Apocyn", "Réglisse", "Échelle", "Pastèque", "Fenouil", "Épine vinette", "Noix", "Truite", "Citron", "Cardère", "Nerprun", "Tagette", "Hotte", "Églantier", "Noisette", "Houblon", "Sorgho", "Écrevisse", "Bigarade", "Verge d'or", "Maïs", "Marron", "Panier", "Vertu", "Génie", "Travail", "Opinion", "Récompenses", "Révolution"]
    
    public static let allQuarters = ["Automne", "Hiver", "Printemps", "Été", "Sansculottides"]
    
    internal static let allDayExplanations: [String] = [
        // Raisin
        "Fruit de la vigne, dont la récolte marque le début de l'automne et de l'année républicaine",
        // Safran
        "Plante à bulbe fleurissant en automne, cultivée pour son épice jaune précieuse",
        // Châtaigne
        "Fruit du châtaignier, aliment d'hiver nutritif et fondamental pour les campagnes",
        // Colchique
        "Fleur toxique des prés qui éclot à l'automne, marquant la fin des beaux jours",
        // Cheval
        "Animal de trait et de monte essentiel pour l'agriculture et le transport",
        // Balsamine
        "Plante herbacée dont les fruits explosent au toucher pour disperser leurs graines",
        // Carotte
        "Légume racine cultivé et consommé abondamment durant la saison froide",
        // Amaranthe
        "Plante robuste aux fleurs rouges persistantes, symbole d'immortalité",
        // Panais
        "Légume racine ancien très consommé en Europe avant l'arrivée de la pomme de terre",
        // Cuve
        "Grand récipient de bois ou de pierre servant à la fermentation du raisin",
        // Pomme de terre
        "Tubercule nourrissant, récemment popularisé par Parmentier pour éviter les famines",
        // Immortelle
        "Fleur jaune qui conserve sa couleur et sa forme même une fois séchée",
        // Potiron
        "Grosse courge d'automne, cultivée pour sa chair généreuse et sa conservation",
        // Réséda
        "Plante parfumée cultivée pour son odeur agréable et ses propriétés médicinales",
        // Ane
        "Animal de bât robuste et frugal, compagnon indispensable des paysans",
        // Belle de nuit
        "Fleur ornementale qui ne s'ouvre qu'en fin de journée et diffuse un doux parfum",
        // Citrouille
        "Courge ronde de la famille des cucurbitacées, récoltée à l'approche de l'hiver",
        // Sarrasin
        "Céréale à grains noirs, appelée 'blé noir', poussant sur des terres pauvres",
        // Tournesol
        "Grande plante oléagineuse dont la fleur tourne pour suivre la course du soleil",
        // Pressoir
        "Machine agricole servant à extraire le jus des raisins pour en faire du vin",
        // Chanvre
        "Plante cultivée pour ses fibres textiles (cordes, voiles) et ses graines",
        // Pêche
        "Fruit d'été et d'automne très apprécié, cultivé dans les vergers français",
        // Navet
        "Légume racine d'hiver résistant au froid, base de l'alimentation paysanne",
        // Amaryllis
        "Plante à bulbe offrant de grandes fleurs éclatantes à l'automne",
        // Bœuf
        "Animal de trait puissant indispensable pour tirer la charrue lors des labours",
        // Aubergine
        "Légume-fruit violet cultivé dans les régions chaudes du sud de la France",
        // Piment
        "Plante dont le fruit piquant est utilisé pour relever le goût des aliments",
        // Tomate
        "Fruit estival rouge cultivé comme légume, introduit d'Amérique du Sud",
        // Orge
        "Céréale rustique utilisée pour nourrir le bétail, faire du pain et brasser la bière",
        // Tonneau
        "Récipient cylindrique en bois cerclé de fer, servant à conserver le vin",
        // Pomme
        "Fruit du pommier, très répandu en France pour la consommation ou le cidre",
        // Céleri
        "Plante potagère dont on consomme la racine et les tiges comme aromates",
        // Poire
        "Fruit du poirier, cultivé en verger pour sa chair douce et juteuse",
        // Betterave
        "Racine charnue cultivée pour l'alimentation animale et humaine, ou pour le sucre",
        // Oie
        "Volaille d'élevage appréciée pour sa chair, sa graisse et ses plumes",
        // Héliotrope
        "Plante dont les fleurs violettes très odorantes se tournent vers le soleil",
        // Figue
        "Fruit sucré du figuier, typique des régions méridionales et de l'automne",
        // Scorsonère
        "Légume racine à peau noire et chair blanche, de la famille des salsifis",
        // Alisier
        "Arbre forestier dont les petits fruits, les alises, sont comestibles blets",
        // Charrue
        "Instrument agricole indispensable pour retourner la terre avant les semailles",
        // Salsifis
        "Plante potagère dont on consomme la racine allongée à la chair douce",
        // Macre
        "Plante aquatique dont le fruit, appelé 'châtaigne d'eau', est comestible",
        // Topinambour
        "Tubercule rustique originaire d'Amérique, au goût rappelant l'artichaut",
        // Endive
        "Pousse blanche et amère de la chicorée, forcée dans l'obscurité l'hiver",
        // Dindon
        "Grande volaille d'origine américaine, appréciée pour les repas de fête",
        // Chervis
        "Ancien légume racine au goût sucré, populaire avant d'être supplanté par d'autres",
        // Cresson
        "Plante herbacée poussant dans l'eau claire, consommée en salade",
        // Dentelaire
        "Plante vivace dont les racines étaient utilisées pour soulager les maux de dents",
        // Grenade
        "Fruit rouge du grenadier rempli de grains juteux, poussant au sud",
        // Herse
        "Outil agricole garni de pointes pour briser les mottes de terre après le labour",
        // Bacchante
        "Plante à petites fleurs, dont le nom évoque les prêtresses de Bacchus (dieu du vin)",
        // Azerole
        "Petit fruit rouge acidulé de l'azerolier, cousin de l'aubépine",
        // Garance
        "Plante dont la racine fournit un puissant colorant rouge pour les tissus",
        // Orange
        "Agrume hivernal importé ou cultivé dans les orangeries, perçu comme un luxe",
        // Faisan
        "Grand oiseau à plumage coloré, très prisé comme gibier de chasse",
        // Pistache
        "Fruit à coque vert originaire du Moyen-Orient, acclimaté dans le sud de l'Europe",
        // Macjonc
        "Plante des zones humides parfois confondue avec le jonc, utilisée en vannerie",
        // Coing
        "Fruit jaune et parfumé, trop dur pour être mangé cru mais idéal en gelée",
        // Cormier
        "Arbre rustique donnant des petites poires (cormes) consommées très mûres",
        // Rouleau
        "Cylindre lourd passé sur les champs pour tasser la terre après les semis",
        // Raiponce
        "Plante sauvage comestible dont les feuilles et la racine charnue se mangent en salade",
        // Turneps
        "Variété de chou-navet cultivée massivement pour le fourrage d'hiver du bétail",
        // Chicorée
        "Plante amère dont on torréfiait la racine pour remplacer le café",
        // Nèfle
        "Fruit du néflier d'hiver, consommé blet (très mûr) après les premières gelées",
        // Cochon
        "Animal d'élevage essentiel, pourvoyeur de viande et de graisse pour l'hiver",
        // Mâche
        "Petite salade d'hiver très résistante au froid, aussi appelée 'doucette'",
        // Chou-fleur
        "Variété de chou dont on consomme la tête blanche formée de bourgeons floraux",
        // Miel
        "Substance sucrée produite par les abeilles, principal édulcorant de l'époque",
        // Genièvre
        "Petit fruit noir du genévrier, utilisé comme épice ou pour aromatiser l'alcool",
        // Pioche
        "Outil manuel de terrassement pour creuser ou remuer la terre dure",
        // Cire
        "Substance produite par les abeilles, utilisée pour fabriquer des bougies d'éclairage",
        // Raifort
        "Plante racine au goût très piquant, utilisée comme condiment fort",
        // Cèdre
        "Grand arbre conifère au bois odorant, majestueux et symbole de longévité",
        // Sapin
        "Conifère persistant des montagnes, symbole de la vie végétale en plein hiver",
        // Chevreuil
        "Petit cervidé agile des forêts européennes, gibier courant en hiver",
        // Ajonc
        "Arbuste épineux à fleurs jaunes, utilisé broyé comme fourrage en hiver",
        // Cyprès
        "Conifère au port élancé, souvent planté dans le sud de la France et près des tombes",
        // Lierre
        "Plante grimpante au feuillage persistant, qui reste verte même sous la neige",
        // Sabine
        "Arbuste résineux de la famille des genévriers, utilisé en pharmacopée ancienne",
        // Hoyau
        "Outil agricole à large lame recourbée, utilisé pour sarcler ou défricher",
        // Erable sucré
        "Arbre dont la sève est récoltée pour produire un sirop très sucré",
        // Bruyère
        "Plante des landes aux fleurs roses d'hiver, utilisée pour faire des balais",
        // Roseau
        "Plante des marais à tige creuse, utilisée pour faire des toits en chaume",
        // Oseille
        "Plante potagère aux feuilles acides, appréciée dans les soupes",
        // Grillon
        "Insecte dont le chant rythme les soirées d'été, parfois gardé l'hiver près du foyer",
        // Pignon
        "Graine comestible extraite de la pomme du pin parasol",
        // Liège
        "Écorce épaisse du chêne-liège, récoltée pour fabriquer des bouchons et isolants",
        // Truffe
        "Champignon souterrain au parfum puissant, recherché par les porcs truffiers",
        // Olive
        "Fruit de l'olivier, base de l'alimentation méditerranéenne et de l'huile",
        // Pelle
        "Outil à large lame plate utilisé pour ramasser ou déplacer la terre et le grain",
        // Tourbe
        "Matière combustible issue de la décomposition de végétaux en milieu humide",
        // Houille
        "Charbon de terre, ressource minière vitale pour chauffer et forger",
        // Bitume
        "Mélange naturel d'hydrocarbures, utilisé pour étanchéifier et colmater",
        // Soufre
        "Élément minéral jaune volcanique, utilisé en poudres ou en chimie",
        // Chien
        "Le plus ancien animal domestique, gardien de troupeau et de la ferme",
        // Lave
        "Roche fondue émise par les volcans, se solidifiant en minéraux fertiles",
        // Terre végétale
        "Couche supérieure du sol, riche en matière organique et indispensable aux cultures",
        // Fumier
        "Mélange de litière et de déjections animales, servant d'engrais naturel",
        // Salpêtre
        "Nitrate de potassium récolté sur les murs humides pour fabriquer la poudre à canon",
        // Fléau
        "Outil agricole composé de deux bâtons liés, pour battre le grain et le séparer de la paille",
        // Granit
        "Roche magmatique très dure et granuleuse, servant à la construction d'édifices",
        // Argile
        "Terre meuble et imperméable, malléable humide, cuite pour la poterie et les tuiles",
        // Ardoise
        "Roche feuilletée gris-noir exploitée pour couvrir les toits des habitations",
        // Grès
        "Roche sédimentaire dure faite de sable consolidé, utilisée pour meules et pavés",
        // Lapin
        "Petit mammifère très prolifique, élevé en clapier pour sa viande et sa fourrure",
        // Silex
        "Pierre très dure servant à produire des étincelles ou historiquement des outils",
        // Marne
        "Roche calcaire et argileuse utilisée pour amender les sols trop acides",
        // Pierre à chaux
        "Roche calcaire cuite dans des fours pour obtenir de la chaux de construction",
        // Marbre
        "Roche calcaire cristallisée, appréciée en sculpture et en architecture",
        // Van
        "Panier plat en osier utilisé pour secouer et nettoyer le grain de ses impuretés",
        // Pierre à Plâtre
        "Gypse que l'on chauffe et broie pour obtenir du plâtre à bâtir",
        // Sel
        "Minéral indispensable à la conservation des aliments et à la vie, extrait des marais salants",
        // Fer
        "Métal le plus utilisé pour forger des outils agricoles, des armes et des structures",
        // Cuivre
        "Métal rougeâtre malléable, utilisé pour les ustensiles de cuisine et la monnaie",
        // Chat
        "Félin domestique protégeant les réserves de grains contre les rongeurs",
        // Étain
        "Métal gris argenté servant à étamer le cuivre et à fabriquer la vaisselle commune",
        // Plomb
        "Métal lourd et mou, servant à la tuyauterie, aux toitures et aux munitions",
        // Zinc
        "Métal blanc bleuâtre utilisé pour protéger le fer de la rouille ou en toiture",
        // Mercure
        "Métal liquide à température ambiante, utilisé dans les thermomètres et miroirs",
        // Crible
        "Sorte de tamis permettant de trier les grains selon leur taille après le battage",
        // Lauréole
        "Petit arbuste à feuilles persistantes fleurissant en hiver ou au début du printemps",
        // Mousse
        "Végétal spongieux poussant dans les lieux humides et ombragés, typique de l'hiver",
        // Fragon
        "Arbuste piquant aussi appelé 'petit houx', dont les boules rouges égayent l'hiver",
        // Perce Neige
        "Petite fleur blanche courageuse, la première à éclore avant la fin des neiges",
        // Taureau
        "Mâle reproducteur de l'espèce bovine, symbole de force brutale et de fertilité",
        // Laurier thym
        "Arbuste méditerranéen aromatique aux feuilles persistantes, appelé aussi viorne-tin",
        // Amadouvier
        "Champignon parasite des arbres dont on tire l'amadou pour allumer du feu",
        // Mézéréon
        "Arbuste toxique dont les fleurs roses très parfumées éclosent sur le bois nu en hiver",
        // Peuplier
        "Grand arbre poussant près de l'eau, dont le bois tendre a de multiples usages",
        // Cognée
        "Grosse hache employée par les bûcherons pour abattre les arbres",
        // Ellébore
        "Plante d'hiver toxique appelée 'rose de Noël', fleurissant par grand froid",
        // Brocoli
        "Variété de chou vert d'origine italienne, consommé pour ses tiges florales",
        // Laurier
        "Arbuste aux feuilles aromatiques persistantes, symbole de gloire depuis l'Antiquité",
        // Avelinier
        "Nom ancien du noisetier, donnant des noisettes (les avelines)",
        // Vache
        "Femelle bovine indispensable pour le lait, le beurre, le fromage et le cuir",
        // Buis
        "Arbuste au bois extrêmement dur et aux petites feuilles d'un vert perpétuel",
        // Lichen
        "Organisme symbiotique poussant sur les pierres et les arbres dans l'humidité hivernale",
        // If
        "Conifère très toxique et résistant, dont le bois élastique servait à faire des arcs",
        // Pulmonaire
        "Plante à fleurs tachetées, utilisée autrefois pour soigner les maladies respiratoires",
        // Serpette
        "Couteau à lame courbe, outil indispensable du vigneron et du jardinier pour tailler",
        // Thlaspi
        "Petite plante herbacée appelée aussi monnoyère à cause de ses fruits ronds",
        // Thimèle
        "Nom ancien d'une variété de daphné, petit arbuste fleuri d'hiver",
        // Chiendent
        "Herbe tenace et envahissante, hantise du paysan mais dont la racine a des vertus médicinales",
        // Trainasse
        "Plante rampante mauvaise herbe, souvent identifiée à la renouée des oiseaux",
        // Lièvre
        "Mammifère très rapide de la famille du lapin, gibier recherché aux longues oreilles",
        // Guède
        "Plante aussi appelée pastel, cultivée pour produire une teinture bleue très prisée",
        // Noisetier
        "Arbuste des haies rurales produisant les noisettes dès la fin de l'été",
        // Cyclamen
        "Plante à tubercules produisant de jolies fleurs renversées en sous-bois",
        // Chélidoine
        "Plante sauvage dont la sève jaune soignait autrefois les verrues",
        // Traineau
        "Véhicule sans roues, glissant sur la neige ou la glace pour le transport hivernal",
        // Tussilage
        "Plante dont la fleur jaune sort de terre avant les feuilles dès le début du printemps",
        // Cornouiller
        "Arbuste donnant les cornouilles, petits fruits rouges acidulés, au bois très dur",
        // Violier
        "Fleur du printemps apparentée à la giroflée, très odorante et décorative",
        // Troëne
        "Arbuste rustique couramment planté en haies pour protéger les jardins et vergers",
        // Bouc
        "Mâle de la chèvre, reconnaissable à ses cornes et à son odeur forte",
        // Asaret
        "Plante vivace des sous-bois à petites fleurs brunes cachées, aux vertus vomitives",
        // Alaterne
        "Arbuste méditerranéen aux feuilles coriaces et aux baies noires appréciées des oiseaux",
        // Violette
        "Petite fleur printanière très odorante, prisée pour les parfums et confiseries",
        // Marceau
        "Variété de saule dont les chatons duveteux annoncent l'arrivée du printemps",
        // Bêche
        "Outil manuel permettant au jardinier de retourner et d'aérer la terre en profondeur",
        // Narcisse
        "Fleur à bulbe printanière très odorante, blanche ou jaune",
        // Orme
        "Grand arbre feuillu jadis majestueux dans les campagnes, au bois résistant",
        // Fumeterre
        "Petite plante sauvage très commune dans les champs, utilisée en herboristerie",
        // Vélar
        "Plante de la famille des moutardes poussant dans les décombres (herbe aux chantres)",
        // Chèvre
        "Ruminant très agile élevé pour son lait, à l'origine de délicieux fromages",
        // Épinard
        "Légume feuille riche et vert foncé, dont la culture s'accélère au printemps",
        // Doronic
        "Fleur jaune lumineuse rappelant la marguerite, qui éclôt très tôt au printemps",
        // Mouron
        "Petite herbe sauvage rasante, dont certaines variétés sont appréciées des oiseaux",
        // Cerfeuil
        "Plante aromatique printanière au parfum subtil, indispensable dans la cuisine française",
        // Cordeau
        "Fil tendu entre deux piquets pour semer, planter ou tracer des sillons bien droits",
        // Mandragore
        "Plante méditerranéenne célèbre pour sa racine aux formes humaines, source de légendes",
        // Persil
        "Herbe aromatique verte très utilisée pour relever et garnir les plats",
        // Cochléaire
        "Plante riche en vitamine C, connue comme l'herbe au scorbut des marins",
        // Pâquerette
        "Petite fleur familière des prés, dont la floraison annonce l'approche de Pâques",
        // Thon
        "Grand poisson migrateur pêché en Méditerranée ou dans l'Atlantique au printemps",
        // Pissenlit
        "Plante aux fleurs jaunes dont on ramasse les jeunes feuilles printanières en salade",
        // Sylve
        "Nom poétique désignant la forêt, espace de ressources vitales pour la communauté",
        // Capillaire
        "Fougère délicate poussant sur les vieux murs et au bord des sources",
        // Frêne
        "Arbre robuste dont le bois flexible est idéal pour fabriquer les manches d'outils",
        // Plantoir
        "Outil conique en bois servant à faire des trous réguliers pour repiquer les plants",
        // Primevère
        "Petite fleur dont le nom signifie qu'elle est parmi les premières au printemps",
        // Platane
        "Grand arbre au tronc qui desquame, offrant une ombre épaisse sur les places des villages",
        // Asperge
        "Pousse de légume printanier très fin, récoltée dès sa sortie de terre",
        // Tulipe
        "Fleur bulbeuse très ornementale, à l'origine d'un engouement historique",
        // Poule
        "L'oiseau domestique le plus répandu, base de l'alimentation populaire grâce à ses œufs",
        // Blette
        "Légume robuste dont on consomme autant les feuilles (vert) que la côte blanche",
        // Bouleau
        "Arbre à l'écorce blanche reconnaissable, annonçant le printemps par sa montée de sève",
        // Jonquille
        "Variété jaune de narcisse parfumant les bois et prés du début du printemps",
        // Aulne
        "Arbre des rives et milieux humides, dont le bois résiste incroyablement bien dans l'eau",
        // Couvoir
        "Lieu ou dispositif aménagé pour que les poules couvent sereinement leurs œufs au printemps",
        // Pervenche
        "Petite fleur bleue tapissante qui égaie les sous-bois au retour des beaux jours",
        // Charme
        "Arbre forestier au bois très dur, souvent utilisé comme excellent bois de chauffage",
        // Morille
        "Champignon printanier alvéolé de grande valeur gastronomique",
        // Hêtre
        "Grand arbre forestier, son bois servait à la fabrication de nombreux meubles paysans",
        // Abeille
        "Insecte butineur symbole d'organisation et de travail, productrice du miel et de la cire",
        // Laitue
        "Salade printanière aux feuilles tendres, composante incontournable des potagers",
        // Mélèze
        "Seul conifère d'Europe qui perd ses aiguilles, dont les nouvelles poussent au printemps",
        // Cigüe
        "Plante sauvage au feuillage proche du persil mais mortellement toxique",
        // Radis
        "Petit légume racine rose et croquant, première récolte rapide du potager printanier",
        // Ruche
        "Abri construit pour accueillir une colonie d'abeilles domestiques",
        // Gainier
        "Petit arbre méditerranéen dit 'arbre de Judée', spectaculaire par sa floraison rose sur le bois",
        // Romaine
        "Variété de laitue allongée et croquante, résistante à la chaleur du printemps",
        // Marronnier
        "Arbre d'ornement très répandu, produisant des marrons non comestibles à l'automne",
        // Roquette
        "Salade printanière au goût piquant, appréciée dans le sud de la France",
        // Pigeon
        "Oiseau élevé dans les pigeonniers pour sa chair et pour ses fientes, excellent engrais",
        // Lilas
        "Arbuste très florifère en mai, dont les grappes violettes ou blanches embaument les jardins",
        // Anémone
        "Fleur délicate dont les pétales fragiles semblent s'envoler au moindre vent (fleur du vent)",
        // Pensée
        "Petite fleur colorée, variété cultivée de la violette, associée au souvenir",
        // Myrtille
        "Petite baie noire bleutée sauvage des régions montagneuses et sous-bois clairs",
        // Greffoir
        "Petit couteau très affûté utilisé pour pratiquer la greffe des arbres fruitiers au printemps",
        // Rose
        "La reine des fleurs, célébrée pour son parfum et sa beauté en plein mois de Floréal",
        // Chêne
        "Arbre royal et robuste, symbole de puissance, fournissant bois d'œuvre et glands",
        // Fougère
        "Plante sans fleurs des sous-bois humides, dont les frondes se déroulent au printemps",
        // Aubépine
        "Arbuste épineux des haies dont la floraison blanche parfumée signale le plein printemps",
        // Rossignol
        "Oiseau migrateur discret célèbre pour ses longs chants mélodieux durant les nuits de mai",
        // Ancolie
        "Jolie fleur printanière vivace, dont la forme complexe rappelle un regroupement d'oiseaux",
        // Muguet
        "Petite plante des bois aux clochettes blanches très odorantes et toxiques",
        // Champignon
        "Produit de la terre poussant après les pluies douces printanières, apprécié des cueilleurs",
        // Hyacinthe
        "Autre nom de la jacinthe, fleur printanière à bulbe très parfumée",
        // Râteau
        "Outil de jardin à dents, indispensable pour niveler la terre et rassembler herbes mortes ou cailloux",
        // Rhubarbe
        "Plante vivace dont on récolte les tiges acidulées au printemps pour faire des tartes et compotes",
        // Sainfoin
        "Plante fourragère très nutritive (le 'foin sain') cultivée pour nourrir les bêtes",
        // Bâton d'or
        "Surnom de la giroflée des murailles, dont les fleurs jaunes illuminent les vieux murs en mai",
        // Chamerops
        "Petit palmier européen rustique poussant spontanément dans le bassin méditerranéen",
        // Ver à soie
        "Chenille élevée pour produire le fil de soie précieux, nourrie de feuilles de mûrier",
        // Consoude
        "Plante aux grandes feuilles utilisée comme engrais naturel ou pour consolider les fractures",
        // Pimprenelle
        "Petite herbe aromatique dont les jeunes feuilles ont un léger goût de concombre",
        // Corbeille d'or
        "Plante tapissante qui se couvre d'une multitude de petites fleurs jaunes au printemps",
        // Arroche
        "Plante potagère consommée comme l'épinard, aux feuilles parfois rouges ou vertes",
        // Sarcloir
        "Outil à lame tranchante pour sarcler, c'est-à-dire couper les mauvaises herbes à la racine",
        // Statice
        "Plante maritime aux fleurs persistantes souvent utilisées pour faire des bouquets secs",
        // Fritillaire
        "Fleur à bulbe printanière étonnante avec sa cloche aux motifs quadrillés originaux",
        // Bourache
        "Plante robuste recouverte de poils raides, à fleurs bleues en forme d'étoile",
        // Valériane
        "Grande plante sauvage dont la racine est très prisée pour ses propriétés apaisantes",
        // Carpe
        "Gros poisson d'eau douce très élevé en étang, source importante de nourriture rurale",
        // Fusain
        "Arbuste dont les rameaux calcinés servent de crayon noir pour le dessin",
        // Civette
        "Petit nom de la ciboulette, herbe indispensable pour assaisonner soupes et omelettes",
        // Buglosse
        "Plante sauvage de la famille de la bourache dont les fleurs passent du rouge au bleu",
        // Sénevé
        "Plante donnant les petites graines de moutarde sauvage, dont on fait le condiment piquant",
        // Houlette
        "Bâton de berger souvent muni d'une petite pelle en fer ou d'un crochet à son extrémité",
        // Luzerne
        "Plante fourragère excellente pour les sols et pour nourrir le bétail avec son foin",
        // Hémérocalle
        "Fleur dont chaque bourgeon ne s'ouvre que pour une journée, d'où le nom 'beauté d'un jour'",
        // Trèfle
        "Petite plante fourragère sauvage très répandue dans les prairies au début de l'été",
        // Angélique
        "Grande plante aromatique dont on confit les tiges vertes brillantes en pâtisserie",
        // Canard
        "Oiseau aquatique élevé à la ferme pour sa viande grasse, ses œufs et ses plumes",
        // Mélisse
        "Herbe très citronnée réputée depuis des siècles pour apaiser les nerfs et l'estomac",
        // Fromental
        "Grande graminée des prés de fauche produisant un foin très riche pour le bétail",
        // Martagon
        "Lys sauvage des montagnes avec de belles fleurs retombantes aux pétales recourbés",
        // Serpolet
        "Thym sauvage poussant au ras du sol chaud, dont on fait d'excellentes infusions",
        // Faux
        "Longue lame recourbée au bout d'un manche pour faucher l'herbe ou le blé à deux mains",
        // Fraise
        "Petit fruit rouge du début de l'été, cueilli dans les bois ou cultivé au potager",
        // Bétoine
        "Plante médicinale des prés, longtemps considérée comme un remède universel",
        // Pois
        "Légume en gousse typique du mois de juin, mangé vert ou séché pour les soupes l'hiver",
        // Acacia
        "Arbre aux grappes de fleurs blanches odorantes au printemps, souvent appelé robinier",
        // Caille
        "Petit oiseau migrateur chassé l'été, apprécié en gastronomie pour sa chair fine",
        // Œillet
        "Fleur très appréciée pour ses couleurs vives et son puissant parfum épicé",
        // Sureau
        "Arbuste des haies dont on utilise les fleurs printanières en limonade et les baies à l'automne",
        // Pavot
        "Plante cultivée pour ses graines (boulangerie) ou pour ses propriétés sédatives (opium)",
        // Tilleul
        "Grand arbre protecteur dont on récolte les fleurs parfumées pour des tisanes calmantes",
        // Fourche
        "Outil agricole à longues dents indispensable pour soulever le foin et manipuler la paille",
        // Barbeau
        "Nom campagnard du bleuet, cette jolie fleur sauvage poussant dans les champs de blé",
        // Camomille
        "Plante odorante commune cueillie l'été et séchée pour ses vertus apaisantes en infusion",
        // Chèvre-feuille
        "Liane forestière dont la floraison estivale embaume délicatement l'air en fin de journée",
        // Caille-lait
        "Plante dont certaines espèces contiennent des enzymes permettant de faire cailler le lait",
        // Tanche
        "Poisson d'eau douce affectionnant les eaux calmes, élevé traditionnellement en étang",
        // Jasmin
        "Liane dont les petites fleurs blanches très parfumées fleurissent avec la chaleur estivale",
        // Verveine
        "Plante cultivée pour son feuillage au parfum citronné, très réputée en tisane digestive",
        // Thym
        "Petit arbuste bas des terres arides méditerranéennes, roi des herbes aromatiques de Provence",
        // Pivoine
        "Fleur généreuse du début de l'été, cultivée pour l'immense beauté de ses pétales",
        // Chariot
        "Voiture agricole à quatre roues tirée par des animaux pour les lourds transports de récoltes",
        // Seigle
        "Céréale robuste des terres pauvres, avec laquelle on fabriquait le pain noir paysan",
        // Avoine
        "Céréale indispensable cultivée massivement pour l'alimentation des chevaux de trait",
        // Oignon
        "Bulbe potager universellement consommé dans les foyers, facile à conserver toute l'année",
        // Véronique
        "Petite plante sauvage très commune aux fleurs d'un bleu d'une grande douceur",
        // Mulet
        "Hybride robuste et endurant issu de l'âne et de la jument, utilisé pour les travaux pénibles",
        // Romarin
        "Arbuste aromatique du sud de la France, au parfum camphré, utilisé en cuisine et médecine",
        // Concombre
        "Légume de plein été rafraîchissant, riche en eau, poussant à même le sol chaud",
        // Échalotte
        "Bulbe cousin de l'oignon cultivé pour son goût subtil, un grand classique des sauces françaises",
        // Absinthe
        "Plante amère et tonique utilisée pour préparer la fameuse liqueur anisée du même nom",
        // Faucille
        "Outil à lame courbe et courte utilisé à une main pour moissonner les céréales ou couper l'herbe",
        // Coriandre
        "Plante dont on consomme autant le feuillage frais que les graines en tant qu'épice",
        // Artichaut
        "Gros bourgeon floral de chardon que l'on consomme avant que la fleur ne s'épanouisse",
        // Girofle
        "Épice puissante issue du clou de girofle, bouton séché cultivé dans les colonies tropicales",
        // Lavande
        "Plante aromatique reine de la Provence, coupée en plein été pour parfumer le linge",
        // Chamois
        "Agile chèvre sauvage des Alpes et Pyrénées, dont la peau est très recherchée",
        // Tabac
        "Plante dont les grandes feuilles sont récoltées et séchées à la fin de l'été pour être fumées ou prisées",
        // Groseille
        "Petites baies rouges acidulées poussant en grappes au jardin, excellentes en gelée",
        // Gesse
        "Légumineuse parfois cultivée comme fourrage rustique, apparentée au pois de senteur",
        // Cerise
        "Premier vrai fruit sucré de l'été, rouge et juteux, poussant massivement en verger",
        // Parc
        "Enclos temporaire dans lequel le berger parque le troupeau la nuit pour concentrer le fumier",
        // Menthe
        "Plante très rafraîchissante poussant dans les lieux frais, utilisée en sirop et tisane",
        // Cumin
        "Graine aromatique puissante utilisée pour épicer divers mets et fromages ruraux",
        // Haricot
        "Légumineuse de fin d'été, essentielle aux réserves d'hiver après séchage de ses grains",
        // Orcanète
        "Plante cousine de la bourache dont la racine donne une magnifique teinture rouge",
        // Pintade
        "Volaille d'élevage au plumage perlé noir et blanc, réputée pour sa chair rappelant le gibier",
        // Sauge
        "Plante reine de la pharmacopée ancienne (celle qui sauve), très utilisée dans la cuisine méditerranéenne",
        // Ail
        "Bulbe au goût fort, base culinaire antiseptique suspendu en tresses pour l'hiver",
        // Vesce
        "Plante rampante sauvage ou cultivée pour enrichir les sols et fournir d'excellents fourrages",
        // Blé
        "Céréale reine, moissonnée en été, à la base du pain, aliment central des Français",
        // Chalémie
        "Instrument de musique à vent rustique, ancêtre du hautbois, rythmant les fêtes paysannes",
        // Épeautre
        "Ancienne céréale ancêtre du blé rustique, cultivée dans les zones de moyenne montagne",
        // Bouillon blanc
        "Grande plante veloutée sauvage, traditionnellement infusée pour apaiser les toux d'hiver",
        // Melon
        "Fruit d'été sucré et juteux de la famille des courges, apprécié lors des grandes chaleurs",
        // Ivraie
        "Graminée mauvaise herbe qui pousse dans les blés et dont la graine a des effets toxiques",
        // Bélier
        "Le mâle non castré du mouton, chef du troupeau et garant du renouvellement des agneaux",
        // Prêle
        "Plante archaïque sans fleurs des milieux humides, très riche en silice pour récurer les pots",
        // Armoise
        "Plante médicinale au feuillage argenté poussant au bord des chemins, utilisée pour réguler les cycles",
        // Carthame
        "Plante apparentée au chardon dont on tire une huile ou une teinture jaune pour remplacer le safran",
        // Mûre
        "Fruit noir juteux du roncier, ramassé massivement à la fin de l'été dans les haies",
        // Arrosoir
        "Outil manuel fondamental du maraîcher estival pour amener l'eau précisément aux cultures",
        // Panis
        "Sorte de millet ou petite graminée cultivée anciennement pour l'alimentation des volailles",
        // Salicorne
        "Plante croquante des marais salants ramassée en été, souvent conservée dans le vinaigre",
        // Abricot
        "Fruit orange gorgé de soleil, symbole du plein été, consommé frais ou séché",
        // Basilic
        "Herbe intensément parfumée, pilier de la cuisine du sud en pleine période estivale",
        // Brebis
        "Femelle du mouton essentielle pour la laine et pour produire d'excellents fromages de garde",
        // Guimauve
        "Plante médicinale adoucissante dont on utilisait la racine pour soulager les maux de dents",
        // Lin
        "Plante arrachée en été pour récupérer, après rouissage, de solides fibres textiles",
        // Amande
        "Fruit à coque du sud, récoltée à la fin de l'été, riche en huile et prisée en confiserie",
        // Gentiane
        "Grande plante des pâturages de montagne dont la racine donne une célèbre liqueur amère",
        // Écluse
        "Ouvrage contrôlant le niveau de l'eau sur les canaux, vital pour l'irrigation et le transport estival",
        // Carline
        "Chardon sans tige de montagne cloué sur les portes pour prévoir le temps, son cœur est comestible",
        // Câprier
        "Arbuste du sud de la France dont les boutons floraux, les câpres, sont confits au vinaigre",
        // Lentille
        "Légumineuse récoltée en plein été, riche en fer et base de l'alimentation paysanne d'hiver",
        // Aunée
        "Grande plante sauvage vivace dont on utilisait la racine odorante pour les poumons et la digestion",
        // Loutre
        "Mammifère aquatique chassé pour sa fourrure et par les pisciculteurs craignant pour leurs étangs",
        // Myrte
        "Arbuste aromatique du maquis corse et provençal aux baies noires typiques de l'été",
        // Colza
        "Plante aux champs jaunes vif, cultivée pour l'huile extraite de ses graines",
        // Lupin
        "Plante rustique aux épis floraux colorés, dont la graine bouillie a toujours nourri animaux et hommes",
        // Coton
        "Fibre textile douce tirée d'un arbuste cultivé dans les climats chauds (Antilles, etc.)",
        // Moulin
        "Installation à vent ou à eau, centre névralgique du village après les moissons d'été pour obtenir la farine",
        // Prune
        "Fruit d'été à chair douce, séchée au soleil pour se conserver en pruneaux l'hiver",
        // Millet
        "Petite céréale jaune à croissance rapide, beaucoup consommée en bouillie par les paysans pauvres",
        // Lycoperdon
        "Champignon de type 'vesse-de-loup' dont les spores s'envolent comme de la fumée en été",
        // Escourgeon
        "Variété d'orge d'hiver que l'on sème tôt et que l'on récolte très tôt dans l'été",
        // Saumon
        "Gros poisson remontant les fleuves français comme la Loire à la belle saison",
        // Tubéreuse
        "Fleur bulbeuse extraordinairement odorante, cultivée à Grasse pour l'industrie du parfum estival",
        // Sucrion
        "Ancien nom de l'escourgeon d'hiver ou petite orge de brasserie très sucrée",
        // Apocyn
        "Plante rustique à la sève laiteuse, aussi appelée herbe à la ouate en raison de ses graines soyeuses",
        // Réglisse
        "Plante dont la racine sucrée et rafraîchissante est sucée ou infusée par grande chaleur",
        // Échelle
        "Accessoire en bois crucial du mois de Fructidor pour récolter les fruits dans les grands vergers",
        // Pastèque
        "Grand fruit lourd poussant au ras du sol chaud du midi, gorgé d'eau désaltérante",
        // Fenouil
        "Plante anisée dont les bulbes et graines sont au pic de leur saveur en fin d'été",
        // Épine vinette
        "Arbuste défensif très épineux donnant de petites baies rouges acidulées à la fin de l'été",
        // Noix
        "Fruit du noyer récolté en septembre, essentiel pour extraire l'huile d'éclairage et de cuisine",
        // Truite
        "Poisson exigeant des eaux vives et fraîches de rivière, pêché en été à l'ombre des arbres",
        // Citron
        "Agrume acide du Midi qui mûrit en se gorgeant du soleil méditerranéen",
        // Cardère
        "Plante piquante appelée 'cabaret des oiseaux' qui retient l'eau de pluie pour les insectes et oiseaux",
        // Nerprun
        "Arbuste rustique produisant des baies utilisées pour la teinture et aux forts effets purgatifs",
        // Tagette
        "Fleur ornementale orange au parfum pénétrant protégeant le potager d'été des ravageurs",
        // Hotte
        "Panier porté sur le dos par le paysan ou le vigneron pour transporter les récoltes dans les pentes",
        // Églantier
        "Le rosier sauvage des haies paysannes produisant le gratte-cul (cynorrhodon) à l'approche de l'automne",
        // Noisette
        "Petit fruit à coque très nutritif des bois, que l'on ramasse en toute fin d'été",
        // Houblon
        "Plante grimpante vigoureuse dont les cônes, cueillis en septembre, donnent son amertume à la bière",
        // Sorgho
        "Céréale originaire de la chaleur qui résiste à la sécheresse estivale, pour nourrir hommes ou bêtes",
        // Écrevisse
        "Petit crustacé des ruisseaux clairs et lents pêché en eau douce lors des chaleurs",
        // Bigarade
        "Orange amère dont le zeste est indispensable à de nombreuses liqueurs et confitures",
        // Verge d'or
        "Grande plante vivace à l'inflorescence jaune qui colore les bords de rivières en fin d'été",
        // Maïs
        "Grande céréale importée d'Amérique qui domine les champs d'été du sud-ouest pour volailles et polenta",
        // Marron
        "Fruit du châtaignier, aliment incontournable sauvant les ruraux en période de disette",
        // Panier
        "Outil tressé en osier symbolisant la fin du cycle et la cueillette de tous les fruits d'arrière-saison",
        // Vertu
        "Jour de célébration de la probité, du civisme et de l'honnêteté du bon citoyen",
        // Génie
        "Jour en l'honneur de l'intelligence, des sciences et des arts, propulsant le progrès",
        // Travail
        "Fête consacrée à l'industrie, à l'agriculture et au labeur manuel utiles à la nation",
        // Opinion
        "Célébration de la liberté d'expression et d'opinion, pilier de la démocratie républicaine",
        // Récompenses
        "Hommage rendu par la patrie aux citoyens ayant réalisé une action méritoire",
        // Révolution
        "Fête ultime célébrée les années sextiles en l'honneur du renversement de la monarchie"
    ]
    
    internal static let allDayGrammaticalNature: [DayNameNature] = [
        // Raisin
        .nm,
        // Safran
        .nm,
        // Châtaigne
        .nf,
        // Colchique
        .nm,
        // Cheval
        .nm,
        // Balsamine
        .nf,
        // Carotte
        .nf,
        // Amaranthe
        .nf,
        // Panais
        .nm,
        // Cuve
        .nf,
        // Pomme de terre
        .nf,
        // Immortelle
        .nf,
        // Potiron
        .nm,
        // Réséda
        .nm,
        // Ane
        .nm,
        // Belle de nuit
        .nf,
        // Citrouille
        .nf,
        // Sarrasin
        .nm,
        // Tournesol
        .nm,
        // Pressoir
        .nm,
        // Chanvre
        .nm,
        // Pêche
        .nf,
        // Navet
        .nm,
        // Amaryllis
        .nf,
        // Bœuf
        .nm,
        // Aubergine
        .nf,
        // Piment
        .nm,
        // Tomate
        .nf,
        // Orge
        .nf,
        // Tonneau
        .nm,
        // Pomme
        .nf,
        // Céleri
        .nm,
        // Poire
        .nf,
        // Betterave
        .nf,
        // Oie
        .nf,
        // Héliotrope
        .nm,
        // Figue
        .nf,
        // Scorsonère
        .nf,
        // Alisier
        .nm,
        // Charrue
        .nf,
        // Salsifis
        .nm,
        // Macre
        .nf,
        // Topinambour
        .nm,
        // Endive
        .nf,
        // Dindon
        .nm,
        // Chervis
        .nm,
        // Cresson
        .nm,
        // Dentelaire
        .nf,
        // Grenade
        .nf,
        // Herse
        .nf,
        // Bacchante
        .nf,
        // Azerole
        .nf,
        // Garance
        .nf,
        // Orange
        .nf,
        // Faisan
        .nm,
        // Pistache
        .nf,
        // Macjonc
        .nm,
        // Coing
        .nm,
        // Cormier
        .nm,
        // Rouleau
        .nm,
        // Raiponce
        .nf,
        // Turneps
        .nm,
        // Chicorée
        .nf,
        // Nèfle
        .nf,
        // Cochon
        .nm,
        // Mâche
        .nf,
        // Chou-fleur
        .nm,
        // Miel
        .nm,
        // Genièvre
        .nm,
        // Pioche
        .nf,
        // Cire
        .nf,
        // Raifort
        .nm,
        // Cèdre
        .nm,
        // Sapin
        .nm,
        // Chevreuil
        .nm,
        // Ajonc
        .nm,
        // Cyprès
        .nm,
        // Lierre
        .nm,
        // Sabine
        .nf,
        // Hoyau
        .nm,
        // Erable sucré
        .nm,
        // Bruyère
        .nf,
        // Roseau
        .nm,
        // Oseille
        .nf,
        // Grillon
        .nm,
        // Pignon
        .nm,
        // Liège
        .nm,
        // Truffe
        .nf,
        // Olive
        .nf,
        // Pelle
        .nf,
        // Tourbe
        .nf,
        // Houille
        .nf,
        // Bitume
        .nm,
        // Soufre
        .nm,
        // Chien
        .nm,
        // Lave
        .nf,
        // Terre végétale
        .nf,
        // Fumier
        .nm,
        // Salpêtre
        .nm,
        // Fléau
        .nm,
        // Granit
        .nm,
        // Argile
        .nf,
        // Ardoise
        .nf,
        // Grès
        .nm,
        // Lapin
        .nm,
        // Silex
        .nm,
        // Marne
        .nf,
        // Pierre à chaux
        .nf,
        // Marbre
        .nm,
        // Van
        .nm,
        // Pierre à Plâtre
        .nf,
        // Sel
        .nm,
        // Fer
        .nm,
        // Cuivre
        .nm,
        // Chat
        .nm,
        // Étain
        .nm,
        // Plomb
        .nm,
        // Zinc
        .nm,
        // Mercure
        .nm,
        // Crible
        .nm,
        // Lauréole
        .nf,
        // Mousse
        .nf,
        // Fragon
        .nm,
        // Perce Neige
        .nm,
        // Taureau
        .nm,
        // Laurier thym
        .nm,
        // Amadouvier
        .nm,
        // Mézéréon
        .nm,
        // Peuplier
        .nm,
        // Cognée
        .nf,
        // Ellébore
        .nm,
        // Brocoli
        .nm,
        // Laurier
        .nm,
        // Avelinier
        .nm,
        // Vache
        .nf,
        // Buis
        .nm,
        // Lichen
        .nm,
        // If
        .nm,
        // Pulmonaire
        .nf,
        // Serpette
        .nf,
        // Thlaspi
        .nm,
        // Thimèle
        .nf,
        // Chiendent
        .nm,
        // Trainasse
        .nf,
        // Lièvre
        .nm,
        // Guède
        .nf,
        // Noisetier
        .nm,
        // Cyclamen
        .nm,
        // Chélidoine
        .nf,
        // Traineau
        .nm,
        // Tussilage
        .nm,
        // Cornouiller
        .nm,
        // Violier
        .nm,
        // Troëne
        .nm,
        // Bouc
        .nm,
        // Asaret
        .nm,
        // Alaterne
        .nm,
        // Violette
        .nf,
        // Marceau
        .nm,
        // Bêche
        .nf,
        // Narcisse
        .nm,
        // Orme
        .nm,
        // Fumeterre
        .nf,
        // Vélar
        .nm,
        // Chèvre
        .nf,
        // Épinard
        .nm,
        // Doronic
        .nm,
        // Mouron
        .nm,
        // Cerfeuil
        .nm,
        // Cordeau
        .nm,
        // Mandragore
        .nf,
        // Persil
        .nm,
        // Cochléaire
        .nf,
        // Pâquerette
        .nf,
        // Thon
        .nm,
        // Pissenlit
        .nm,
        // Sylve
        .nf,
        // Capillaire
        .nf,
        // Frêne
        .nm,
        // Plantoir
        .nm,
        // Primevère
        .nf,
        // Platane
        .nm,
        // Asperge
        .nf,
        // Tulipe
        .nf,
        // Poule
        .nf,
        // Blette
        .nf,
        // Bouleau
        .nm,
        // Jonquille
        .nf,
        // Aulne
        .nm,
        // Couvoir
        .nm,
        // Pervenche
        .nf,
        // Charme
        .nm,
        // Morille
        .nf,
        // Hêtre
        .nm,
        // Abeille
        .nf,
        // Laitue
        .nf,
        // Mélèze
        .nm,
        // Cigüe
        .nf,
        // Radis
        .nm,
        // Ruche
        .nf,
        // Gainier
        .nm,
        // Romaine
        .nf,
        // Marronnier
        .nm,
        // Roquette
        .nf,
        // Pigeon
        .nm,
        // Lilas
        .nm,
        // Anémone
        .nf,
        // Pensée
        .nf,
        // Myrtille
        .nf,
        // Greffoir
        .nm,
        // Rose
        .nf,
        // Chêne
        .nm,
        // Fougère
        .nf,
        // Aubépine
        .nf,
        // Rossignol
        .nm,
        // Ancolie
        .nf,
        // Muguet
        .nm,
        // Champignon
        .nm,
        // Hyacinthe
        .nf,
        // Râteau
        .nm,
        // Rhubarbe
        .nf,
        // Sainfoin
        .nm,
        // Bâton d'or
        .nm,
        // Chamerops
        .nm,
        // Ver à soie
        .nm,
        // Consoude
        .nf,
        // Pimprenelle
        .nf,
        // Corbeille d'or
        .nf,
        // Arroche
        .nf,
        // Sarcloir
        .nm,
        // Statice
        .nm,
        // Fritillaire
        .nf,
        // Bourache
        .nf,
        // Valériane
        .nf,
        // Carpe
        .nf,
        // Fusain
        .nm,
        // Civette
        .nf,
        // Buglosse
        .nf,
        // Sénevé
        .nm,
        // Houlette
        .nf,
        // Luzerne
        .nf,
        // Hémérocalle
        .nf,
        // Trèfle
        .nm,
        // Angélique
        .nf,
        // Canard
        .nm,
        // Mélisse
        .nf,
        // Fromental
        .nm,
        // Martagon
        .nm,
        // Serpolet
        .nm,
        // Faux
        .nf,
        // Fraise
        .nf,
        // Bétoine
        .nf,
        // Pois
        .nm,
        // Acacia
        .nm,
        // Caille
        .nf,
        // Œillet
        .nm,
        // Sureau
        .nm,
        // Pavot
        .nm,
        // Tilleul
        .nm,
        // Fourche
        .nf,
        // Barbeau
        .nm,
        // Camomille
        .nf,
        // Chèvre-feuille
        .nm,
        // Caille-lait
        .nm,
        // Tanche
        .nf,
        // Jasmin
        .nm,
        // Verveine
        .nf,
        // Thym
        .nm,
        // Pivoine
        .nf,
        // Chariot
        .nm,
        // Seigle
        .nm,
        // Avoine
        .nf,
        // Oignon
        .nm,
        // Véronique
        .nf,
        // Mulet
        .nm,
        // Romarin
        .nm,
        // Concombre
        .nm,
        // Échalotte
        .nf,
        // Absinthe
        .nf,
        // Faucille
        .nf,
        // Coriandre
        .nf,
        // Artichaut
        .nm,
        // Girofle
        .nm,
        // Lavande
        .nf,
        // Chamois
        .nm,
        // Tabac
        .nm,
        // Groseille
        .nf,
        // Gesse
        .nf,
        // Cerise
        .nf,
        // Parc
        .nm,
        // Menthe
        .nf,
        // Cumin
        .nm,
        // Haricot
        .nm,
        // Orcanète
        .nf,
        // Pintade
        .nf,
        // Sauge
        .nf,
        // Ail
        .nm,
        // Vesce
        .nf,
        // Blé
        .nm,
        // Chalémie
        .nf,
        // Épeautre
        .nm,
        // Bouillon blanc
        .nm,
        // Melon
        .nm,
        // Ivraie
        .nf,
        // Bélier
        .nm,
        // Prêle
        .nf,
        // Armoise
        .nf,
        // Carthame
        .nm,
        // Mûre
        .nf,
        // Arrosoir
        .nm,
        // Panis
        .nm,
        // Salicorne
        .nf,
        // Abricot
        .nm,
        // Basilic
        .nm,
        // Brebis
        .nf,
        // Guimauve
        .nf,
        // Lin
        .nm,
        // Amande
        .nf,
        // Gentiane
        .nf,
        // Écluse
        .nf,
        // Carline
        .nf,
        // Câprier
        .nm,
        // Lentille
        .nf,
        // Aunée
        .nf,
        // Loutre
        .nf,
        // Myrte
        .nm,
        // Colza
        .nm,
        // Lupin
        .nm,
        // Coton
        .nm,
        // Moulin
        .nm,
        // Prune
        .nf,
        // Millet
        .nm,
        // Lycoperdon
        .nm,
        // Escourgeon
        .nm,
        // Saumon
        .nm,
        // Tubéreuse
        .nf,
        // Sucrion
        .nm,
        // Apocyn
        .nm,
        // Réglisse
        .nf,
        // Échelle
        .nf,
        // Pastèque
        .nf,
        // Fenouil
        .nm,
        // Épine vinette
        .nf,
        // Noix
        .nf,
        // Truite
        .nf,
        // Citron
        .nm,
        // Cardère
        .nf,
        // Nerprun
        .nm,
        // Tagette
        .nf,
        // Hotte
        .nf,
        // Églantier
        .nm,
        // Noisette
        .nf,
        // Houblon
        .nm,
        // Sorgho
        .nm,
        // Écrevisse
        .nf,
        // Bigarade
        .nf,
        // Verge d'or
        .nf,
        // Maïs
        .nm,
        // Marron
        .nm,
        // Panier
        .nm,
        // Vertu
        .nf,
        // Génie
        .nm,
        // Travail
        .nm,
        // Opinion
        .nf,
        // Récompenses
        .nfpl,
        // Révolution
        .nf
    ]

    /// Returns string as EEEE d MMMM "An" yyyy
    public func toVeryLongString() -> String {
        FRCFormat.veryLong.format(self)
    }
    
    /// Returns string as d MMMM "An" yyyy
    public func toLongString() -> String {
        FRCFormat.long.format(self)
    }
    
    /// Returns string as d MMMM
    public func toLongStringNoYear() -> String {
        FRCFormat.dayMonth.format(self)
    }
    
    /// Returns string as d MMM
    public func toShortString() -> String {
        FRCFormat.short.format(self)
    }
    
    /// Returns string as dd/MM/yyy
    public func toShortenedString() -> String {
        return "\(components.day! >= 10 ? "" : "0")\(components.day!)/\(components.month! >= 10 ? "" : "0")\(components.month!)/\(formattedYear)"
    }
    
    /// Localized month name
    public var monthName: String {
        FrenchRepublicanDate.allMonthNames[components.month! - 1]
    }
    
    /// Localized shortened month name
    public var shortMonthName: String {
        FrenchRepublicanDate.shortMonthNames[components.month! - 1]
    }
    
    /// the day of the week's name
    public var weekdayName: String {
        FrenchRepublicanDate.allWeekdays[components.weekday! - 1]
    }
    
    /// the name given to the day
    public var dayName: String {
        FrenchRepublicanDate.allDayNames[dayInYear - 1]
    }
    
    /// the explanation for the day name
    public var dayNameExplanation: String {
        FrenchRepublicanDate.allDayExplanations[dayInYear - 1]
    }
    
    public var dayNameGrammaticalNature: DayNameNature {
        FrenchRepublicanDate.allDayGrammaticalNature[dayInYear - 1]
    }
    
    /// the name of the quarter, or season
    public var quarter: String {
        FrenchRepublicanDate.allQuarters[components.quarter! - 1]
    }
    
    public var sansculottideDayName: String {
        assert(isSansculottides)
        return FrenchRepublicanDate.sansculottidesDayNames[components.day! - 1]
    }
    
    public var shortSansculottideDayName: String {
        assert(isSansculottides)
        return FrenchRepublicanDate.sansculottidesShortNames[components.day! - 1]
    }
    
    /// the year, formatted according to this converter's options (roman numerals, or simply an interpolated Int)
    public var formattedYear: String {
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
    public var debugDescription: String {
        return "\(toVeryLongString()), quarter \(components.quarter!), decade \(components.weekOfMonth!) of month, decade \(components.weekOfYear!) of year, day \(dayInYear) of year"
    }
    
    /// Returns the wiktionary or wikipedia page link associated with the day name.
    public var descriptionURL: URL? {
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
    
    public enum DayNameNature: Sendable, Hashable {
        case nm   // Nom masculin
        case nf   // Nom féminin
        case nmpl // Nom masculin pluriel (unused)
        case nfpl // Nom féminin pluriel
    }
}
