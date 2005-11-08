<?xml version="1.0"?>

<queryset>
    
    <fullquery name="select_class">
        <querytext>
            select pretty_name, url 
            from dotlrn_communities_full
            where community_id = :class_instance_id
        </querytext>
    </fullquery>

</queryset>    