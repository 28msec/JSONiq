let $uid := doc("users.xml")/users/user_tuple[name = "Roger Smith"]/userid
let $topbid := max(doc("bids.xml")/bids/bid_tuple[itemno = 1007]/bid)
let $newbid := $topbid * 1.1
return
  if($newbid <= 240) then block {
    insert nodes
      <bid_tuple>
        <userid>{ data($uid) }</userid>
        <itemno>1002</itemno>
        <bid>{ $newbid }</bid>
        <bid_date>1999-03-03</bid_date>
      </bid_tuple>
    into doc("bids.xml")/bids;
    exit returning <new_bid>{ $newbid }</new_bid>;
  } else block {
    exit returning <top_bid>{ $topbid }</top_bid>;
  }