import schema default element namespace "http://www.company.org" at "company.xsd";
declare copy-namespaces no-preserve, inherit;
<query3>
  {
  let $empids := doc("company.xml")//Employee[EmpName="Psmith"]/data(EmpId)
    for $empid in $empids 
       let $divisions1 := doc("company.xml")//Division[ManagerEmpId=$empid]/HouseDeptId  
         let  $emp1dept :=
                <Depats>
                 { $divisions1}
                </Depats>   
        
  let $empids := doc("company.xml")//Employee[EmpName="Wong"]/data(EmpId)
    for $empid in $empids 
       let $divisions2 := doc("company.xml")//Division[ManagerEmpId=$empid]/HouseDeptId            
                 let  $emp2dept :=
                <Depats>
                 { $divisions2}
                </Depats>
                
   let $onlyin1 := $emp1dept//HouseDeptId[text()!=$emp2dept//HouseDeptId/text()]
      for $item in distinct-values($onlyin1/text())  
               let $deptids := $item
                  for $deptid in $deptids
                    return ('&#xA;',data(doc("company.xml")//Department[DeptId=$deptid]/DeptName))
                               
  }
 </query3>