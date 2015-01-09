xquery version "1.0";

import module namespace http = "http://www.exslt.org/v2/http-client" at "/exslt2/http-client.xq";

http:send-request(
   <http:request href="http://www.xmlprague.cz/" method="get"/>)

(:

<res> {

http:send-request(
   <http:request href="http://www.google.com/" method="get">
      <http:header name="Cache-Control" value="no-cache"/>
   </http:request>
),
'&#10;=================================================================================&#10;',

http:send-request(
   <http:request href="http://www.google.com/images/hp0.gif" method="get">
      <http:header name="Cache-Control" value="no-cache"/>
   </http:request>
),
'&#10;=================================================================================&#10;',

http:send-request(
   <http:request href="http://tests.xproc.org/service/fixed-multipart" method="get">
      <http:header name="Cache-Control" value="no-cache"/>
   </http:request>
),
'&#10;=================================================================================&#10;',

http:send-request(
   <http:request href="http://localhost:8080/ws-xslt/console" method="get">
      <http:header name="Cache-Control" value="no-cache"/>
   </http:request>
),
'&#10;=================================================================================&#10;',

http:send-request(
   (: Or use http://www.fgeorges.org:8099/ to get a complete mirror of the request. :)
   (: <http:request href="http://localhost:8080/ws-xslt/deploy" method="post"> :)
   <http:request href="http://localhost:8099/" method="post">
      <http:header name="Cache-Control" value="no-cache"/>
      <http:multipart content-type="multipart/form-data"
                      boundary="ThIs_Is_tHe_bouNdaRY_$">
         <http:header name="Content-Disposition" value="form-data; name=service"/>
         <http:body content-type="text/plain">world</http:body>
         <http:header name="Content-Disposition"
                      value="form-data; name=archive; filename=some-file.tgz"/>
         <http:body content-type="text/xml">
            <hello/>
         </http:body>
      </http:multipart>
   </http:request>
),
'&#10;=================================================================================&#10;'

}
</res>

:)
