# French Republican Calendar Core

[English version](README.md)  
Pour l'application : [Code source de l'app iOS](https://github.com/Snowy1803/FrenchRepublicanCalendar)

Convertisseur Swift entre le Calendrier Grégorien et le Calendrier Républicain. Complètement testé et conforme à la version originale.

Destinations :
 - Apps iOS / watchOS: [voir le code source](https://github.com/Snowy1803/FrenchRepublicanCalendar)
 - Application web (WebAssembly): à venir
 - Tests pour que vous pouvez voir par vous même que mon implémentation est correcte 😤

Souvent, les convertisseurs en ligne renvoient des valeurs fausses : Soit ils oublient que 1800 et 1900 étaient sextiles mais non bissextiles, soit ils oublient que 2000 était lui bissextile. Vous pouvez souvent constater cela en convertissant aux environs du premier mars de ces années... Mon implémentation est complèrement testée et n'a pas ces problèmes.

Toutes les valeurs retournées sont correctes, jusqu'aux années 15 300 (grégoriennes), où la conversion Républicain vers Grégorien devient fausse, car c'est le moment où le 1er Vendémiaire et le 1er Janvier coincident.
