"""
##################################
#  Copyright C 2022 GamePlayer   #
# GNU GENERAL PUBLIC LICENSE 3.0 #
##################################
"""

import os

PROJECT_VERSION = "0.0.1"

with open('./version') as versionfile:
    for line in versionfile.readlines():
        PROJECT_VERSION = line
        break

EXPORT_DATA = []

with open('./export_presets.cfg') as exportfile:
    for line in exportfile.readlines():
        EXPORT_DATA += [line.replace("%VERSIONPATCH%", PROJECT_VERSION)]

os.remove('./export_presets.cfg')

with open('./export_presets.cfg', 'w') as exportfile:
    for line in EXPORT_DATA:
        exportfile.write(line + '\n')
