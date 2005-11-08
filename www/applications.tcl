ad_page_contract {

} -query {
} -properties {
    classes:multirow
}

set applicationsList [callback -catch getApplicationName]

template::multirow create Applications Name
foreach app $applicationsList {
	multirow append Applications $app
}


template::list::create \
    -name Applications \
    -multirow Applications \
    -key Name \
    -bulk_actions {"#application-track.lt_View_data_for_selected_applications#" "general" "#application-track.lt_View_data_for_selected_applications#"} \
    -elements {
        name {
            label "[_ application-track.Application_Name]"
            display_col Name
 	    html {align center}            
        }
    }
    