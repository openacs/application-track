<master>
<property name="title">#application-track.Classes_Selection#</property>
<property name="context">#application-track.Classes_Selection#</property>


<center>

</center>
<table border="0" width="100%">
  <tbody>
  <tr>
    <td valign="top" width="50%">

	    <table border="0" width="100%">
	    <tr>
	    <td align="left"  width="20%">
	    	<table border="0">
		<tr>
		<td>	    
	    	<formtemplate id="department_form">
		      #application-track.Departments#:<br><formwidget id="department_key">
	    	</formtemplate>
	    	</td>
	        <tr>
		<td align="left">
	        <formtemplate id="term_form">
	        	#application-track.term#:<br><formwidget id="term_id">
                </formtemplate>
	        </td>
       
	        </tr>	 
	        <tr>
	        <td>
	    <form action="classes" method="GET">
	      #application-track.Show_classes_only_with#: <br> 
	      <input name="keyword" onfocus="if(this.value=='#application-track.Please_type_a_keyword#')this.value='';" onblur="if(this.value=='')this.value='#application-track.Please_type_a_keyword#';" value="#application-track.Please_type_a_keyword#" />
              <input type="hidden" name="term_id" value="@term_id@" />
	      <input type="hidden" name="department_key" value="@department_key@" />
              <input type="submit" value="#application-track.Go#" />
	    </form>
	   
	  </td> 	        
	  
	  	 
	  
	        </tr> 
	         	
	        </table>
	    </td>

	    <td align="center" width="100%">
	<if @classes:rowcount@ gt 0>
	<h4>#application-track.Select_classes_to_analyze#</h4><br>
	<listtemplate name="classes"></listtemplate><br>
	<h4>#application-track.Select_applications_to_analyze#</h4><br>
	  <listtemplate name="Applications"></listtemplate><br>
	
		<form name="nuestra" action="general" method="GET">
	  	<input type="button" value="#application-track.Classes_analyze#" onClick="javascript:clickButton()">
	  	<script language="javascript">
			function clickButton() {
				var url = "general?";				
				var cont=0;					
								
				var size=document.Applications.Name.length;
				for(cont=0;cont<size;cont++){
					if (document.Applications.Name[cont].checked) {
						url= url + "Name=" + document.Applications.Name[cont].value + "&";
					}
							
				}
				
				var cont=0;
				if (document.classes.class_instance_id.length != null){
					var size=document.classes.class_instance_id.length;
					for(cont=0;cont<size;cont++){
					
					if (document.classes.class_instance_id[cont].checked) {
						url= url + "class_instance_id=" + document.classes.class_instance_id[cont].class_instance_id + "&";
						
					}
					
												
				}				
								
				location.href=url;
				}
				else{				
					if (document.classes.class_instance_id.checked) {							
						url= url + "class_instance_id=" + document.classes.class_instance_id.value + "&";
						
					}				
				location.href=url;
				}
			}
			
			
		</script>
                 
	  
	  </form>
	
	  
	    

	</if>
	<else>
	  <table>
	    <tr bgcolor="#eeeeee">
	      <td>
		<i>#dotlrn.no_class_instances#</i>
	      </td>
	    </tr>
	  </table>
	</else>
	    </td>
	    </tr>
	    </table>
   </td>
</tr>

</table> 

                                                                                                                                                                                                                                                                                                  