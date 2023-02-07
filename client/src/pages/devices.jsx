import { useState, useEffect } from "react";
import { Button } from "antd";

import Device from "../components/Device";
import { api } from "../utils/api";
import "../components/device.css";
import DeviceModal from "../components/DeviceModal";

const Devices = () => {
  const [devices, setDevices] = useState();
  const [selectedDevice, setSelectedDevice] = useState();
  const [isModalOpened, setIsModalOpened] = useState(false);

  useEffect(() => {
    fetch(`${api}/GetAll?ObjectsType=devices`)
      .then((res) => res.json())
      .then((res) => {
        setDevices(res);
        console.log(res);
      });
  }, []);

  // adding device handlers
  const onAddDevice = () => {
    setIsModalOpened(true);
  };

  const handleAddDevice = (device) => {
    // pozovi API
    console.log(device);
    setIsModalOpened(false);
  };

  // edit/delete device handlers
  const onEdit = (device) => {
    setSelectedDevice(device);
    setIsModalOpened(true);
  };

  const handleFinishEdit = (device) => {
    // pozovi API
    console.log(device);
    setSelectedDevice();
    setIsModalOpened(false);
  };

  const onDelete = (device) => {
    console.log(device);
  };

  // start/stop device handlers
  const onStartDevice = (device) => {
    // pozovi API
    console.log(device);
  };

  const onStopDevice = (device) => {
    // pozovi API
    console.log(device);
  };

  return (
    <>
      <Button type="primary" onClick={onAddDevice}>
        Add device
      </Button>
      <div className="device-list-wrapper">
        {devices?.map((device) => (
          <Device
            key={device.device_ID}
            device={device}
            onStartDevice={onStartDevice}
            onStopDevice={onStopDevice}
            onEdit={onEdit}
            onDelete={onDelete}
          />
        ))}
        <DeviceModal
          isOpened={isModalOpened}
          device={selectedDevice}
          handleAddDevice={handleAddDevice}
          handleFinishEdit={handleFinishEdit}
        />
      </div>
    </>
  );
};

export default Devices;
