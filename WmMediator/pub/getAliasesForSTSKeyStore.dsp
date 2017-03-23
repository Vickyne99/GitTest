%switch action%
    %case 'getPKAliases'%
         %invoke pg.stsconfig:getPKAliases%
           %loop pkAliases%
                <option>%value alias%</option>
           %endloop%
        %endinvoke%
    %case 'getCertAliases'%
          %invoke pg.stsconfig:getCertAliases%
           %loop certAliases%
                <option>%value alias%</option>
           %endloop%
        %endinvoke%
%endswitch%