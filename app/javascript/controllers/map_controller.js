import { Controller } from "@hotwired/stimulus";
import MapboxGeocoder from "@mapbox/mapbox-gl-geocoder"

export default class extends Controller {
  static values = {
    apiKey: String,
    markers: Array,
    page: String
  }

  connect() {
    mapboxgl.accessToken = this.apiKeyValue

    this.map = new mapboxgl.Map({
      container: this.element,
      style: "mapbox://styles/vschang/cl6c4yfn7000r14pgd8lz0yav"
    })

    this.#addMarkersToMap()
    this.#fitMapToMarkers()


    const nav = new mapboxgl.NavigationControl({
      visualizePitch: true
    });

    this.map.addControl(nav, 'bottom-right');
    if (this.pageValue === "index" || this.pageValue === "profile") {
      this.map.addControl(new MapboxGeocoder({ accessToken: mapboxgl.accessToken,
          mapboxgl: mapboxgl,
          placeholder: "search for a location",
        }))
    }


  }


  #addMarkersToMap() {
    this.markersValue.forEach((marker) => {
      const popup = new mapboxgl.Popup({closeButton: false, className: ''}).setHTML(marker.info_window)
      const isPopupOpen = popup.isOpen();


      const customMarker = document.createElement("div")
      customMarker.className = "marker"
      customMarker.style.backgroundImage = `url('${marker.image_url}')`
      customMarker.style.backgroundSize = "contain"
      customMarker.style.width = "25px"
      customMarker.style.height = "25px"

      new mapboxgl.Marker(customMarker)
        .setLngLat([marker.lng, marker.lat])
        .setPopup(popup)
        .addTo(this.map)
    })
  }

  #fitMapToMarkers() {
    const bounds = new mapboxgl.LngLatBounds()
    this.markersValue.forEach(marker => bounds.extend([ marker.lng, marker.lat ]))
    this.map.fitBounds(bounds, { padding: 70, maxZoom: 15, duration: 0 })
  }
}
