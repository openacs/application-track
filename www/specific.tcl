ad_page_contract {

} {
    class_instance_id
    {Name:multiple ""} 
    orderby:optional
} -properties {
show_p:onevalue
}

if {[exists_and_not_null Name]} {
	set applicationsList $Name
} else {
set applicationsList [callback -catch application-track::getApplicationName]
}



db_1row select_class {} -column_array class_info


set query ""
set elements ""




       
