import { Table } from "antd";
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
  const [events, setEvents] = useState();

  useEffect(() => {
    fetchEvents();
  }, []);

  const fetchEvents = () => {
    fetch(`${api}/GetAll?ObjectsType=events`)
      .then((res) => res.json())
      .then((res) => {
        setEvents(res);
        console.log(res);
      });
  };

  return (
    <>
      <Table columns={columns} dataSource={events} />
    </>
  );
};

export default Events;
