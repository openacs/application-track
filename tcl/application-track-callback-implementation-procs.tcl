    ad_proc -callback getApplicationName -impl file_storage {} { 
        callback implementation 
    } {
        return "file_storage"		
    }    

    ad_proc -callback GetGeneralInfo -impl file_storage {} { 
        callback implementation 
    } {
    
	db_1row my_query {
		select count(1) as result
			from acs_objects a, acs_objects b
        		where b.object_id = :comm_id
			and a.tree_sortkey between b.tree_sortkey
        		and tree_right(b.tree_sortkey)       
			and a.object_type = 'file_storage_object'
		}
			
	
	return "$result"
    } 


    ad_proc -callback GetSpecificInfo -impl file_storage {} { 
        callback implementation 
    } {
   	
	upvar $query_name my_query	
	upvar $elements_name my_elements
	

	set my_query {
	
		SELECT f.name as name, f.file_id, f.type as type, f.content_size as size,
		       to_char(f.last_modified, 'YYYY-MM-DD HH24:MI:SS') as last_modified,
		       to_char(o.creation_date, 'YYYY-MM-DD HH24:MI:SS') as creation_date,
		       (select site_node__url(site_nodes.node_id)
                       from site_nodes, acs_objects
                       where site_nodes.object_id = file_storage__get_package_id(f.parent_id) and acs_objects.object_id = f.file_id) as url,
                       com.community_id as class_id                       
                FROM fs_files f,dotlrn_communities_full com,acs_objects o, acs_objects o2
		WHERE f.file_id = o.object_id
        and com.community_id=:class_instance_id
		      and o2.object_id= file_storage__get_package_id(f.parent_id)
		      and o2.context_id=com.package_id 
		      
		      }
	      
      		      
	set my_elements {
    		name {
	            label "Name"
                    display_col name                    
	 	    html {align center}	 	    
	 	              
	        }
	        type {
	            label "Type"
	            display_col type 	              	              
	 	    html {align center}	 	    
	 	                 
	        }
	        size {
	            label "Size"
	            display_col size
	 	    html {align center}	 	         
	 	          
	        }
	        last_modification_date {
	            label "Last_Modification_Date"
	            display_col last_modified 
	 	    html {align center}	 	      
	 	}
	        post_date {
	            label "Post_Date"
	            display_col creation_date
	 	    html {align center}    
	 	         
	        }	                  
	        
	}
	
	
    }      
        
    
        ad_proc -callback getApplicationName -impl news {} { 
        callback implementation 
    } {
        return "news"
    }    
    
    ad_proc -callback GetGeneralInfo -impl news {} { 
        callback implementation 
    } {
	db_1row my_query {
    		select count(n.item_id) as result
		FROM news_items_approved n, dotlrn_class_instances_full com
		WHERE class_instance_id=:comm_id
		and apm_package__parent_id(n.package_id) = com.package_id		
	}
	
	return "$result"
    }      
    
 
    ad_proc -callback GetSpecificInfo -impl news {} { 
        callback implementation 
    } {
   	
	upvar $query_name my_query
	upvar $elements_name my_elements

	

	set my_query {
		SELECT news.publish_title as name, news.pretty_publish_date as initial_date, news.publish_date as finish_date
		FROM news_items_approved news,dotlrn_communities_full com
		WHERE community_id=:class_instance_id
		and apm_package__parent_id(news.package_id) = com.package_id }
		
	set my_elements {
    		name {
	            label "Name"
	            display_col name	                                    
	 	    html {align center}	 	    
		                
	        }
	        initial_date {
	            label "Initial Date"
	            display_col initial_date 	      	              
	 	    html {align center}	 	          
	        }
	        finish_date {
	            label "Finish Date"
	            display_col finish_date 	      	               
	 	    html {align center}	 	                
	        }
	}
        return "OK"
    }      
     
    
        ad_proc -callback getApplicationName -impl evaluation {} { 
        callback implementation 
    } {
        return "evaluation"
    }    
    ad_proc -callback GetGeneralInfo -impl evaluation {} { 
        callback implementation 
    } {
    
	db_1row my_query {
	select count(1) as result
		from acs_objects a, acs_objects b
        	where b.object_id = :comm_id
	        and a.tree_sortkey between b.tree_sortkey
        	and tree_right(b.tree_sortkey)
	        and a.object_type = 'evaluation_tasks'	
	}
	return "$result"
    } 
    
     ad_proc -callback GetSpecificInfo -impl evaluation {} { 
        callback implementation 
    } {
   	
	upvar $query_name my_query
	upvar $elements_name my_elements

	set my_query {
		select e.task_name as name,e.task_id as task_id,e.number_of_members as number_elements
		from acs_objects a, acs_objects b,evaluation_tasks e
        	where b.object_id = :class_instance_id
	        and a.tree_sortkey between b.tree_sortkey
        	and tree_right(b.tree_sortkey)
	        and a.object_type = 'evaluation_tasks'
            	and e.task_id = a.object_id

	}
		
	set my_elements {
    		name {
	            label "Name"
	            display_col name	                        
	 	    html {align center}	 	    
	 	                
	        }
	        id {
	            label "Id"
	            display_col task_id 	      	              
	 	    html {align center}	 	               
	        }
	        number_elements {
	            label "Number of elements"
	            display_col number_elements 	      	               
	 	    html {align center}	 	              
	        }            
	      
	    
	}
    }         
    
    
    
    
     ad_proc -callback getApplicationName -impl forums {} { 
        callback implementation 
    } {
        return "forums"
    }    
    
    ad_proc -callback GetGeneralInfo -impl forums {} { 
        callback implementation 
    } {
	db_1row my_query {
    		select count(f.forum_id) as result
		FROM forums_forums f, dotlrn_communities_full com
		WHERE com.community_id=:comm_id
		and apm_package__parent_id(f.package_id) = com.package_id	
	}
	
	return "$result"
    }
    
    ad_proc -callback GetSpecificInfo -impl forums {} { 
        callback implementation 
    } {
   	
	upvar $query_name my_query
	upvar $elements_name my_elements

	set my_query {
		SELECT 	f.name as name,f.thread_count as threads,
			f.last_post, 
		       	to_char(o.creation_date, 'YYYY-MM-DD HH24:MI:SS') as creation_date
		FROM forums_forums f,dotlrn_communities_full com,acs_objects o
		WHERE com.community_id=:class_instance_id
		and f.forum_id = o.object_id
		and apm_package__parent_id(f.package_id) = com.package_id
 }
		
	set my_elements {
    		name {
	            label "Name"
	            display_col name	                        
	 	    html {align center}	 	    
	 	                
	        }
	        threads {
	            label "Threads"
	            display_col threads 	      	              
	 	    html {align center}	 	               
	        }
	        creation_date {
	            label "creation_date"
	            display_col creation_date 	      	               
	 	    html {align center}	 	              
	        }
	        last_post  {
	            label "last_post"
	            display_col last_post 	      	               
	 	    html {align center}	 	              
	        }	        
	        
	        
	}

        return "OK"
    }          
    
    
    ad_proc -callback getApplicationName -impl assessments {} { 
        callback implementation 
    } {
        return "assessments"
    }    
    
    ad_proc -callback GetGeneralInfo -impl assessments {} { 
        callback implementation 
    } {
	db_1row my_query {
    		select  count(1) as result
		FROM as_assessments a,dotlrn_communities_all com, acs_objects ac, acs_objects ac2,acs_objects ac3
		WHERE com.community_id = 2560
		and a.assessment_id = ac.object_id
		and ac.context_id = ac2.object_id
		and ac2.package_id = ac3.object_id
		and ac3.context_id = com.package_id	
	}
	
	return "$result"
    }
    
    ad_proc -callback GetSpecificInfo -impl assessments {} { 
        callback implementation 
    } {
   	
	upvar $query_name my_query
	upvar $elements_name my_elements

	set my_query {
		SELECT 	a.assessment_id as id,a.instructions as instructions,a.start_time as initial_date,
		a.end_time as finish_date,
		a.number_tries
		FROM as_assessments a,dotlrn_communities_all com, acs_objects ac, acs_objects ac2,acs_objects ac3
		WHERE com.community_id = :class_instance_id
		and a.assessment_id = ac.object_id
		and ac.context_id = ac2.object_id
		and ac2.package_id = ac3.object_id
		and ac3.context_id = com.package_id
 }
		
	set my_elements {
	
    		id {
	            label "id"
	            display_col id 	      	               
	 	    html {align center}	 	                
	        }
	        instructions {
	            label "instructions"
	            display_col instructions 	      	               
	 	    html {align center}	 	                
	        }              
	        creation_date {
	            label "creation_date"
	            display_col initial_date 	      	               
	 	    html {align center}	 	                
	        }
	        finish_date {
	            label "finish_date"
	            display_col finish_time 	      	               
	 	    html {align center} 	 	             
	        }
	        number_tries {
	            label "number_tries"
	            display_col number_tries 	      	               
	 	    html {align center}	 	               
	        }
	        
	}

        return "OK"
    }       
    
    ad_proc -callback getApplicationName -impl faqs {} { 
        callback implementation 
    } {
        return "faqs"
    }    
    
    ad_proc -callback GetGeneralInfo -impl faqs {} { 
        callback implementation 
    } {
	db_1row my_query {
    		select count(f.faq_id) as result
			from faqs f, acs_objects o, dotlrn_communities com
		    	where o.object_id=f.faq_id
			and com.community_id=:comm_id
			and apm_package__parent_id(o.context_id) = com.package_id	
	}
	
	return "$result"
    }
    
    ad_proc -callback GetSpecificInfo -impl faqs {} { 
        callback implementation 
    } {
   	
	upvar $query_name my_query
	upvar $elements_name my_elements

	set my_query {
		select f.faq_name as name,f1.question as question,f1.answer as answer
			from faqs f, acs_objects o, dotlrn_communities com,faq_q_and_as f1
		    	where o.object_id=f.faq_id
			and com.community_id=:class_instance_id
			and apm_package__parent_id(o.context_id) = com.package_id
			and f.faq_id = f1.faq_id
 }
		
	set my_elements {
    		name {
	            label "Name"
	            display_col name	                        
	 	    html {align center}
	 	               
	        }
	        questions {
	            label "Questions"
	            display_col question 	      	              
	 	    html {align center} 	 	                
	        }
	        questions {
	            label "Answers"
	            display_col answer 	      	              
	 	    html {align center}	 	                
	        }
        
	}

        return "OK"
    }
    
    
    ad_proc -callback getApplicationName -impl weblogger {} { 
        callback implementation 
    } {
        return "weblogger"
    }    
    
    ad_proc -callback GetGeneralInfo -impl weblogger {} { 
        callback implementation 
    } {
	db_1row my_query {
    		select count(1) as result
			from pinds_blog_entries w,  dotlrn_communities com
		    	where com.community_id=:comm_id
			and apm_package__parent_id(w.package_id) = com.package_id	
	}
	
	return "$result"
    }
    ad_proc -callback GetSpecificInfo -impl weblogger {} { 
        callback implementation 
    } {
   	
	upvar $query_name my_query
	upvar $elements_name my_elements

	set my_query {
		select count(c.comment_id) as result
			from pinds_blog_entries w,  dotlrn_communities com, general_comments c
		    	where com.community_id=:class_instance_id
			and apm_package__parent_id(w.package_id) = com.package_id
			and c.object_id=w.entry_id
			group by w.entry_id
	}
		
	set my_elements {
		comments {
	            label "Comments per weblogger"
	            display_col result	                        
	 	    html {align center}	 	                
	        }
	        
	}

        return "OK"
    }
    
    ad_proc -callback getApplicationName -impl lorsm {} { 
        callback implementation 
    } {
        return "lorsm"
    }    
    
    ad_proc -callback GetGeneralInfo -impl lorsm {} { 
        callback implementation 
    } {
	db_1row my_query {
    		select count(1) as result
			from (
				select distinct l.course_id
					from lorsm_student_track l
		    			where l.community_id=:comm_id	
		    			group by l.course_id) as t
	}
	
	return "$result"
    }
    ad_proc -callback GetSpecificInfo -impl lorsm {} { 
        callback implementation 
    } {
   	
	upvar $query_name my_query
	upvar $elements_name my_elements

	set my_query {
		select d.id,i.course_name,l.start_time,l.end_time
			from lorsm_student_track l, dotlrn_users d, ims_cp_manifests i
			where l.course_id IN
			 (
				select distinct l.course_id
					from lorsm_student_track l
		    			where l.community_id=:class_instance_id	
		    			group by l.course_id)
 			and l.user_id = d.user_id
 			and l.course_id = i.man_id
	}
		
	set my_elements ""

        return "OK"
    }
    
    
    
    ad_proc -callback getApplicationName -impl album {} { 
        callback implementation 
    } {
        return "album"
    }    
      
    ad_proc -callback GetGeneralInfo -impl album {} { 
        callback implementation 
    } {
	db_1row my_query {
	select count(p.pa_album_id) as result
			from pa_albums p, cr_items cr,acs_objects a,dotlrn_communities_all d
		    	where  d.community_id = :comm_id
		    	and cr.live_revision = p.pa_album_id		    	
			  and a.object_id = cr.parent_id
			  and apm_package__parent_id(a.context_id) = d.package_id		
	
	} 
	
	return "$result"
    } 

                            
    ad_proc -callback GetSpecificInfo -impl album {} { 
        callback implementation 
    } {
   	
	upvar $query_name my_query
	upvar $elements_name my_elements

	set my_query {
	
		select p.pa_photo_id as id,p.story as story,p.photographer as photographer
			from pa_photos p, dotlrn_communities com,acs_objects ac,acs_objects ac2,acs_objects ac1
		    		where com.community_id=:class_instance_id	    	
		    		and ac.object_id = p.pa_photo_id
		    		and ac.context_id = ac1.object_id
		    		and ac1.context_id = ac2.object_id				
				and ac2.context_id
					IN	(select ac1.context_id
				from pa_albums p, dotlrn_communities com,acs_objects ac,acs_objects ac1
		    		where com.community_id=:class_instance_id	    	
		    		and ac.object_id = p.pa_album_id
		    		and ac.context_id = ac1.object_id
		    		)
				
	}
	set my_elements {
		photo_id {
	            label "Photo_id"
	            display_col id	                        
	 	    html {align center}	 	                
	        }
	        p_story {
	            label "Story"
	            display_col story	                        
	 	    html {align center}	 	                
	        }
	        p_photographer {
	            label "photographer"
	            display_col photographer	                        
	 	    html {align center}	 	                
	        }
	        
	}

        return "OK"
    }
    
       ad_proc -callback getApplicationName -impl presentation {} { 
        callback implementation 
    } {
        return "presentation"
    }    
      
    ad_proc -callback GetGeneralInfo -impl presentation {} { 
        callback implementation 
    } {
	db_1row my_query {
		select count(c.presentation_id) as result
			from cr_wp_presentations c,dotlrn_communities com,acs_objects a
		    	where com.community_id=:comm_id
			and apm_package__parent_id(a.context_id) = com.package_id			
			and a.object_id = c.presentation_id
	}
   			
	
	
	return "$result"
    }            
    
    
   
   
   
    ad_proc -callback GetSpecificInfo -impl presentation {} { 
        callback implementation 
    } {
   	
	upvar $query_name my_query
	upvar $elements_name my_elements

	set my_query {
		select com.community_id as id,com.pretty_name as name,c.presentation_id as p_id,c.pres_title as title
			from cr_wp_presentations c,dotlrn_communities com,acs_objects a
		    	where com.community_id=:class_instance_id
			and apm_package__parent_id(a.context_id) = com.package_id			
			and a.object_id = c.presentation_id
	}
		
	
		
	set my_elements {
		id {
	            label "Community_id"
	            display_col id	                        
	 	    html {align center}	 	                
	        }
	        name {
	            label "Name"
	            display_col name 	      	              
	 	    html {align center}	 	                
	        }
	        p_id {
	            label "Presentation_id"
	            display_col p_id 	      	              
	 	    html {align center}  	                
	        }
	        title {
	            label "Title"
	            display_col title 	      	              
	 	    html {align center}  	                
	        }
	}
        
	

        return "OK"
    }
    
