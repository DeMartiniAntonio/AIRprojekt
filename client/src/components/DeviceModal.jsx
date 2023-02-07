import { Modal, Button, Checkbox, Form, Input } from "antd";
import React from "react";

const DeviceModal = ({
  isOpened,
  device,
  handleAddDevice,
  handleFinishEdit,
}) => {
  const [form] = Form.useForm();

  const handleEdit = () => {
    form.validateFields().then((values) => {
      if (device) {
        handleFinishEdit(values);
      } else {
        handleAddDevice(values);
      }
    });
  };

  return (
    <>
      <Modal
        title="Edit device"
        open={isOpened}
        onOk={() => handleEdit()}
        onCancel={() => handleFinishEdit()}
      >
        <Form
          name="device"
          form={form}
          initialValues={{
            lat: device?.lat,
            long: device?.long,
            stock: device?.stock,
            price: device?.price,
          }}
        >
          <Form.Item label="Latitude" name="lat" rules={[{ required: true }]}>
            <Input />
          </Form.Item>

          <Form.Item label="Longitude" name="long" rules={[{ required: true }]}>
            <Input />
          </Form.Item>

          <Form.Item label="Stock" name="stock" rules={[{ required: true }]}>
            <Input />
          </Form.Item>

          <Form.Item label="Price" name="price" rules={[{ required: true }]}>
            <Input />
          </Form.Item>
        </Form>
      </Modal>
    </>
  );
};

export default DeviceModal;
