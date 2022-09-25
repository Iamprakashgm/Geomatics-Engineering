# -*- coding: utf-8 -*-
"""
Created on Tue Aug 23 17:14:20 2022

@author: iamprakashgm
"""

from osgeo import gdal
import numpy as np
import matplotlib.pyplot as plt


dataset = gdal.Open('aresh.tif')
geo_transform = dataset.GetGeoTransform()
projection = dataset.GetProjection()

band = dataset.GetRasterBand(1)

array = band.ReadAsArray()
plt.figure()
plt.imshow(array)

binary_mask = np.where((array >= np.mean(array)), 1, 0)
plt.figure()
plt.imshow(binary_mask)

driver = gdal.GetDriverByName('GTiff')
driver.Register()
output_dataset = driver.Create('binary_mask.tif', xsize = binary_mask.shape[1], 
                               ysize = binary_mask.shape[0], bands = 1, eType = gdal.GDT_Int16)

output_dataset.SetGeoTransform(geo_transform)
output_dataset.SetProjection(projection)
output_band = output_dataset.GetRasterBand(1)
output_band.WriteArray(binary_mask)
output_band.SetNoDataValue(np.nan)
output_band.FlushCache()

output_band = None
output_dataset = None
