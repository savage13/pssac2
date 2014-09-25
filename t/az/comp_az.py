#!/usr/bin/env python

import numpy as np
from math import *

sigma = np.arange(0,361,45) # Azimuth
d = 400.0
delta = d / 6371.0
P = ( -125.0, 48.0 )
lon1, lat1 = np.radians(P)
#delta = np.radians(delta)
print sigma
sigma = np.radians(sigma)
print sigma

for sigma in range(0,361,45):
    sigma = radians(sigma)
    lat2 = asin( sin(lat1) * cos(delta) + cos(lat1) * sin(delta) * cos(sigma))
    lon2 = lon1 + atan2(sin(sigma) * sin(delta) * cos(lat1), cos(delta) - sin(lat1)*sin(lat2))
    lat2 = degrees(lat2)
    lon2 = degrees(lon2)
    print 'fg seismo; ch stlo %f stla %f' % (lon2, lat2)
    print 'lh az dist; write sample_%03d.sac' % (degrees(sigma))
    
    
