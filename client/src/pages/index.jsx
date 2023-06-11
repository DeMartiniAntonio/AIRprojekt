import { GoogleMap, Marker, useJsApiLoader } from "@react-google-maps/api";
import { memo, useCallback, useEffect, useState } from "react";

import { api } from "../utils/api";

const containerStyle = {
  width: "100%",
  height: "calc(100vh - 60px)",
};

const center = {
  lat: 46.29,
  lng: 16.32,
};

const Home = () => {
  const [map, setMap] = useState(null);
  const [devices, setDevices] = useState();

  useEffect(() => {
    fetch(`${api}/GetAll?ObjectsType=devices`)
      .then((res) => res.json())
      .then((res) => {
        setDevices(res);
      });
  }, []);

  const { isLoaded } = useJsApiLoader({
    id: "google-map-script",
    googleMapsApiKey: "AIzaSyCvDYeYwPG1NMP8AFBGdmQbNRbMJUpvX0o",
  });

  const onLoad = useCallback(function callback(map) {
    setMap(map);
  }, []);

  const onUnmount = useCallback(function callback(map) {
    setMap(null);
  }, []);

  return isLoaded ? (
    <GoogleMap
      mapContainerStyle={containerStyle}
      center={center}
      zoom={12}
      onLoad={onLoad}
      onUnmount={onUnmount}
    >
      <>
        {devices?.map((device) => (
          <Marker
            key={device.device_ID}
            position={{ lat: device.lat, lng: device.long }}
            label={device.device_ID.toString()}
            title={`lat: ${device.lat} | long: ${device.long}`}
            opacity={device.active ? 1 : 0.5}
          />
        ))}
      </>
    </GoogleMap>
  ) : (
    <>Loading map...</>
  );
};

export default memo(Home);
