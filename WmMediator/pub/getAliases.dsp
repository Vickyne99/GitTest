%ifvar action equals('getAliases')%
    %invoke pg.UIConfig:getAliases%
       %loop aliasNames%
            <option>%value name%</option>
       %endloop%
    %endinvoke%
%endif%