# Smart Gas
Smart Gas is an iOS application which allows any vehicle driver to find the best Portuguese gas station through applying search filters (e.g. order stations by distance).

The application needs to be "feeded" with data and DGEG – Direção-Geral de Energia e Geologia – is an entity that maintains a [website](http://www.precoscombustiveis.dgeg.pt/) dedicated to provide all information about existing stations: fuel prices, localization, available services, etc. Since 2012, DGEG provides a web service to integrate their data with any kind of applications.

The web service mentioned above is based in SOAP (Simple Object Access Protocol) and has a critical design problem – limited-time availability – which is against the principal idea behind web services: facilitate the integration of different systems and applications.

## System Architecture
![System Architecture](system-architecture.png)

### iOS Application


### Intermediate web service

Acts like a middleware application which obtain the data from the source (DGEG's website) anytime it is available, archive it and provide such information to any application without availability restrictions.
