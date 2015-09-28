<?xml version="1.0" encoding="ISO-8859-1"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
xmlns:x="http://www.company.org" exclude-result-prefixes="x">
                    
<xsl:template match="x:Company">
  <html>
  <body style="font-family:Arial">
    <div style="font-size:24px;background-color:yellow;font-weight:bold;color:red">
       Employee Information
    </div >
    <div style="font-size:12px">
       <xsl:for-each select="x:Employee">
      <xsl:variable name="empid" select="x:EmpId" />    
       <xsl:text>Employee </xsl:text>     
     <b><xsl:value-of select="x:EmpName"/> </b>
        <xsl:text> works from  </xsl:text> 
   <b>    <xsl:value-of select="x:EmpOffice"/> </b> 
         <xsl:text> office. </xsl:text>
  <b> <xsl:value-of select="x:EmpName"/>  </b>  
         <xsl:text> works for </xsl:text>    
   <b> <xsl:value-of select="count(../x:WorksFor[x:EmpId = $empid])"/> </b>       
         <xsl:text>  divsions,  which are </xsl:text>
         
         <xsl:for-each select="../x:WorksFor" >
            <xsl:if  test="x:EmpId = $empid">
     <xsl:variable name="tempdivid1" select="x:DivId"/>
      <b> <xsl:value-of select="../x:Division[x:DivId = $tempdivid1]/x:DivName"/> </b>    
           <xsl:if  test="position() !=last()">
       <b>   <xsl:text>, </xsl:text> </b>
            </xsl:if>
                 </xsl:if >
             </xsl:for-each>           
         <xsl:text>. </xsl:text>
         

    <xsl:variable name="divisioncount" select="count(../x:Division[x:ManagerEmpId = $empid])"/>
        
         <b> <xsl:value-of select="x:EmpName"/> </b>
           <xsl:text> manages </xsl:text>
      <b>   <xsl:value-of select="$divisioncount" /> </b>       
           <xsl:text> divisions</xsl:text>
           <xsl:if test="$divisioncount =0">
           <xsl:text>. </xsl:text>
           </xsl:if>
           <xsl:if test="$divisioncount !=0">
             <xsl:text>, which are </xsl:text>
          <xsl:for-each select="../x:Division" >
             <xsl:if  test="x:ManagerEmpId = $empid">
  <b>     <xsl:value-of select="x:DivName"/> </b>
          <xsl:if  test="position() !=last()">
   <b>   <xsl:text>, </xsl:text> </b>
                    </xsl:if >
                 </xsl:if >
             </xsl:for-each>             
           <xsl:text>. </xsl:text> 
         </xsl:if>
   <b>    <xsl:value-of select="x:EmpName"/>  </b>
            <xsl:text> works for the most time with the </xsl:text> 
            
   <xsl:variable name="maxtime" 
  select="../x:WorksFor[x:EmpId = $empid]/x:PercentTime[not(../../x:WorksFor[x:EmpId = $empid]/x:PercentTime &gt; .)][1]"/> 

           <xsl:for-each select="../x:WorksFor" >
             <xsl:if  test="x:PercentTime = $maxtime and x:EmpId = $empid">
               <xsl:variable name="tempdivid" select="x:DivId"/>
             <b> <xsl:value-of select="../x:Division[x:DivId = $tempdivid]/x:DivName"/> </b>  
                 </xsl:if >
             </xsl:for-each>   
              
         <xsl:text>  division.</xsl:text> 
         <br/><br />
        </xsl:for-each>
    </div>
    <div style="font-size:24px;background-color:lightgreen;font-weight:bold;color:red">
       Depatrment Information
    </div>   
     <div style="font-size:12px">
        <xsl:for-each select="x:Department">
  
  <xsl:variable name="deptid" select="x:DeptId" />      
              
           <xsl:text>   Department </xsl:text>
        <b>   <xsl:value-of select="x:DeptName"/> </b> 
           <xsl:text> houses     </xsl:text>
     
    <b>     <xsl:value-of select="count(../x:Division[x:HouseDeptId = $deptid])"/> </b>         
          
           <xsl:text>  divisions : </xsl:text> 
         
             <xsl:for-each select="../x:Division" >
                  <xsl:if  test="x:HouseDeptId = $deptid">
           <b>  <xsl:value-of select="x:DivName"/> </b>
                   <xsl:if  test="position() !=last()">
             <b> <xsl:text>, </xsl:text> </b>       
                  </xsl:if>
                 </xsl:if >
             </xsl:for-each>
             
           <br /><br />
                      
        </xsl:for-each>
    </div>   
  </body>
  </html>
</xsl:template>
</xsl:stylesheet>