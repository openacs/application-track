<?xml version="1.0"?>

<queryset>
    <rdbms><type>postgresql</type><version>7.1</version></rdbms>
   
    <fullquery name="select_all_classes">
        <querytext>
            select dotlrn_communities_full.*, v.n_members
            from dotlrn_communities_full left outer join
                 (select dotlrn_communities_full.community_id, count(1) as n_members
                 from dotlrn_communities_full, dotlrn_member_rels_approved
                 where dotlrn_member_rels_approved.community_id = dotlrn_communities_full.community_id
                 group by dotlrn_communities_full.community_id) v
                 on dotlrn_communities_full.community_id = v.community_id
	    $keyword_clause
	    [template::list::page_where_clause -and -name "classes" -key "dotlrn_communities_full.community_id"]
	    [template::list::orderby_clause -orderby -name "classes"]
        </querytext>
    </fullquery>

    <fullquery name="select_all_classes_paginator">
        <querytext>
            select dotlrn_communities_full.*, v.n_members
            from dotlrn_communities_full left outer join
                 (select dotlrn_communities_full.community_id, count(1) as n_members
                 from dotlrn_communities_full, dotlrn_member_rels_approved
                 where dotlrn_member_rels_approved.community_id = dotlrn_communities_full.community_id
                 group by dotlrn_communities_full.community_id) v
                 on dotlrn_communities_full.community_id = v.community_id
       	    $keyword_clause
            [template::list::orderby_clause -orderby -name "classes"]
        </querytext>
    </fullquery>


     <partialquery name="select_all_instances_keyword">
      <querytext>
	  where lower(dotlrn_communities_full.pretty_name) like '%'||lower(:keyword)||'%'
      </querytext>
    </partialquery>

    <partialquery name="select_all_instances_without_keyword">
      <querytext>
	  where 1 = 1
      </querytext>
    </partialquery>
    
    

</queryset>
