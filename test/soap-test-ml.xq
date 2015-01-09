xquery version "1.0";

(:
   The goal of this test is to perform a real-world HTTP request using the
   eXist implementation of the EXSLT 2.0 HTTP Client module.  The sample sends
   a SOAP message to a Web service and display the result in a human readable
   way.
:)

import module namespace http = "http://www.exslt.org/v2/http-client"
      at "/exslt2/http-client.xq";

declare namespace soap = "http://schemas.xmlsoap.org/soap/envelope/";
declare namespace tns  = "http://www.fgeorges.org/ws/test/weather";

declare variable $endpoint as xs:string := "http://localhost:8080/ws-xslt/srv/weather";
declare variable $soap-action as xs:string
      := "http://www.fgeorges.org/ws/test/weather/weather-by-city";

declare function local:format-result($weather as element(tns:weather-by-city-response))
      as xs:string
{
   string-join((
      'Place: ', $weather/tns:place, '&#10;',
      for $d in $weather/tns:detail return $d/concat(
         '  - ', tns:day, ':&#09;', tns:min-temp, ' - ',
         tns:max-temp, ':&#09;', tns:desc, '&#10;'
      )
    ),
   '')
};

let $res := http:send-request(
               <http:request method="post" href="{ $endpoint }">
                  <http:header name="SOAPAction" value="{ $soap-action }"/>
                  <http:body content-type="text/xml">
                     <soap:Envelope>
                        <soap:Header/>
                        <soap:Body>
                           <tns:weather-by-city-request>
                              <tns:city>Brussels</tns:city>
                              <tns:country>BE</tns:country>
                           </tns:weather-by-city-request>
                        </soap:Body>
                     </soap:Envelope>
                  </http:body>
               </http:request>
            )
let $status := xs:integer($res[1]/@status)
let $weather := $res[2]/soap:Envelope/soap:Body/*
   return
      if ( $status eq 200 ) then
         local:format-result($weather)
      else
         error(xs:QName('ERRSOAP001'),
               concat('HTTP error: ', $status, ' - ', $res[1]/@message))
