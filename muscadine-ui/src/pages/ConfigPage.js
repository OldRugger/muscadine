import React, { useState, useEffect } from "react";
import Header from "../components/Header";
import "../App.css";
import axios from "axios";

export default function ConfigPage() {
  const initialConfigState = {
    config: {},
    loading: true
  };
  const [config, setConfig] = useState(initialConfigState);

  // Using useEffect to retrieve data from an API (similar to componentDidMount in a class)
  useEffect(() => {
    const getConfig = async () => {
      const { data } = await axios(`http://localhost:5000/config`);
      setConfig(data);
    };

    // Invoke the async function
    getConfig();
  }, []); // Don't forget the `[]`, which will prevent useEffect from running in an infinite loop

  // Return a table with some data from the API.
  return config.loading ? (
    <div className="App">
      <Header />
      Loading...
    </div>
  ) : (
    <div className="App">
      <Header />
      <h1>Configuration</h1>

      <table className="center">
        <thead>
          <tr>
            <th>Key</th>
            <th>Value</th>
          </tr>
        </thead>
        <tbody>
          <tr>
            <td>Title</td>
            <td>{config.title}</td>
          </tr>
          <tr>
            <td>Hotfolder</td>
            <td>{config.hotfolder}</td>
          </tr>
          <tr>
            <td>MaxTime</td>
            <td>{config.max_time}</td>
          </tr>
        </tbody>
      </table>
    </div>
  );
}
