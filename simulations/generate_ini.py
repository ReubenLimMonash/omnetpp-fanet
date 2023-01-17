# Date: 06/05/2022
# Desc: To generate member UAV position code for FANET ini file (OMNeT++ sim)

import math

# OLD VERSION ==========================================================================
# numHosts = 5
# hostName = 'adhocNode'
# X = 500 # X offset
# Y = 500 # Y offset
# IUD = 2 # Inter-UAV distance

# for i in range(numHosts):
#     x = X + IUD*math.cos(2*math.pi*i/numHosts)
#     y = Y + IUD*math.sin(2*math.pi*i/numHosts)
#     init_x = '*.' + hostName + '[' + str(i) + '].mobility.initialX = ' + str(x) + 'm'
#     init_y = '*.' + hostName + '[' + str(i) + '].mobility.initialY = ' + str(y) + 'm'
#     print(init_x)
#     print(init_y)
# ======================================================================================

# Desc: Generates member UAV positions at fixed distance around gateway 
numHosts = 5
hostName = 'adhocNode'
GW_X = 500 # X coord of gateway 
GW_Y = 500 # Y coord of gateway
IUD = 2 # Inter-UAV distance
travelDistance = 500 # Distance to travel in the Y direction
step = 100 # Distance step to travel in each micro-simulation
refVar = 'GY' # Reference variable for parallel iteration in .ini file

for i in range(numHosts):
    x = GW_X + IUD*math.cos(2*math.pi*i/numHosts)
    y = GW_Y + IUD*math.sin(2*math.pi*i/numHosts)
    init_y = '*.' + hostName + '[' + str(i) + '].mobility.initialY = ${Y' + str(i) + '=' + str(y) + '..' + str(y + travelDistance) + ' step ' + str(step) + ' ! ' + refVar + '}m'
    init_x = '*.' + hostName + '[' + str(i) + '].mobility.initialX = ' + str(x) + 'm'
    print(init_x)
    print(init_y)