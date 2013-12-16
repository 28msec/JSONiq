jsoniq version "3.0";
module namespace my = "http://www.example.com/my-module";
declare variable $my:variable := { "foo" : "bar" };
declare variable $my:n := 42;
declare function my:function($i as integer) { $i * $i };
