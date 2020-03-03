#!/usr/bin/env python
# -*- coding: utf-8 -*-


from bincrafters import build_template_default
from bincrafters import build_shared
import os

def _is_shared(build):
    return build.options['HDILib:shared'] == True
    
if __name__ == "__main__":

    branch = build_shared.get_repo_branch_from_ci() 
    builder = build_template_default.get_builder(ci_branch=branch) 
    builder.remove_build_if(_is_shared)  
    builder.run()
