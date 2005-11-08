ad_page_contract {

} -query {
    page:optional
    {community_id:multiple ""}
    {class_instance_id:multiple ""}
    {Name:multiple ""} 
    orderby:optional
} -properties {
	result:onevalue
}

# Input parameters treatment
if {[exists_and_not_null Name]} {
	set applicationsList $Name
} else {
set applicationsList [callback -catch getApplicationName]
}

if { [exists_and_not_null community_id] } {
set class_instance_id $community_id
}

if {! [exists_and_not_null class_instance_id] } {
	set class_instance_id ""
	db_foreach select_all_classes {} {
		append class_instance_id "$id "	
	}
}

#Deleting {} from the lists
regsub -all -- "\[\{ \}\]+" $class_instance_id " " class_instance_id
regsub -all -- "\[\{ \}\]+" $Name " " Name


#Creating the multirow
template::multirow create CommList CommName url url2 result result_url

#Creating the elements list
set elements {
        name {
            label "[_ application-track.Community]"
            display_col CommName
            link_url_col url  
 	    html {align center}            
        }
}

set link ""

foreach app $applicationsList {

	#Adding a new field to the elements list
	append elements $app
	
	append elements " \{ 
			label $app 
			display_col $app
			link_url_col ${app}_url			
			html {align center}  
	 		orderby_asc {${app} asc} 
			orderby_desc {${app} desc}			
       	\}
       	      	"
    	#Adding a new column to the multirow     	
	template::multirow extend CommList $app "${app}_url"

	append link "&Name=$app"
}

append elements { 
	comm {
            label "[_ application-track.All_Applications]"
            display_template "#application-track.Go#"
            link_url_col url2  
 	    html {align center}            
        }
}

foreach class_id $class_instance_id {
	db_0or1row select_classes {} -column_array class_info
	multirow append CommList ${class_info(pretty_name)} ${class_info(url)}
	
	#"specific?class_instance_id=$class_id"
	template::multirow set CommList [template::multirow size CommList] "url2" "specific?class_instance_id=$class_id$link" 

	foreach app $applicationsList {
	   	template::multirow set CommList [template::multirow size CommList] "$app" [lindex [callback -impl "$app" GetGeneralInfo -comm_id $class_id] 0]
	   	template::multirow set CommList [template::multirow size CommList] "${app}_url" "specific?class_instance_id=$class_id&Name=$app"
   	}
   	
}

# List creation
template::list::create \
    -name CommList \
    -multirow CommList \
    -filters { class_instance_id:multival  {} Name:multival {} } \
    -elements $elements \
    -html {align center}
    
    
# This list is not created as result of an XQL query, so we must order directly the multirow
if { [exists_and_not_null orderby] } {
    regexp {([^,]*),(.*)} $orderby match column order

    if { $order == "asc" } {
        template::multirow sort CommList -increasing $column
    } elseif { $order == "desc" } {
        template::multirow sort CommList -decreasing $column
    }

}
           


