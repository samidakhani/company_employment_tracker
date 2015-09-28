import schema default element namespace "http://www.company.org" at "company.xsd";
declare copy-namespaces no-preserve, inherit;
<query1>
  {
let $empids := doc("company.xml")//Employee[EmpName="Psmith" or EmpName="Jack"]/data(EmpId)
    for $empid in $empids 
       let $worksfors := doc("company.xml")//WorksFor[EmpId=$empid]
         for $workfor in $worksfors
          let $divisions :=$workfor[PercentTime>=50]/data(DivId)
            for $division in $divisions
                let $deptids := doc("company.xml")//Division[DivId=$division]/data(HouseDeptId)
                   for $deptid in $deptids
                      let $deptnames := doc("company.xml")//Department[DeptId=$deptid]/DeptName
                         return ('&#xA;',data($deptnames))
  }
</query1>