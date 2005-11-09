<master>
<property name="title">@class_info.pretty_name@</property>
<property name="context">@class_info.pretty_name@</property>

<h1>
#application-track.Report_about_installed_applications#
</h1>
</br>

<% foreach app $applicationsList { 
	set nelements [callback -impl "$app" application-track::getGeneralInfo -comm_id $class_instance_id]
	set nelements_p 0
	set show_p 1

	if {$nelements != 0 } {
		set nelements_p 1
		set resultado [callback -impl $app application-track::getSpecificInfo -comm_id $class_instance_id -query_name "query" -elements_name "elements" ]
		if {[exists_and_not_null query]} {
		template::list::create \
		    -name $app \
		    -multirow $app \
		    -elements $elements \
		    -html {align center}         
	    
		db_multirow $app $app $query
		set "nelements" [template::multirow size $app]
		} else {
		set show_p 1
		}
	}
%>
<br>
<if @show_p@ eq 1>
<h3>
<br>#application-track.Application#: @app;noquote@
<br>#application-track.created_elements#: @nelements;noquote@
</h3>
<if @nelements_p@ eq 1>
<listtemplate name="@app@"></listtemplate>
<br>
</if>
</if>
<%

} 
%>
<br>
<br>
