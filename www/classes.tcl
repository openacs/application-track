ad_page_contract {

} -query {
    {term_id "-1"}
    {department_key ""}
    {orderby "department_name,asc"}
    page:optional
    {keyword ""}
} -properties {
    classes:multirow
}


set departments [db_list_of_lists select_departments_for_select_widget {
    select dotlrn_departments_full.pretty_name,
           dotlrn_departments_full.department_key
    from dotlrn_departments_full
    order by dotlrn_departments_full.pretty_name,
             dotlrn_departments_full.department_key
}]
set departments [linsert $departments 0 {All ""}]

form create department_form

element create department_form department_key \
    -label "[_ application-track.Department]" \
    -datatype text \
    -widget select \
    -options $departments \
    -html {onChange document.department_form.submit()} \
    -value $department_key

element create department_form term_id \
    -label "[_ application-track.Term_ID]" \
    -datatype integer \
    -widget hidden \
    -value $term_id

if {[form is_valid department_form]} {
    form get_values department_form department_key term_id
}

set terms [db_list_of_lists select_terms_for_select_widget {
    select dotlrn_terms.term_name || ' ' || dotlrn_terms.term_year,
           dotlrn_terms.term_id
    from dotlrn_terms
    order by dotlrn_terms.start_date,
             dotlrn_terms.end_date
}]
set terms [linsert $terms 0 {All -1}]

form create term_form

element create term_form term_id \
    -label "[_ application-track.Term]" \
    -datatype integer \
    -widget select \
    -options $terms \
    -html {onChange document.term_form.submit()} \
    -value $term_id

element create term_form department_key \
    -label "[_ application-track.Department]" \
    -datatype text \
    -widget hidden \
    -value $department_key

if {[form is_valid term_form]} {
    form get_values term_form term_id department_key

    if {$term_id != -1} {
        ad_returnredirect "classes?[export_vars {term_id department_key}]"
    }
}

if {![exists_and_not_null referer]} {
    set referer "classes"
}

set query "select_classes"
set paginator_query "select_classes_paginator"
if {$term_id == -1} {
    set query "select_all_classes"
    set paginator_query "select_all_classes_paginator"
}

if {![empty_string_p $department_key]} {
    append query "_by_department"
    append paginator_query "_by_department"
}

if { ![empty_string_p $keyword] } {
    set keyword_clause [db_map select_all_instances_keyword]
} else {
    set keyword_clause [db_map select_all_instances_without_keyword]
}
if {$term_id == -1} {
    set title "[_ application-track.All_Terms]"
    set context_bar [list [list terms [_ application-track.Terms]] "[_ application-track.All_Terms]"]
} else {
    if {[db_0or1row select_term_info {}]} {
        set title "$term_name $term_year ($start_date - $end_date)"
        set context_bar [list [list terms [_ dotlrn.Terms]] "$term_name $term_year"]
    } else {
        set title "[_ application-track.Unknown_Term]"
        set context_bar [list [list terms [_ application-track.Terms]] "[_ application-track.Unknown_Term]"]
    }
}

# Used by the en_US version of the no_class_instances message in the adp
set class_instances_pretty_plural [parameter::get -localize -parameter class_instances_pretty_plural]

set elements [list department_name \
		  [list label "[_ application-track.Department]" \
		       orderby_asc {department_name asc, class_name asc, pretty_name asc} \
		       orderby_desc {department_name desc, class_name desc, pretty_name desc} \
		       link_url_eval {[export_vars -base "/dotlrn/admin/department" { department_key }]}] \
		  class_name \
		  [list label "[_ application-track.Class]" \
		       orderby_asc {class_name asc, pretty_name asc} \
		       orderby_desc {class_name desc, pretty_name desc} \
		       link_url_eval {[export_vars -base "/dotlrn/admin/class" { class_key }]}] \
		 ]
lappend elements class_instance_id \
    [list label "[_ application-track.ID]" \
	 link_url_col url \
	 orderby_asc {class_instance_id asc} \
	 orderby_desc {class_instance_id desc}]
	 

if { $term_id == -1 } {
    lappend elements term_name \
	[list label "[_ application-track.Term]" \
	     orderby_asc {term_name asc, pretty_name asc} \
	     orderby_desc {term_name desc, pretty_name desc}]
}

lappend elements pretty_name \
    [list label "[_ application-track.Class_instance]" \
	 link_url_col url \
	 orderby_asc {pretty_name asc} \
	 orderby_desc {pretty_name desc}]

lappend elements n_members \
    [list label "[_ application-track.Members]" \
		       orderby_asc {n_members asc, pretty_name asc} \
		       orderby_desc {n_members desc, pretty_name desc}    ]



template::list::create \
    -name classes \
    -multirow classes \
    -filters { department_key {} term_id {} keyword {} } \
    -key class_instance_id \
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

ad_return_template                                                                                                            