#  French Republican Calendar Core

[Version Française](LISEZMOI.md)  
For the app: [iOS app source code](https://github.com/Snowy1803/FrenchRepublicanCalendar)

Swift Converter between the Gregorian Calendar and the French Republican Calendar. Fully tested and compliant with the original version.

Targets:
 - iOS / watchOS app: [view repo](https://github.com/Snowy1803/FrenchRepublicanCalendar)
 - WebAssembly web app: [view repo](https://github.com/Snowy1803/FrenchRepublicanCalendarWeb)
 - Tests so you can see for yourself that only my implementation is correct 😤

Often, online converters are wrong : They either forget that 1800 and 1900 were sextils but not leap years, either forget 2000 was a leap year.  
You can often see that by yourself by converting around March 1st of those years... My implementation is fully tested and doesn't have those issues.

All returned values are correct, until around the years 15.300 (in Gregorian), where the Republican to Gregorian conversion fails, because at that point, the first day of the Republican year and the first day of the Gregorian year happen at the same time.

The Romme variant works for even more dates, and can be enabled or disabled by the library users easily for all created dates, by making an extension on `FrenchRepublicanCalendarOptions` to conform to `SaveableFrenchRepublicanDateOptions` and providing an implementation for `current`.
