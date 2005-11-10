ad_page_contract {

} -query {
    page:optional
    {orderby "community_id,asc"}
    {keyword ""}
} -properties {
    classes:multirow
}


if {![exists_and_not_null referer]} {
    set referer "[_ application-track.communities]"
}

set query "select_all_classes"
set paginator_query "select_all_classes_paginator"

if { ![empty_string_p $keyword] } {
    set keyword_clause [db_map select_all_instances_keyword]
} else {
    set keyword_clause [db_map select_all_instances_without_keyword]
}
set title "[_ application-track.All_Terms]"
set context_bar [list [list terms [_ dotlrn.Terms]] "[_ application-track.All_Terms]"]
# Used by the en_US version of the no_class_instances message in the adp
set class_instances_pretty_plural [parameter::get -localize -parameter class_instances_pretty_plural]


set elements [list pretty_name \
    [list label "[_ application-track.Community_Name]" \
	 link_url_col url \
	 orderby_asc {pretty_name asc} \
	 orderby_desc {pretty_name desc}] \
	 ]

lappend elements community_id \
    [list label "[_ application-track.ID]" \
	 link_url_col url \
	 orderby_asc {community_id asc} \
	 orderby_desc {community_id desc}]
	 
lappend elements group_name \
		  [list label "[_ application-track.Group_Name]" \
		       orderby_asc {group_name asc, pretty_name asc} \
		       orderby_desc {group_name desc, pretty_name desc} \
		       link_url_eval {[export_vars -base "/dotlrn/admin/class" { class_key }]}]
		 

lappend elements n_members \
    [list label "[_ application-track.Members]" \
		       orderby_asc {n_members asc, pretty_name asc} \
		       orderby_desc {n_members desc, pretty_name desc}    ]
    
    
template::list::create \
    -name classes \
    -multirow classes \
    -filters { keyword {} } \
    -key community_id \
    -bulk_actions {
        "#application-track.lt_View_data_about_every_application#" "general" "#application-track.lt_View_data_about_every_application#"} \
    -page_size 50 \
    -page_flush_p t \
    -page_query_name $paginator_query \
    -elements $elements

db_multirow classes $query {}   


set applicationsList [callback -catch application-track::getApplicationName]

template::multirow create Applications Name
foreach app $applicationsList {
	multirow append Applications $app
}


template::list::create \
    -name Applications \
    -multirow Applications \
    -key Name \
    -bulk_actions {"#application-track.lt_View_data_for_selected_applications#" "general" "#application-track.lt_View_data_for_selected_applications#"	} \
    -elements {
        name {
            label "[_ application-track.Application_Name]"
            display_col Name
 	    html {align center}            
        }
    } 