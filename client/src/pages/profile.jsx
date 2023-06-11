import { useEffect, useState } from "react";
import { Button, Form, Input } from "antd";

import { api } from "../utils/api";

const Profile = () => {
  const [profile, setProfile] = useState();
  const [form] = Form.useForm();

  useEffect(() => {
    fetchProfile();
  }, []);

  const fetchProfile = (value = undefined) => {
    fetch(
      `${api}/GetOne?id=${
        localStorage.getItem("token").split(":")[1]
      }&ObjectType=user`
    )
      .then((res) => res.json())
      .then((res) => {
        setProfile(res);
      });
  };

  const submitForm = () => {
    form.validateFields().then((values) => {
      fetch(
        `${api}/UpdateUser?id=${localStorage.getItem("token").split(":")[1]}`,
        {
          method: "PUT",
          headers: {
            "Content-Type": "application/json",
          },
          body: JSON.stringify({
            first_name: values.firstName,
            last_name: values.lastName,
            email: values.email,
            password: values.password,
            role_id: profile.role_id,
          }),
        }
      )
        .then((res) => res.json())
        .then((res) => {
          setProfile(res);
        });
    });
  };

  return (
    <div className="page-content loginForm">
      {profile ? (
        <Form
          name="login"
          form={form}
          onFinish={submitForm}
          layout="vertical"
          initialValues={{
            firstName: profile.first_name,
            lastName: profile.last_name,
            email: profile.email,
            password: profile.password,
          }}
        >
          <Form.Item
            label="First name"
            name="firstName"
            rules={[{ required: true }]}
          >
            <Input />
          </Form.Item>

          <Form.Item
            label="Last Name"
            name="lastName"
            rules={[{ required: true }]}
          >
            <Input />
          </Form.Item>

          <Form.Item label="E-mail" name="email" rules={[{ required: true }]}>
            <Input />
          </Form.Item>

          <Form.Item
            label="Password"
            name="password"
            rules={[{ required: true }]}
          >
            <Input.Password />
          </Form.Item>

          <Form.Item className="loginButton">
            <Button type="primary" htmlType="submit">
              Save
            </Button>
          </Form.Item>
        </Form>
      ) : (
        "loading..."
      )}
    </div>
  );
};

export default Profile;
