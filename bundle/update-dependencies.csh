#!/usr/bin/env csh

set dependencies=`ls`
foreach d (${dependencies})
    if -d ${d} then
        pushd ${d}
        git pull origin master
        git submodule update --init
        popd
    endif
end
