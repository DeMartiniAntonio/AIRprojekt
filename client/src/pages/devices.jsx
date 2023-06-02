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
    fetchDevices();
  }, []);

  const fetchDevices = () => {
    fetch(`${api}/GetAll?ObjectsType=devices`)
      .then((res) => res.json())
      .then((res) => {
        setDevices(res);
        console.log(res);
      });
  };

  // adding device handlers
  const onAddDevice = () => {
    setIsModalOpened(true);
  };

  const handleAddDevice = (device) => {
    fetch(`${api}/AddDevice`, {
      method: "POST",
      headers: {
        "Content-Type": "application/json",
      },
      body: JSON.stringify(device),
    })
      .then((res) => res.json())
      .then(() => {
        setIsModalOpened(false);
        fetchDevices();
      });
  };

  // start/stop device handlers
  const onStartDevice = (device) => {
    const body = {
      ...device,
      active: true,
    };

    fetch(`${api}/UpdateDevice?id=${device.device_ID}`, {
      method: "PUT",
      headers: {
        "Content-Type": "application/json",
      },
      body: JSON.stringify(body),
    })
      .then((res) => res.json())
      .then(() => {
        fetchDevices();
      });
  };

  const onStopDevice = (device) => {
    const body = {
      ...device,
      active: false,
    };

    fetch(`${api}/UpdateDevice?id=${device.device_ID}`, {
      method: "PUT",
      headers: {
        "Content-Type": "application/json",
      },
      body: JSON.stringify(body),
    })
      .then((res) => res.json())
      .then(() => {
        fetchDevices();
      });
  };

  // edit/delete device handlers
  const onEdit = (device) => {
    setSelectedDevice(device);
    setIsModalOpened(true);
  };

  const handleFinishEdit = (device) => {
    if (device) {
      fetch(`${api}/UpdateDevice?id=${device.device_ID}`, {
        method: "PUT",
        headers: {
          "Content-Type": "application/json",
        },
        body: JSON.stringify(device),
      })
        .then((res) => res.json())
        .then(() => {
          setIsModalOpened(false);
          setSelectedDevice();
          fetchDevices();
        });
    } else {
      setIsModalOpened(false);
      setSelectedDevice();
    }
  };

  const onDelete = (device) => {
    if (device) {
      fetch(`${api}?id=${device.device_ID}&ForDelete=device`, {
        method: "DELETE",
        headers: {
          "Content-Type": "application/json",
        },
      })
        .then((res) => res.json())
        .then(() => {
          fetchDevices();
        });
    }
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
        {isModalOpened && (
          <DeviceModal
            isOpened={isModalOpened}
            device={selectedDevice}
            handleAddDevice={handleAddDevice}
            handleFinishEdit={handleFinishEdit}
          />
        )}
      </div>
    </>
  );
};

export default Devices;
