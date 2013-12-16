xquery version "3.0";
import module namespace file = "http://expath.org/ns/file";
import module namespace reflection = "http://www.zorba-xquery.com/modules/reflection";
import module namespace ddl = "http://www.zorba-xquery.com/modules/store/dynamic/collections/ddl";
import module namespace dml = "http://www.zorba-xquery.com/modules/store/dynamic/collections/dml";

declare namespace err = "http://www.w3.org/2005/xqt-errors";
declare namespace output = "http://www.w3.org/2010/xslt-xquery-serialization";

ddl:create(xs:QName("one-object"), { "foo" : "bar" });
ddl:create(xs:QName("captains"), (
{ "name" : "James T. Kirk", "series" : [ "The original series" ], "century" : 23 },
      { "name" : "Jean-Luc Picard", "series" : [ "The next generation" ], "century" : 24 },
      { "name" : "Benjamin Sisko", "series" : [ "The next generation", "Deep Space 9" ], "century" : 24 },
      { "name" : "Kathryn Janeway", "series" : [ "The next generation", "Voyager" ], "century" : 24  },
      { "name" : "Jonathan Archer", "series" : [ "Entreprise" ], "century" : 22 },
      { "codename" : "Emergency Command Hologram", "surname" : "The Doctor", "series" : [ "Voyager" ], "century" : 24 },
      { "name" : "Samantha Carter", "series" : [ ], "century" : 21 }
));
ddl:create(xs:QName("movies"),(
{ "id" : "I", "name" : "The Motion Picture", "captain" : "James T. Kirk" },
        { "id" : "II", "name" : "The Wrath of Kahn", "captain" : "James T. Kirk" },
        { "id" : "III", "name" : "The Search for Spock", "captain" : "James T. Kirk" },
        { "id" : "IV", "name" : "The Voyage Home", "captain" : "James T. Kirk" },
        { "id" : "V", "name" : "The Final Frontier", "captain" : "James T. Kirk" },
        { "id" : "VI", "name" : "The Undiscovered Country", "captain" : "James T. Kirk" },
        { "id" : "VII", "name" : "Generations", "captain" : [ "James T. Kirk", "Jean-Luc Picard" ] },
        { "id" : "VIII", "name" : "First Contact", "captain" : "Jean-Luc Picard" },
        { "id" : "IX", "name" : "Insurrection", "captain" : "Jean-Luc Picard" },
        { "id" : "X", "name" : "Nemesis", "captain" : "Jean-Luc Picard" },
        { "id" : "XI", "name" : "Star Trek", "captain" : "Spock" },
        { "id" : "XII", "name" : "Star Trek Into Darkness", "captain" : "Spock" })
);

for $f in file:list("en-US.raw")
where contains($f, ".xml")
let $text := file:read-text("en-US.raw/" || $f)
let $xml := parse-xml($text)
let $output := copy $input := $xml
               modify for $example in $input//example
                      where $example/title ne "A library module"
                      let $query := replace(string-join($example/programlisting), "collection\(&quot;([a-z\-]*)&quot;\)", "dml:collection(xs:QName(&quot;$1&quot;))")
                      let $query := replace($query, 'import module namespace other= "http://www.example.com/my-module";', 'import module namespace other= "http://www.example.com/my-module" at "library-module.xquery";')
                      return insert nodes <formalpara><title>Result (run with Zorba):</title>
                                           <para>{try { reflection:eval("jsoniq version &quot;3.0&quot;; " ||
                                                                                 'import module namespace dml = "http://www.zorba-xquery.com/modules/store/dynamic/collections/dml";' ||
                                                                                 $query) ! serialize(.) } catch * { "An error was raised: " || $err:description } }</para>
                                           </formalpara> as last into $example
               return $input
let $text := serialize($output, <output:serialization-parameters/>)
let $text := replace($text, '([a-zA-Z0-9-]*)#([0-9])', '<ulink url="http://www.zorba-xquery.com/html/modules/w3c/xpath#$1-$2">$1#$2</ulink>')
return file:write("en-US/" || $f, $text, <output:serialization-parameters><output:method value="text"/></output:serialization-parameters>)
,
dml:collection(xs:QName("one-object"))