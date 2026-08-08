

# public_suffix.cr - Implementación en Crystal de la comprobación del sufijo público

[![Version](https://img.shields.io/github/tag/anamba/public_suffix.cr.svg?maxAge=360)](https://github.com/anamba/public_suffix.cr/releases/latest)
[![Build Status](https://travis-ci.org/anamba/public_suffix.cr.svg?branch=master)](https://travis-ci.org/anamba/public_suffix.cr)
[![License](https://img.shields.io/github/license/anamba/public_suffix.cr.svg)](https://github.com/anamba/public_suffix.cr/blob/master/LICENSE)

[Comprobación del sufijo público](https://publicsuffix.org/list/) implementada en [Crystal](https://crystal-lang.org).

La API, el README y las especificaciones están inspiradas en [publicsuffix-ruby](https://github.com/weppos/publicsuffix-ruby), pero el código en sí es completamente nuevo, y la gema y el shard no están relacionados de ninguna otra manera.

Tenga en cuenta que el archivo de datos de sufijos públicos se incrusta en tiempo de compilación y se analiza en una constante al iniciar. Esto aumentará el tamaño en disco, el tiempo de arranque y el uso de memoria base del binario final en consecuencia (aproximadamente 200 KB, 20 ms y ? MB respectivamente).

## Versionado

El nivel de parche indica la fecha en que la lista se actualizó por última vez.

## Instalación

1.  Agregue la dependencia a su `shard.yml`:
```yaml
dependencies:
  public_suffix:
    github: anamba/public_suffix.cr
```
2.  Ejecute `shards install`

## Uso

```crystal
require "public_suffix"
```

Extraer el dominio de un nombre:

```crystal

PublicSuffix.domain("google.com")
# => "google.com"
PublicSuffix.domain("www.google.com")
# => "google.com"
PublicSuffix.domain("www.google.co.uk")
# => "google.co.uk"
```

## ¿Qué es la Lista de Sufijos Públicos?

La [Lista de Sufijos Públicos](https://publicsuffix.org) es una iniciativa interproveedores para proporcionar una lista precisa de sufijos de nombres de dominio.

La Lista de Sufijos Públicos es una iniciativa del Proyecto Mozilla, pero se mantiene como un recurso comunitario. Está disponible para su uso en cualquier software, pero fue creada originalmente para satisfacer las necesidades de los fabricantes de navegadores.

Un "sufijo público" es uno bajo el cual los usuarios de Internet pueden registrar nombres directamente. Algunos ejemplos de sufijos públicos son ".com", ".co.uk" y "pvt.k12.wy.us". La Lista de Sufijos Públicos es un listado de todos los sufijos públicos conocidos.

## Por qué la Lista de Sufijos Públicos es mejor que cualquier analizador de Expresiones Regulares disponible

Anteriormente, los navegadores utilizaban un algoritmo que básicamente solo negaba la configuración de cookies de amplio alcance para dominios de nivel superior sin puntos (por ejemplo, com u org). Sin embargo, esto no funcionaba para dominios de nivel superior donde solo se permiten registros de tercer nivel (por ejemplo, co.uk). En estos casos, los sitios web podían establecer una cookie para co.uk que se transmitiría a cada sitio web registrado bajo co.uk.

Claramente, esto constituía un riesgo de seguridad, ya que permitía que sitios web distintos al que configuraba la cookie la leyeran, y por lo tanto, potencialmente extraer información sensible.

Dado que no existe un método algorítmico para encontrar el nivel más alto en el que se puede registrar un dominio para un dominio de nivel superior específico (las políticas difieren con cada registro), el único método es crear una lista de todos los dominios de nivel superior y el nivel en el que se pueden registrar los dominios. Este es el objetivo de la lista de TLD efectivos.

Además de utilizarse para evitar que se configuren cookies donde no deberían, la lista también puede utilizarse potencialmente para otras aplicaciones donde se necesita conocer las partes del nombre de dominio controladas por el registro y las controladas de forma privada, por ejemplo, al agrupar por dominios de nivel superior.

Fuente: <https://wiki.mozilla.org/Public_Suffix_List>

¿Aún no está convencido? Consulte [este ejemplo del mundo real](https://stackoverflow.com/q/288810/123527).

## ¿<tt>public_suffix.cr</tt> realiza solicitudes al sitio web de la Lista de Sufijos Públicos?

No. <tt>public_suffix.cr</tt> viene con una lista incluida. No realiza ninguna solicitud HTTP para analizar o validar un dominio.

## Contribuir

1.  Realiza un fork (<https://github.com/anamba/public_suffix.cr/fork>)
2.  Crea tu rama de características (`git checkout -b my-new-feature`)
3.  Confirma tus cambios (`git commit -am 'Add some feature'`)
4.  Sube a la rama (`git push origin my-new-feature`)
5.  Crea una nueva Pull Request

## Contribuyentes

-   [Aaron Namba](https://github.com/anamba) - creador y mantenedor
-   [Lucjan Suski](https://github.com/methyl)
