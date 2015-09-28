import schema default element namespace "http://www.company.org" at "company.xsd";
declare copy-namespaces no-preserve, inherit;
<query5>
  {
       let $sumofdivisions := sum (  
                 for $v in distinct-values(doc("company.xml")//WorksFor/data(EmpId))
                  return  count(index-of(doc("company.xml")//WorksFor/data(EmpId), $v)) 
               )
  
       let $empno :=count( doc("company.xml")//Employee)
       return ( '&#xA;',$sumofdivisions div $empno, '&#xA;')
  }
</query5>