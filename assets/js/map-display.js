import React, { useState, useRef, useEffect } from 'react'
import mapboxgl from "mapbox-gl"


const MapDisplay = ({latitude, longitude}) => {
	const [map, setMap] = useState(null)
	const mapContainer = useRef(null)

	useEffect(() => {
		mapboxgl.accessToken = window.Config.mapKey
	    const initializeMap = ({ setMap, mapContainer }) => {
	      const map = new mapboxgl.Map({
	        container: mapContainer.current,
	        style: "mapbox://styles/mapbox/streets-v11", 
	        center: [latitude, longitude],
	        zoom: 7
	      })

	      map.on("load", () => {
	        setMap(map)
	        map.resize()	 
	        var marker = new mapboxgl.Marker()
	          .setLngLat([latitude, longitude])
	          .addTo(map);       
	      })
		}
	 	if (!map) initializeMap({ setMap, mapContainer })
  	}, [map])

  	return <div ref={el => (mapContainer.current = el)} style={{width: '100%', height: '200px'}}/>
}

window.MapDisplay = MapDisplay