# -*- coding: utf-8 -*-
"""
Created on Wed Aug 24 11:57:40 2022

@author: iamprakashgm
"""

from osgeo import ogr
from osgeo import gdal
import numpy as np
import matplotlib.pyplot as plt
import geopandas as gpd
import sys

# driver = ogr.GetDriverByName('ESRI Shapefile')
# count = ogr.GetDriverCount()

# for i in range(count):
#     driver_name = ogr.GetDriver(i)
#     print(driver_name.GetName())


dataset_source = ogr.Open(r'california_50m_wind_albers.shp', 0)
if dataset_source is None:
    sys.exit('Could not open this {0} file'.format('california_50m_wind_albers.shp'))


# Counts the total layer available in dataset
layer_count = dataset_source.GetLayerCount()
layer = dataset_source.GetLayer(0)

# Counts the total features available in layer
feature_count = layer.GetFeatureCount()

for feature in layer:
#     geometry = feature.geometry()
#     # print(feature.FieldName())
#     pointX = geometry.GetX()
#     pointY = geometry.GetY()
      field_name = feature.GetField('name')
#     # population = feature.GetField('POP_MAX')
#     print(pointX, pointY)
































