import schema default element namespace "http://www.company.org" at "company.xsd";
declare copy-namespaces no-preserve, inherit;
<query2>
  {
   let $empno := doc("company.xml")//Employee
  for $v in distinct-values(doc("company.xml")//WorksFor/data(DivId))
  let $results :=
  <Divisions>
    <Division> {$v } </Division>
 <Number> { count(index-of(doc("company.xml")//WorksFor/data(DivId), $v)) } </Number>
 </Divisions>
 
   for $result in $results
    let $divisions :=  
        if( $result/data(Number) = count($empno)) 
           then  $result/data(Division)
           else ()
      
     for $division in $divisions
         let $divisionname := doc("company.xml")//Division[DivId=$division]/DivName
        return ('&#xA;',data($divisionname))
  }
</query2>