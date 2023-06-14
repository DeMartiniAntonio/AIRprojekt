import { Select, Tooltip as TT } from "antd";
import { useEffect, useState } from "react";
import Calendar from "react-calendar";
import "react-calendar/dist/Calendar.css";
import {
  Bar,
  BarChart,
  CartesianGrid,
  Legend,
  ResponsiveContainer,
  Tooltip,
  XAxis,
  YAxis,
} from "recharts";

import { api } from "../utils/api";

const Statistics = () => {
  const [devices, setDevices] = useState([]);
  const [statistics, setStatistics] = useState([]);

  useEffect(() => {
    fetchDevices();
    fetchStatistics();
  }, []);

  const fetchDevices = () => {
    fetch(`${api}/GetAll?ObjectsType=devices`)
      .then((res) => res.json())
      .then((res) => {
        setDevices(res);
      });
  };

  const fetchStatistics = (value = undefined) => {
    fetch(`${api}/GetAll?ObjectsType=events`)
      .then((res) => res.json())
      .then((res) => {
        let events = res;
        if (value) {
          events = events.filter((event) => event.device_id === value);
        }
        setStatistics(transformEvents(events));
      });
  };

  const transformEvents = (events) => {
    const statistics = [];
    events.forEach((event) => {
      const date = event.date_time.split("T")[0];
      let alreadyExists = false;
      statistics.forEach((statistic) => {
        if (statistic.date === date) {
          statistic.count++;
          alreadyExists = true;
        }
      });
      if (!alreadyExists) {
        statistics.push({
          realDate: event.date_time,
          date: date,
          count: 1,
        });
      }
    });
    statistics.sort((a, b) => {
      return new Date(a.realDate) - new Date(b.realDate);
    });
    return statistics;
  };

  return (
    <div className="page-content statisticsPage">
      <Select
        allowClear
        showSearch
        placeholder="Select a device"
        onChange={fetchStatistics}
        options={devices?.map((device) => ({
          value: device.device_ID,
          label: device.device_ID,
        }))}
      />
      <div className="innerStatisticsPage">
        <div style={{ height: "350px", width: "750px" }}>
          <ResponsiveContainer width="100%" height="100%">
            <BarChart width={500} height={300} data={statistics}>
              <CartesianGrid strokeDasharray="3 3" />
              <XAxis dataKey="date" />
              <YAxis />
              <Tooltip />
              <Bar dataKey="count" fill="#404b5c" />
            </BarChart>
          </ResponsiveContainer>
        </div>
        <Calendar
          tileContent={({ date }) => {
            let render = null;
            let count = 0;
            statistics.forEach((stat) => {
              if (
                stat.date ===
                new Date(date.setHours(2)).toISOString().split("T")[0]
              ) {
                render = true;
                count = stat.count;
              }
            });
            if (render) {
              return (
                <TT title={`${count}`}>
                  <div className="calendarTooltip"></div>
                </TT>
              );
            }
          }}
        />
      </div>
    </div>
  );
};

export default Statistics;
