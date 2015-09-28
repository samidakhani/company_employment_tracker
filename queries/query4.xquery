import schema default element namespace "http://www.company.org" at "company.xsd";
declare copy-namespaces no-preserve, inherit;
<query4>
  {
       
    let $empids := doc("company.xml")//Employee/EmpId 
    let  $emptotalids :=
                <Emps>
                 { $empids}
                </Emps> 
                
     let $empids := doc("company.xml")//Division//data(ManagerEmpId)
       let $distinctempids :=distinct-values($empids)
       let $empmanagerids := <Emps>
           {
           for $empid in $distinctempids
              return
                   <EmpId>
                    { $empid }
                   </EmpId>
             }      
          </Emps>
         
       for $s in $emptotalids//EmpId/text()   
        let $remidtemp :=   
           if ($s = $empmanagerids//EmpId/text())
           then()
           else $s
           
       let  $remids := distinct-values($remidtemp)
          for $remid in  $remids
           let $result := doc("company.xml")//Employee[EmpId=$remid]
            
            
      for $x in $result       
      order by $x//EmpName       
      return  ( '&#xA;',data($x//EmpName), data($x//EmpPhone),data($x//EmpOffice))               
     
                           
  }
  </query4>