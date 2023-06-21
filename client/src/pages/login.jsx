import { Button, Form, Input } from "antd";
import React, { useContext, useState } from "react";
import { useNavigate } from "react-router-dom";

import { AuthContext } from "../context/AuthContext";
import { api } from "../utils/api";

const Login = () => {
  const { setIsLoggedIn } = useContext(AuthContext);
  const [error, setError] = useState("");
  const [form] = Form.useForm();
  const navigate = useNavigate();

  const submitForm = () => {
    form.validateFields().then((values) => {
      fetch(
        `${api}/LoginRequest?email=${values.username}&password=${values.password}`,
        {
          method: "GET",
          headers: {
            "Content-Type": "application/json",
          },
        }
      )
        .then((res) => res.json())
        .then((res) => {
          if (res.status === 404) {
            setError("Username or password is invalid.");
          } else {
            if (res.role_id === 2) {
              localStorage.setItem("token", `user:${res.user_ID}`);
              localStorage.setItem("user", `${res.email}`);
              setIsLoggedIn(true);
              navigate("/");
            } else {
              setError("User is not admin, please try another one.");
            }
          }
        });
    });
  };

  return (
    <div className="loginForm">
      <Form name="login" form={form} onFinish={submitForm} layout="vertical">
        <Form.Item
          label="Username"
          name="username"
          rules={[{ required: true }]}
        >
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
            Login
          </Button>
        </Form.Item>
      </Form>

      {error && <div className="loginError">{error}</div>}
    </div>
  );
};

export default Login;
