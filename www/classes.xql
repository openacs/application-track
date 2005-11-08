<?xml version="1.0"?>

<queryset>
    <rdbms><type>postgresql</type><version>7.1</version></rdbms>
   
    <fullquery name="terms">
        <querytext>
          SELECT t.term_name,t.term_id
              FROM dotlrn_terms t 
             WHERE t.term_id = t.term_id
        </querytext>
    </fullquery>

    <fullquery name="communities">
        <querytext>
          SELECT c.pretty_name
              FROM dotlrn_communities_all c, dotlrn_terms t 
             WHERE c.active_start_date = t.start_date
             AND c.active_end_date = t.end_date
        </querytext>
    </fullquery>

    <fullquery name="select_classes">
        <querytext>
            select dotlrn_class_instances_full.*, v.n_members
            from dotlrn_class_instances_full left outer join
                 (select dotlrn_class_instances_full.class_instance_id, count(1) as n_members
                 from dotlrn_class_instances_full, dotlrn_member_rels_approved
                 where dotlrn_member_rels_approved.community_id = dotlrn_class_instances_full.class_instance_id
                 group by dotlrn_class_instances_full.class_instance_id) v
                 on dotlrn_class_instances_full.class_instance_id = v.class_instance_id
	    $keyword_clause
            and dotlrn_class_instances_full.term_id = :term_id
	    [template::list::page_where_clause -and -name "classes" -key "dotlrn_class_instances_full.class_instance_id"]
	    [template::list::orderby_clause -orderby -name "classes"]
        </querytext>
    </fullquery>

    <fullquery name="select_classes_paginator">
        <querytext>
            select dotlrn_class_instances_full.*, v.n_members
            from dotlrn_class_instances_full left outer join
                 (select dotlrn_class_instances_full.class_instance_id, count(1) as n_members
                 from dotlrn_class_instances_full, dotlrn_member_rels_approved
                 where dotlrn_member_rels_approved.community_id = dotlrn_class_instances_full.class_instance_id
                 group by dotlrn_class_instances_full.class_instance_id) v
                 on dotlrn_class_instances_full.class_instance_id = v.class_instance_id
	    $keyword_clause
            and dotlrn_class_instances_full.term_id = :term_id
            [template::list::orderby_clause -orderby -name "classes"]
        </querytext>
    </fullquery>

    <fullquery name="select_classes_by_department">
        <querytext>
            select dotlrn_class_instances_full.*, v.n_members
            from dotlrn_class_instances_full left outer join
                 (select dotlrn_class_instances_full.class_instance_id, count(1) as n_members
                 from dotlrn_class_instances_full, dotlrn_member_rels_approved
                 where dotlrn_member_rels_approved.community_id = dotlrn_class_instances_full.class_instance_id
                 group by dotlrn_class_instances_full.class_instance_id) v
                 on dotlrn_class_instances_full.class_instance_id = v.class_instance_id
	    $keyword_clause
            and dotlrn_class_instances_full.term_id = :term_id
            and dotlrn_class_instances_full.department_key = :department_key
	    [template::list::page_where_clause -and -name "classes" -key "dotlrn_class_instances_full.class_instance_id"]
	    [template::list::orderby_clause -orderby -name "classes"]
        </querytext>
    </fullquery>

    <fullquery name="select_classes_paginator_by_department">
        <querytext>
            select dotlrn_class_instances_full.*, v.n_members
            from dotlrn_class_instances_full left outer join
                 (select dotlrn_class_instances_full.class_instance_id, count(1) as n_members
                 from dotlrn_class_instances_full, dotlrn_member_rels_approved
                 where dotlrn_member_rels_approved.community_id = dotlrn_class_instances_full.class_instance_id
                 group by dotlrn_class_instances_full.class_instance_id) v
                 on dotlrn_class_instances_full.class_instance_id = v.class_instance_id
	    $keyword_clause
            and dotlrn_class_instances_full.term_id = :term_id
            and dotlrn_class_instances_full.department_key = :department_key
            [template::list::orderby_clause -orderby -name "classes"]
        </querytext>
    </fullquery>

    <fullquery name="select_all_classes">
        <querytext>
            select dotlrn_class_instances_full.*, v.n_members
            from dotlrn_class_instances_full left outer join
                 (select dotlrn_class_instances_full.class_instance_id, count(1) as n_members
                 from dotlrn_class_instances_full, dotlrn_member_rels_approved
                 where dotlrn_member_rels_approved.community_id = dotlrn_class_instances_full.class_instance_id
                 group by dotlrn_class_instances_full.class_instance_id) v
                 on dotlrn_class_instances_full.class_instance_id = v.class_instance_id
	    $keyword_clause
	    [template::list::page_where_clause -and -name "classes" -key "dotlrn_class_instances_full.class_instance_id"]
	    [template::list::orderby_clause -orderby -name "classes"]
        </querytext>
    </fullquery>

    <fullquery name="select_all_classes_paginator">
        <querytext>
            select dotlrn_class_instances_full.*, v.n_members
            from dotlrn_class_instances_full left outer join
                 (select dotlrn_class_instances_full.class_instance_id, count(1) as n_members
                 from dotlrn_class_instances_full, dotlrn_member_rels_approved
                 where dotlrn_member_rels_approved.community_id = dotlrn_class_instances_full.class_instance_id
                 group by dotlrn_class_instances_full.class_instance_id) v
                 on dotlrn_class_instances_full.class_instance_id = v.class_instance_id
       	    $keyword_clause
            [template::list::orderby_clause -orderby -name "classes"]
        </querytext>
    </fullquery>

    <fullquery name="select_all_classes_by_department">
        <querytext>
            select dotlrn_class_instances_full.*, v.n_members
            from dotlrn_class_instances_full left outer join
                 (select dotlrn_class_instances_full.class_instance_id, count(1) as n_members
                 from dotlrn_class_instances_full, dotlrn_member_rels_approved
                 where dotlrn_member_rels_approved.community_id = dotlrn_class_instances_full.class_instance_id
                 group by dotlrn_class_instances_full.class_instance_id) v
                 on dotlrn_class_instances_full.class_instance_id = v.class_instance_id
	    $keyword_clause
            and dotlrn_class_instances_full.department_key = :department_key
	    [template::list::page_where_clause -and -name "classes" -key "dotlrn_class_instances_full.class_instance_id"]
	    [template::list::orderby_clause -orderby -name "classes"]
        </querytext>
    </fullquery>

    <fullquery name="select_all_classes_paginator_by_department">
        <querytext>
            select dotlrn_class_instances_full.*, v.n_members
            from dotlrn_class_instances_full left outer join
                 (select dotlrn_class_instances_full.class_instance_id, count(1) as n_members
                 from dotlrn_class_instances_full, dotlrn_member_rels_approved
                 where dotlrn_member_rels_approved.community_id = dotlrn_class_instances_full.class_instance_id
                 group by dotlrn_class_instances_full.class_instance_id) v
                 on dotlrn_class_instances_full.class_instance_id = v.class_instance_id
	    $keyword_clause
            and dotlrn_class_instances_full.department_key = :department_key
            [template::list::orderby_clause -orderby -name "classes"]
        </querytext>
    </fullquery>

    <fullquery name="select_term_info">
        <querytext>
            select term_name,
                   term_year,
                   to_char(start_date, 'Mon DD YYYY') as start_date,
                   to_char(end_date, 'Mon DD YYYY') as end_date
            from dotlrn_terms
            where term_id = :term_id
        </querytext>
    </fullquery>

    <partialquery name="select_all_instances_keyword">
      <querytext>
	  where lower(dotlrn_class_instances_full.pretty_name) like '%'||lower(:keyword)||'%'
      </querytext>
    </partialquery>

    <partialquery name="select_all_instances_without_keyword">
      <querytext>
	  where 1 = 1
      </querytext>
    </partialquery>
    
    

</queryset>
