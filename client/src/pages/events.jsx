import { Select, Table } from "antd";
import { useEffect, useState } from "react";

import { api } from "../utils/api";

const columns = [
  {
    title: "Event ID",
    dataIndex: "event_ID",
    key: "eventId",
  },
  {
    title: "Date",
    key: "date",
    render: (record) => {
      const date = new Date(record.date_time);
      return date.toLocaleString("en-GB");
    },
  },
  {
    title: "Device ID",
    dataIndex: "device_id",
    key: "deviceId",
  },
  {
    title: "User ID",
    dataIndex: "user_id",
    key: "userId",
  },
];

const Events = () => {
  const [devices, setDevices] = useState([]);
  const [events, setEvents] = useState([]);

  useEffect(() => {
    fetchDevices();
    fetchEvents();
  }, []);

  const fetchDevices = () => {
    fetch(`${api}/GetAll?ObjectsType=devices`)
      .then((res) => res.json())
      .then((res) => {
        setDevices(res);
      });
  };

  const fetchEvents = (value = undefined) => {
    fetch(`${api}/GetAll?ObjectsType=events`)
      .then((res) => res.json())
      .then((res) => {
        let events = res;
        if (value) {
          events = events.filter((event) => event.device_id === value);
        }
        setEvents(events);
      });
  };

  return (
    <div className="page-content">
      <Select
        allowClear
        showSearch
        placeholder="Select a device"
        onChange={fetchEvents}
        options={devices?.map((device) => ({
          value: device.device_ID,
          label: device.device_ID,
        }))}
        style={{ marginBottom: 15 }}
      />
      <Table columns={columns} dataSource={events} />
    </div>
  );
};

export default Events;
