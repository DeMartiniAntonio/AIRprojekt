import React from "react";
import {
  PlayCircleOutlined,
  StopOutlined,
  EditOutlined,
  DeleteOutlined,
} from "@ant-design/icons";
import { Card, Modal } from "antd";

import "./device.css";

const { confirm } = Modal;

const Device = ({ device, onStartDevice, onStopDevice, onEdit, onDelete }) => {
  const handleDelete = () => {
    confirm({
      title: "This action wil delete device.",
      onOk() {
        onDelete(device);
      },
    });
  };

  return (
    <>
      <Card
        style={{ width: 300 }}
        actions={[
          <PlayCircleOutlined
            key="start"
            onClick={() => onStartDevice(device)}
          />,
          <StopOutlined key="stop" onClick={() => onStopDevice(device)} />,
          <EditOutlined key="edit" onClick={() => onEdit(device)} />,
          <DeleteOutlined key="delete" onClick={handleDelete} />,
        ]}
      >
        <div className="device-card">
          <p>Device: {device.device_ID}</p>
          <p>Lat: {device.lat}</p>
          <p>Long: {device.long}</p>
          <p>Stock: {device.stock}</p>
          <p>Price: {device.price}</p>
          <p>Active: {device.active ? "Da" : "Ne"}</p>
        </div>
      </Card>
    </>
  );
};

export default Device;
