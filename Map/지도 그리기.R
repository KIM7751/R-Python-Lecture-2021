# R로 인터랙티브 지도 그리기 (leaflet)
library(leaflet)

# 기본 지도, 대전광역시
leaflet() %>% 
    setView(lng=127.39, lat=36.35, zoom=12) %>% 
    addTiles()

# 3rd party 제공 지도
leaflet() %>% 
    setView(lng=127.39, lat=36.35, zoom=12) %>% 
    addProviderTiles('Stamen.TonerLite')
leaflet() %>% 
    setView(lng=127.39, lat=36.35, zoom=12) %>% 
    addProviderTiles('CartoDB.Positron')
leaflet() %>% 
    setView(lng=127.39, lat=36.35, zoom=12) %>% 
    addProviderTiles('Esri.NatGeoWorldMap')

# 기본 Marker 달기
leaflet() %>% 
    setView(lng=127.39, lat=36.35, zoom=12) %>% 
    addTiles() %>% 
    addMarkers(lng=127.3862, lat=36.3508, label='대전시청')

leaflet() %>% 
    setView(lng=127.39, lat=36.35, zoom=12) %>% 
    addTiles() %>% 
    addMarkers(lng=127.3862, lat=36.3508, label='대전시청',
               labelOptions=labelOptions(textsize='15px'))

leaflet() %>% 
    setView(lng=127.39, lat=36.35, zoom=12) %>% 
    addProviderTiles('Stamen.TonerLite') %>%  
    addMarkers(lng=127.3862, lat=36.3508, label='대전시청',
               labelOptions=labelOptions(
                   style=list(
                       'color'='red',
                       'font-size'='15px',
                       'font-style'='italic'
                   )
               ))

# Circle Marker
leaflet() %>% 
    setView(lng=127.39, lat=36.35, zoom=12) %>% 
    addTiles() %>% 
    addCircles(lng=127.3862, lat=36.3508, 
               label='대전시청', radius=500)

leaflet() %>% 
    setView(lng=127.39, lat=36.35, zoom=12) %>% 
    addTiles() %>% 
    addCircles(lng=127.3862, lat=36.3508, 
               label='대전시청', radius=1000,
               weight=1, color='#dd0022')

# 사각형 Marker
leaflet() %>% 
    setView(lng=127.39, lat=36.35, zoom=12) %>% 
    addTiles() %>%
    addRectangles(lng1=127.37, lat1=36.34,
                  lng2=127.39, lat2=36.36,
                  fillColor='transparent')