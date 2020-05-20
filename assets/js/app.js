// We need to import the CSS so that webpack will load it.
// The MiniCssExtractPlugin is used to separate it out into
// its own CSS file.
import css from "../css/app.sass"

window.Config = {
	mapKey: 'pk.eyJ1IjoibWl0Y2hlbCIsImEiOiJjamJreXhjcHk0Z25kMzNtcmxqbzg4aXljIn0.7Nj9EE6iR3oWGe69UFwfNQ'
}

// webpack automatically bundles all modules in your
// entry points. Those entry points can be configured
// in "webpack.config.js".
//
// Import dependencies
//
import "phoenix_html"
import "react-phoenix"
import "./location-picker"
import "./map-display"
import "./activity-map"

// Import local files
//
// Local files can be imported directly using relative paths, for example:
// import socket from "./socket"
