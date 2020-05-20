import React, { useState, useRef, useEffect } from 'react'
import mapboxgl from "mapbox-gl"

const uuid = () => {
  return 'xxxxxxxx-xxxx-4xxx-yxxx-xxxxxxxxxxxx'.replace(/[xy]/g, function(c) {
    var r = Math.random() * 16 | 0, v = c == 'x' ? r : (r & 0x3 | 0x8)
    return v.toString(16)
  })
}

const ActivityMap = ({latitude, longitude, options}) => {	

	const mapContainer = useRef(null)
	const [map, setMap] = useState(null)
	const [modalOpen, setModalOpen] = useState(false)
	const [detailViewTrail, setDetailViewTrail] = useState(null)
	

	function handleMarkerMousein() {
	  if(!this.marker) return null
	  this.marker.togglePopup()
	}

	function handleMarkerMouseout() {
	 if(!this.marker) return null
	  this.marker.togglePopup()
	}

	const setInitialMarker = (map) => {
		var marker = new mapboxgl.Marker()
		  .setLngLat([latitude, longitude])
		  .addTo(map)
	}

	const configureMap = () => {
		return new mapboxgl.Map({
	        container: mapContainer.current,
	        style: "mapbox://styles/mapbox/streets-v11", 
	        center: [latitude, longitude],
	        zoom: 9
	      })
	}

	const buildPopup = (data) => {
		return new mapboxgl.Popup({
	  		closeButton: false,
	  		closeOnClick: false
	    }).setHTML(`
	    	<div class="content is-small">
	    		<h3>${data.name}</h3>
	    		<p>${data.length} Miles</p>
	    		<p>${data.ascent}ft Elevation Change</p>
	    	</div>
	    `)
	}

	const buildTrailMarker = (data) => {
		return new mapboxgl.Marker()
			.setLngLat([data.longitude, data.latitude])
	}

	const setInitialOptions = () => {
		return options.reduce( (carry, opt) => {		
			const uniqueid = uuid()
			const marker = buildTrailMarker(opt)
			const popup = buildPopup(opt)
			marker.setPopup(popup)
			carry[uniqueid] = {
				...opt, 
				uniqueid,
				marker,
				selected: false
			}
			return carry
		}, {})
	}

	const handleTrailMarkerSetup = ([key, opt], map) => {
		if(!opt.marker) return null
		opt.marker.addTo(map)
		const markerEl = opt.marker.getElement()
		markerEl.addEventListener('mouseenter', handleMarkerMousein.bind(opt))
		markerEl.addEventListener('mouseleave', handleMarkerMouseout.bind(opt))
		markerEl.addEventListener('click', () => {
			setModalOpen(true)
			setDetailViewTrail(key)
		})
	}


    const initializeMap = ({ setMap, mapContainer }) => {
      const map = configureMap()
      map.on("load", () => {
        setMap(map)
        map.resize()	 
        setInitialMarker(map)
      	Object.entries(optionMarkers)
      		.forEach((options) => {handleTrailMarkerSetup(options, map)})
      })
	}
	
	const [optionMarkers, setOptionMarkers] = useState(setInitialOptions())

	useEffect(() => {
		mapboxgl.accessToken = window.Config.mapKey	    
	 	if (!map) initializeMap({ setMap, mapContainer })
  	}, [map])


	const closeModal = () => {
		setModalOpen(false)
		setDetailViewTrail(null)
	}

	const updateMarkerHash = (key, update) => ({
		...optionMarkers,
		[key]: {
			...optionMarkers[key],
			...update
		}
	})

	const checkItem = (key) => {		
		let markerUpdates = updateMarkerHash(key, { selected: true })
		setOptionMarkers(markerUpdates)
		saveTrails(markerUpdates)
		closeModal()
	}

	const saveTrails = (trails) => {
		const trailList = Object.values(trails)
			.filter(trail => trail.selected)
		const trailData = trailList.map(trail => ({
			description: trail.summary,
			latitude: trail.latitude,
			length: trail.length,
			longitude: trail.longitude,				
			name: trail.name,
			vertical_gain: trail.ascent,
		}))
		return fetch(url, {
		    method: 'POST', 
		    headers: {
		      'Content-Type': 'application/json'
		    },
			body: JSON.stringify(trailData) 
		})
	}

  	return (
  		<div>
  			<div ref={el => (mapContainer.current = el)} style={{width: '100%', height: '450px'}}/>
  			<table className="table is-striped is-fullwidth">
  				<thead>
  					<th> </th>
  					<th> </th>
  					<th> </th>
  					<th> </th>
  				</thead>
  				<tbody>
  					{ Object.values(optionMarkers).map( opt => {
  						return (
  							<tr>
  								<td>
  									<label className="checkbox">
  									  <input checked={opt.selected} type="checkbox" />  									  
  									</label>
  								</td>
  								<td>
  									{opt.name} <br/>   									
  								</td>
  								<td></td>
  								<td><button className="button is-primary">Deatils</button></td>
  							</tr>
  						)
  					})

  					}
  				</tbody>
  			</table>
  			<div className={ modalOpen ? 'is-active modal' : 'modal'}>
  			  <div className="modal-background"></div>
  			  <div className="modal-card">
  			      <header className="modal-card-head">
  			        <p className="modal-card-title">{ optionMarkers[detailViewTrail] && optionMarkers[detailViewTrail].name }</p>
  			        <button className="delete" aria-label="close" onClick={closeModal}></button>
  			      </header>
  			      <section className="modal-card-body">
  			      	{ optionMarkers[detailViewTrail] &&
  			      		<div>
		  			       	<div className="card-image">
				       	    	<figure className="image is-4by3">
				       	      		<img src={optionMarkers[detailViewTrail].imgMedium} alt="Placeholder image" />
				       	    	</figure>
				       	  	</div>
				       	  	<div className="content">
				       	  		{optionMarkers[detailViewTrail].summary}
				       	  	</div>
			       	  	</div>
  			      	}
  			      </section>
  			      <footer className="modal-card-foot">
  			        <button className="button is-success" onClick={e => checkItem(detailViewTrail)}>Save changes</button>
  			        <button className="button" onClick={closeModal}>Cancel</button>
  			      </footer>
  			    </div>
  			</div>
  		</div>
  	)
}

window.ActivityMap = ActivityMap