<master>
<property name="title">#application-track.Communities_selection#</property>
<property name="context">#application-track.Communities_selection#</property>

<center>

</center>
<table border="0" width="100%">
  <tbody>
  <tr>
    <td valign="top" width="50%">

	    <table border="0" width="100%" bgcolor="white">
	    <tr>

	    <td align="center" width="100%">
	<if @classes:rowcount@ gt 0>
	<h4>#application-track.Select_Communities_to_analyze#</h4>
	<br><listtemplate name="classes"></listtemplate><br>
	<h4>#application-track.Select_applications_to_analyze#</h4><br>
	  <listtemplate name="Applications"></listtemplate><br>
	  
	  
	  
	  <div style="text-align:center;">
	    <form action="communities" method="GET">
	      #application-track.Show_classes_only_with#: 
	      <input name="keyword" onfocus="if(this.value=='#application-track.Please_type_a_keyword#')this.value='';" onblur="if(this.value=='')this.value='#application-track.Please_type_a_keyword#';" value="#application-track.Please_type_a_keyword#" />
              <input type="submit" value="#application-track.Go#" />
	    </form>
	    <br>
	    <form name="nuestra" action="general" method="GET">
	  	<input type="button" value="#application-track.Communities_analyze#" onClick="javascript:clickButton()">
	  	<script language="javascript">
			function clickButton() {
				var url = "general?";				
				var cont=0;
				
				if (document.classes.community_id.length != null){
					var size=document.classes.community_id.length;
					for(cont=0;cont<size;cont++){
						if (document.classes.community_id[cont].checked) {
							url= url + "community_id=" + document.classes.community_id[cont].value + "&";
						
						}
												
					}
				}
			
				else{
					if (document.classes.community_id.checked) {
							url= url + "community_id=" + document.classes.community_id.value + "&";
						
						}
				}				
									
				var cont=0;
				var size=document.Applications.Name.length;
				for(cont=0;cont<size;cont++){
					if (document.Applications.Name[cont].checked) {
						url= url + "Name=" + document.Applications.Name[cont].value + "&";
					}
								
				}				
				location.href=url;
			}
			
			
		</script>
                 
	  
	  </form>
	  </div>
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


    </center>

                                                                                                                                                                       