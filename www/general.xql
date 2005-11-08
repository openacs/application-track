<?xml version="1.0"?>

<queryset>
    
    <fullquery name="select_classes">
        <querytext>
            select pretty_name, url 
            from dotlrn_communities_full
            where community_id = :class_id
        </querytext>
    </fullquery>
 
    <fullquery name="select_all_classes">
        <querytext>
            select community_id as id
            from dotlrn_communities_full
        </querytext>
    </fullquery>    

</queryset>    