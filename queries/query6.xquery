import schema default element namespace "http://www.company.org" at "company.xsd";
declare copy-namespaces no-preserve, inherit;
<query6>
  {
     let $max := max (  
                 for $v in distinct-values(doc("company.xml")//WorksFor/data(EmpId))
                  return  count(index-of(doc("company.xml")//WorksFor/data(EmpId), $v)) 
               )
               
           for $v in distinct-values(doc("company.xml")//WorksFor/data(EmpId))
    let $results :=
         <Emps>
        <Emp> {$v } </Emp>
        <Number> { count(index-of(doc("company.xml")//WorksFor/data(EmpId), $v)) } </Number>
         </Emps>
  
  
   for $result in $results
    let $emps  :=
        if( $result/data(Number) = $max) 
           then  $result/data(Emp)
           else ()
           
     for $emp in $emps
         return ('&#xA;', data(doc("company.xml")//Employee[EmpId=$emp]/EmpName),
                    data(doc("company.xml")//Employee[EmpId=$emp]/EmpPhone),
                    data(doc("company.xml")//Employee[EmpId=$emp]/EmpOffice),'&#xA;')
  }
  </query6>
  
