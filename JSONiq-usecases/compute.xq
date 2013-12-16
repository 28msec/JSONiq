xquery version "3.0";
import module namespace file = "http://expath.org/ns/file";
import module namespace reflection = "http://www.zorba-xquery.com/modules/reflection";
import module namespace ddl = "http://www.zorba-xquery.com/modules/store/dynamic/collections/ddl";
import module namespace dml = "http://www.zorba-xquery.com/modules/store/dynamic/collections/dml";

declare namespace err = "http://www.w3.org/2005/xqt-errors";
declare namespace output = "http://www.w3.org/2010/xslt-xquery-serialization";

ddl:create(xs:QName("users"),({
  "name" : "Sarah",
  "age" : 13,
  "gender" : "female",
  "friends" : [ "Jim", "Mary", "Jennifer"]
}
,
{
  "name" : "Jim",
  "age" : 13,
  "gender" : "male",
  "friends" : [ "Sarah" ]
}));

ddl:create(xs:QName("sales"),(
{ "product" : "broiler", "store number" : 1, "quantity" : 20  },
{ "product" : "toaster", "store number" : 2, "quantity" : 100 },
{ "product" : "toaster", "store number" : 2, "quantity" : 50 },
{ "product" : "toaster", "store number" : 3, "quantity" : 50 },
{ "product" : "blender", "store number" : 3, "quantity" : 100 },
{ "product" : "blender", "store number" : 3, "quantity" : 150 },
{ "product" : "socks", "store number" : 1, "quantity" : 500 },
{ "product" : "socks", "store number" : 2, "quantity" : 10 },
{ "product" : "shirt", "store number" : 3, "quantity" : 10 }
));

ddl:create(xs:QName("products"), (
{ "name" : "broiler", "category" : "kitchen", "price" : 100, "cost" : 70 },
{ "name" : "toaster", "category" : "kitchen", "price" : 30, "cost" : 10 },
{ "name" : "blender", "category" : "kitchen", "price" : 50, "cost" : 25 },
{ "name" : "socks", "category" : "clothes", "price" : 5, "cost" : 2 },
{ "name" : "shirt", "category" : "clothes", "price" : 10, "cost" : 3 }
));

ddl:create(xs:QName("stores"), (
{ "store number" : 1, "state" : "CA" },
{ "store number" : 2, "state" : "CA" },
{ "store number" : 3, "state" : "MA" },
{ "store number" : 4, "state" : "MA" }
));

ddl:create(xs:QName("satellites"),
{
  "creator" : "Satellites plugin version 0.6.4",
  "satellites" : {
    "AAU CUBESAT" : {
      "tle1" : "1 27846U 03031G 10322.04074654  .00000056  00000-0  45693-4 0  8768",
      "visible" : false()
    },
    "AJISAI (EGS)" : {
      "tle1" : "1 16908U 86061A 10321.84797408 -.00000083  00000-0  10000-3 0  3696",
      "visible" : true()
    },
    "AKARI (ASTRO-F)" : {
      "tle1" : "1 28939U 06005A 10321.96319841  .00000176  00000-0  48808-4 0  4294",
      "visible" : true()
    }
  }
}
);

ddl:create(xs:QName("youtube"), (
{
    "encoding" : "UTF-8",
    "feed" : {
        "author" : [
            {
                "name" : {
                    "$t" : "YouTube"
                },
                "uri" : {
                    "$t" : "http://www.youtube.com/"
                }
            }
        ],
        "category" : [
            {
                "scheme" : "http://schemas.google.com/g/2005#kind",
                "term" : "http://gdata.youtube.com/schemas/2007#video"
            }
        ],
        "entry" : [
            {
                "app$control" : {
                    "yt$state" : {
                        "$t" : "Syndication of this video was restricted by its owner.",
                        "name" : "restricted",
                        "reasonCode" : "limitedSyndication"
                    }
                },
                "author" : [
                    {
                        "name" : {
                            "$t" : "beyonceVEVO"
                        },
                        "uri" : {
                            "$t" : "http://gdata.youtube.com/feeds/api/users/beyoncevevo"
                        }
                    }
                ]
            }
        ]
    }
}
));

for $f in file:list("en-US.raw")
where contains($f, ".xml")
let $text := file:read-text("en-US.raw/" || $f)
let $xml := parse-xml($text)
let $output := copy $input := $xml
               modify for $example in $input//example
                      where $example/title ne "A library module"
                      let $query := replace(string-join($example/programlisting), "collection\(&quot;([a-z\-]*)&quot;\)", "dml:collection(xs:QName(&quot;$1&quot;))")
                      let $query := replace($query, 'import module namespace other= "http://www.example.com/my-module";', 'import module namespace other= "http://www.example.com/my-module" at "library-module.xquery";')
                      return insert nodes <formalpara><title>Result:</title>
                                           <para>{try { reflection:eval("jsoniq version &quot;3.0&quot;; " ||
                                                                                 'import module namespace dml = "http://www.zorba-xquery.com/modules/store/dynamic/collections/dml";' ||
                                                                                 $query) ! serialize(.) } catch * { $err:description } }</para>
                                           </formalpara> as last into $example
               return $input
let $text := serialize($output, <output:serialization-parameters/>)
let $text := replace($text, '([a-z\-]*)#([0-9])', '<ulink url="http://www.zorba-xquery.com/html/modules/w3c/xpath#$1-$2">$1#$2</ulink>')
return file:write("en-US/" || $f, $text, <output:serialization-parameters><output:method value="text"/></output:serialization-parameters>)

