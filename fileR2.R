library(googledrive)
library(rgee)

ee_Initialize('ronaldoag1007@gmail.com',drive=T)

# ImageCollection
coll<-ee$ImageCollection('LANDSAT/LC08/C01/T1_TOA')$
  filterDate('2019-04-01','2020-06-30')$
  filterBounds(ee$Geometry$Point(-74.97,-12.78))$
  filterMetadata('CLOUD_COVER','less_than',10)
# Seleccionar la imagen satelital
ee_get_date_ic(coll)  

# Cargando imagen satelital de GEE
L8<-'LANDSAT/LC08/C01/T1_TOA/LC08_006069_20190712' %>%
  ee$Image() %>%
  ee$Image$select(c('B2','B3','B4','B5','B6','B7'),
                  c('BLUE','GREEN','RED','NIR','SWIR 1','SWIR 2'))

# Nombre de las bandas
L8$bandNames()$getInfo()

# Definiendo una visualización SWIR/NIR/RED - 6/5/4
viz_654<- list(bands=c('SWIR 1','NIR','RED'),
               min=0.1,
               max=0.8,
               gamma=1.6)

# Visualización (Solo en formato html)
Map$centerObject(L8)
Map$addLayer(eeObject = L8, visParams =viz_654)