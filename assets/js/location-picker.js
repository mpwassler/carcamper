import React, { useState, useRef, useEffect } from 'react'
import client from '@mapbox/mapbox-sdk/services/geocoding'
const compose = (...functions) => args => functions.reduceRight((arg, fn) => fn(arg), args)

const LoactionPicker = ({}) => {
  
  var geocoder = client({ accessToken: window.Config.mapKey });
  var [places, setPlaces] = useState([])
  var [selectedPlace, setSelectedPlace] = useState(null)

  const getPlaces = (search) => {
    return geocoder.forwardGeocode({
      query: search,
      limit: 15
    }).send()
  }

  const parseResults = ({ body: { features } }) => { return features }

  const onChange = ({ currentTarget: { value } }) => {
    if (value.length < 5) return null
    getPlaces(value)
    .then( (placesData) => {      
      places = parseResults(placesData)  
      setPlaces(places)    
    })
  }

  const onSelect = (place) => {
    setSelectedPlace(place)
    setPlaces([])    
  }

  const onCLickOutside = (e) => {
    if(e.relatedTarget.className === 'dropdown-item') {
      e.preventDefault()
    } else {
      setPlaces([])   
    }
  }
  
  return (
    <div>
      <div  
      tabIndex="0"
      onBlur={onCLickOutside}
      className={`location-picker dropdown is-block ${ places.length > 0 ? 'is-active' : ''}`} >
        <div className="dropdown-trigger">
          <div className="field">
            <label className="label">
              Name: 
            </label>
            <input 
            onChange={onChange} 
            onFocus={onChange}            
            className="location-picker__search input dropdown-trigger" 
            id="location-picker-search" 
            type="text" />     
          </div>
        </div>
        <div className="dropdown-menu" id="dropdown-menu" role="menu">
          <div className="dropdown-content">          
          {places.map( place => {
            return (
              <button 
              key={place.id} 
              onClick={() => {onSelect(place)}} 
              className="dropdown-item">
                {place.place_name} 
              </button>          
            )
          })}
          </div>
        </div>
      </div>
      { selectedPlace &&
        <div style={{ display: 'none'}}>
          <input readOnly={true} value={selectedPlace.place_name} name="destination[name]" />
          <input readOnly={true} value={selectedPlace.geometry.coordinates[0]} name="destination[latitude]" />
          <input readOnly={true} value={selectedPlace.geometry.coordinates[1]} name="destination[longitude]" />
        </div>
      }
    </div>
  )
}

window.LoactionPicker = LoactionPicker