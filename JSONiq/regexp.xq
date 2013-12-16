let $query := "collection(&quot;name&quot;)"
return replace($query, "collection\(&quot;([a-z]*)&quot;\)", "dml:collection(xs:QName(&quot;$1&quot;))")
