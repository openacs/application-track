ad_library {

    User-tracking Library

    @creation-date 2004-08-10
    @author David Ortega (doa@tid.es)
    
}

namespace eval application-track {

 ad_proc -callback getApplicationName {
        -
  } {
    Obtains application names
    
} -

 ad_proc -callback getGeneralInfo {
    -comm_id:required
} {
    Obtains application independient info
    Returns a list with: comm_id, comm_name, number_of_created_elements (forums, news, faqs, ...)
    In comm_name there will be a link to call to getSpecificInfo of that community.
} -


ad_proc -callback getSpecificInfo {
   -comm_id:required -query_name -elements_name
} {
    Obtains application dependient info
    Returns a list with particular data about each application in each community.
    For instace, in forums, it will return a list with: forum_name, #threads, 1st_thead_date, last_thread_date
} -

    
}


