xquery version "3.0";
import module namespace file = "http://expath.org/ns/file";
import module namespace reflection = "http://www.zorba-xquery.com/modules/reflection";
import module namespace ddl = "http://www.zorba-xquery.com/modules/store/dynamic/collections/ddl";
import module namespace dml = "http://www.zorba-xquery.com/modules/store/dynamic/collections/dml";

declare namespace err = "http://www.w3.org/2005/xqt-errors";
declare namespace output = "http://www.w3.org/2010/xslt-xquery-serialization";

declare function local:trim($s as xs:string) as xs:string
{
  string-join(
    for $token in tokenize($s, "
")
    let $length := fn:string-length($token)
    let $chunk-size := 59
    for $i in 1 to ($length idiv $chunk-size + 1)
    return substring($token, $chunk-size * ($i - 1) + 1, $chunk-size),
    "
"
  )
};

declare function local:serialize-sequence($s as item()*, $offset as xs:integer)
{
string-join(
  for $i in $s
  return (
    for $i in 1 to $offset return " ",
    local:serialize($i, $offset),
    "
"
  )
)
};

declare function local:serialize($i as item(), $offset as xs:integer)
{
string-join(
typeswitch ($i)
  case xs:double | xs:boolean | js:null | xs:decimal | array() return serialize($i)
  case object() return (
    "{
",
    for $k in jn:keys($i)
    count $c
    let $v := $i($k)
    return (
      for $i in 1 to $offset + 2 return " ",
      "&quot;",
      $k,
      "&quot; : ",
      local:serialize($v, $offset + 2),
      (if ($c ne count(jn:keys($i))) then "," else ()),
      "
"
    ),
    for $i in 1 to $offset return " ",
    "}"
  )
  default return ("&quot;", serialize($i), "&quot;")
)
};

ddl:create(xs:QName("one-object"), { "question" : "What NoSQL technology should I use?" });
ddl:create(xs:QName("answers"), ({
  "_id" : "511C7C5D9A277C22D13880C3", 
  "question_id" : 37823, 
  "answer_id" : 37841, 
  "creation_date" : "2008-09-01T12:14:38", 
  "last_activity_date" : "2008-09-01T12:14:38", 
  "score" : 7, 
  "is_accepted" : false, 
  "owner" : {
    "user_id" : 2562, 
    "display_name" : "Ubiguchi", 
    "reputation" : 1871, 
    "user_type" : "registered", 
    "profile_image" : "http://www.gravatar.com/avatar/00b87a917ec763c0c051dc6b8c06f402?d=identicon&amp;r=PG", 
    "link" : "http://stackoverflow.com/users/2562/ubiguchi"
  }
},
{
  "_id" : "511C7C5D9A277C22D13880C4", 
  "question_id" : 37823, 
  "answer_id" : 37844, 
  "creation_date" : "2008-09-01T12:16:40", 
  "last_activity_date" : "2008-09-01T12:16:40", 
  "score" : 4, 
  "is_accepted" : false, 
  "owner" : {
    "user_id" : 2974, 
    "display_name" : "Rob Wells", 
    "reputation" : 17543, 
    "user_type" : "registered", 
    "profile_image" : "http://www.gravatar.com/avatar/8769281d99f8fe9c208fd6a926c383d1?d=identicon&amp;r=PG", 
    "link" : "http://stackoverflow.com/users/2974/rob-wells", 
    "accept_rate" : 94
  }
},
{
  "_id" : "511C7C5F9A277C22D1388211", 
  "question_id" : 4419499, 
  "answer_id" : 4419542, 
  "creation_date" : "2010-12-11T23:24:21", 
  "last_edit_date" : 1292112046, 
  "last_activity_date" : "2010-12-12T00:00:46", 
  "score" : 17, 
  "is_accepted" : false, 
  "owner" : {
    "user_id" : 236047, 
    "display_name" : "Victor Nicollet", 
    "reputation" : 14632, 
    "user_type" : "registered", 
    "profile_image" : "http://www.gravatar.com/avatar/e083220ac33b47364d345eac8f017919?d=identicon&amp;r=PG", 
    "link" : "http://stackoverflow.com/users/236047/victor-nicollet", 
    "accept_rate" : 95
  }
},
{
  "_id" : "511C7C5F9A277C22D1388212", 
  "question_id" : 4419499, 
  "answer_id" : 4419578, 
  "creation_date" : "2010-12-11T23:30:42", 
  "last_activity_date" : "2010-12-11T23:30:42", 
  "score" : 1, 
  "is_accepted" : false, 
  "owner" : {
    "user_id" : 510782, 
    "display_name" : "descent89", 
    "reputation" : 33, 
    "user_type" : "registered", 
    "profile_image" : "http://www.gravatar.com/avatar/d15c0949f7e051e9d86ed4b6f7c162cc?d=identicon&amp;r=PG", 
    "link" : "http://stackoverflow.com/users/510782/descent89"
  }
},
{
  "_id" : "511C7C5F9A277C22D1388222", 
  "question_id" : 4720508, 
  "answer_id" : 4720977, 
  "creation_date" : "2011-01-18T06:04:51", 
  "last_edit_date" : 1295419594, 
  "last_activity_date" : "2011-01-19T06:46:34", 
  "score" : 34, 
  "is_accepted" : true, 
  "owner" : {
    "user_id" : 2938, 
    "display_name" : "JasonSmith", 
    "reputation" : 23146, 
    "user_type" : "registered", 
    "profile_image" : "http://www.gravatar.com/avatar/dc5c27144fe63c00375ee47da00c5621?d=identicon&amp;r=PG", 
    "link" : "http://stackoverflow.com/users/2938/jasonsmith", 
    "accept_rate" : 100
  }
},
{
  "_id" : "511C7C5F9A277C22D1388260", 
  "question_id" : 5453872, 
  "answer_id" : 5454583, 
  "creation_date" : "2011-03-28T04:10:00", 
  "last_activity_date" : "2011-03-28T04:10:00", 
  "score" : 6, 
  "is_accepted" : false, 
  "owner" : {
    "user_id" : 2938, 
    "display_name" : "JasonSmith", 
    "reputation" : 23136, 
    "user_type" : "registered", 
    "profile_image" : "http://www.gravatar.com/avatar/dc5c27144fe63c00375ee47da00c5621?d=identicon&amp;r=PG", 
    "link" : "http://stackoverflow.com/users/2938/jasonsmith", 
    "accept_rate" : 100
  }
},
{
  "_id" : "511C7C5F9A277C22D138826E", 
  "question_id" : 6183352, 
  "answer_id" : 6195094, 
  "creation_date" : "2011-06-01T00:41:50", 
  "last_activity_date" : "2011-06-01T00:41:50", 
  "score" : 0, 
  "is_accepted" : false, 
  "owner" : {
    "user_id" : 2938, 
    "display_name" : "JasonSmith", 
    "reputation" : 23146, 
    "user_type" : "registered", 
    "profile_image" : "http://www.gravatar.com/avatar/dc5c27144fe63c00375ee47da00c5621?d=identicon&amp;r=PG", 
    "link" : "http://stackoverflow.com/users/2938/jasonsmith", 
    "accept_rate" : 100
  }
},
{
  "_id" : "511C7C5F9A277C22D138826F", 
  "question_id" : 6183352, 
  "answer_id" : 6210422, 
  "creation_date" : "2011-06-02T04:36:02", 
  "last_edit_date" : 1336125264, 
  "last_activity_date" : "2012-05-04T09:54:24", 
  "score" : 1, 
  "is_accepted" : false, 
  "owner" : {
    "user_id" : 2938, 
    "display_name" : "JasonSmith", 
    "reputation" : 23146, 
    "user_type" : "registered", 
    "profile_image" : "http://www.gravatar.com/avatar/dc5c27144fe63c00375ee47da00c5621?d=identicon&amp;r=PG", 
    "link" : "http://stackoverflow.com/users/2938/jasonsmith", 
    "accept_rate" : 100
  }
}
));
ddl:create(xs:QName("faqs"),({
  "_id" : "511C7C5C9A277C22D138802D", 
  "question_id" : 4419499, 
  "last_edit_date" : "2012-12-17T00:02:31", 
  "creation_date" : "2010-12-11T23:15:19", 
  "last_activity_date" : "2012-12-17T00:02:31", 
  "score" : 15, 
  "accepted_answer_id" : 4421601, 
  "title" : "MySQL and NoSQL: Help me to choose the right one", 
  "tags" : [ "php", "mysql", "nosql", "cassandra" ], 
  "view_count" : 3972, 
  "owner" : {
    "user_id" : 279538, 
    "display_name" : "cedivad", 
    "reputation" : 430, 
    "user_type" : "registered", 
    "profile_image" : "http://www.gravatar.com/avatar/b77fadd2ba791134ac40a9c184be1eda?d=identicon&amp;r=PG", 
    "link" : "http://stackoverflow.com/users/279538/cedivad", 
    "accept_rate" : 74
  }, 
  "link" : "http://stackoverflow.com/questions/4419499/mysql-and-nosql-help-me-to-choose-the-right-one", 
  "is_answered" : true
},
{
  "_id" : "511C7C5C9A277C22D138802F", 
  "question_id" : 282783, 
  "last_edit_date" : "2012-04-30T22:43:02", 
  "creation_date" : "2008-11-12T02:02:42", 
  "last_activity_date" : "2012-04-30T22:43:02", 
  "score" : 42, 
  "accepted_answer_id" : 282813, 
  "title" : "The Next-gen Databases", 
  "tags" : [ "sql", "database", "nosql", "non-relational-database" ], 
  "view_count" : 5266, 
  "owner" : {
    "user_id" : 3932, 
    "display_name" : "Randin", 
    "reputation" : 585, 
    "user_type" : "registered", 
    "profile_image" : "http://www.gravatar.com/avatar/d9d7ba9c17d671d911a6ca21d95b2f98?d=identicon&amp;r=PG", 
    "link" : "http://stackoverflow.com/users/3932/randin", 
    "accept_rate" : 100
  }, 
  "link" : "http://stackoverflow.com/questions/282783/the-next-gen-databases", 
  "is_answered" : true
},
{
  "_id" : "511C7C5C9A277C22D138808A", 
  "question_id" : 4720508, 
  "creation_date" : "2011-01-18T04:32:30", 
  "last_activity_date" : "2011-01-19T06:46:34", 
  "score" : 13, 
  "accepted_answer_id" : 4720977, 
  "title" : "Redis, CouchDB or Cassandra?", 
  "tags" : [ "nosql", "couchdb", "cassandra", "redis" ], 
  "view_count" : 5620, 
  "owner" : {
    "user_id" : 216728, 
    "display_name" : "nornagon", 
    "reputation" : 3114, 
    "user_type" : "registered", 
    "profile_image" : "http://www.gravatar.com/avatar/13f27199f9bf9c9f1261dc8a49630a6b?d=identicon&amp;r=PG", 
    "link" : "http://stackoverflow.com/users/216728/nornagon", 
    "accept_rate" : 86
  }, 
  "link" : "http://stackoverflow.com/questions/4720508/redis-couchdb-or-cassandra", 
  "is_answered" : true
},
{
  "_id" : "511C7C5C9A277C22D1388034", 
  "question_id" : 5453872, 
  "last_edit_date" : "2011-09-27T18:06:37", 
  "creation_date" : "2011-03-28T01:45:20", 
  "last_activity_date" : "2012-10-29T00:54:08", 
  "score" : 13, 
  "bounty_amount" : 100, 
  "title" : "Full-text search in NoSQL databases", 
  "tags" : [ "database", "full-text-search", "nosql", "couchdb", "riak" ], 
  "view_count" : 7207, 
  "owner" : {
    "user_id" : 82368, 
    "display_name" : "kunj2aan", 
    "reputation" : 4620, 
    "user_type" : "registered", 
    "profile_image" : "http://www.gravatar.com/avatar/954ea2f3eddf44343abc116897ce47c3?d=identicon&amp;r=PG", 
    "link" : "http://stackoverflow.com/users/82368/kunj2aan", 
    "accept_rate" : 72
  }, 
  "link" : "http://stackoverflow.com/questions/5453872/full-text-search-in-nosql-databases", 
  "is_answered" : true
},
{
  "_id" : "511C7C5C9A277C22D1388074", 
  "question_id" : 6183352, 
  "creation_date" : "2011-05-31T05:27:59", 
  "last_activity_date" : "2012-05-04T09:54:24", 
  "score" : 3, 
  "title" : "Find CouchDB docs missing an arbitrary field", 
  "tags" : [ "database", "view", "nosql", "couchdb" ], 
  "view_count" : 251, 
  "owner" : {
    "user_id" : 226013, 
    "display_name" : "thisismyname", 
    "reputation" : 90, 
    "user_type" : "registered", 
    "profile_image" : "http://www.gravatar.com/avatar/97ea445919246b04731c7b07d01f2cfe?d=identicon&amp;r=PG", 
    "link" : "http://stackoverflow.com/users/226013/thisismyname", 
    "accept_rate" : 50
  }, 
  "link" : "http://stackoverflow.com/questions/6183352/find-couchdb-docs-missing-an-arbitrary-field", 
  "is_answered" : true
}
));

for $f in file:list("en-US.raw")
where contains($f, ".xml")
let $text := file:read-text("en-US.raw/" || $f)
let $xml := parse-xml($text)
let $output := copy $input := $xml
               modify for $example in $input//example
                      where $example/title ne "A library module."
                      let $query := replace(string-join($example/programlisting), "collection\(&quot;([a-z\-]*)&quot;\)", "dml:collection(xs:QName(&quot;$1&quot;))")
                      let $query := replace($query, 'import module namespace other =\s*"http://www.example.com/my-module";', 'import module namespace other = "http://www.example.com/my-module" at "library-module.xquery";')
                      let $query := replace($query, "\[\]\[([0-9]*)\]", "($1)")
                      let $query := replace($query, "\]\[\]", "]!members(\$\$)")
                      let $query := replace($query, "\)\[\]", ")!members(\$\$)")
                      let $query := replace($query, "\$a\[\]", "members(\$a)")
                      let $query := replace($query, "\$x\[\]", "members(\$x)")
                      let $query := replace($query, "\$x.tags\[\]", "members(\$x.tags)")
                      let $query := replace($query, "replace\(", "fn:replace(")
                      return insert nodes
                           try {
<para>Results:</para>,
<programlisting>
  {                             string-join(for $result in reflection:eval(
                                 "jsoniq version &quot;3.0&quot;; " ||
                                 'import module namespace dml = "http://www.zorba-xquery.com/modules/store/dynamic/collections/dml";' ||
                                 $query)
                             return local:trim(local:serialize-sequence($result, 0)))
}</programlisting>
                           } catch * { 
<para>Error:</para>,
<programlisting>
 {
                             $err:description!local:trim(.)
}</programlisting>
                           } as last into $example
               return $input
let $text := serialize($output, <output:serialization-parameters/>)
return file:write("en-US/" || $f, $text, <output:serialization-parameters><output:method value="text"/></output:serialization-parameters>)
,
dml:collection(xs:QName("one-object"))