import React, { Component } from "react";
import { Link } from "react-router-dom";
import Header from "./Header";

import "../App.css";

export default class HomePage extends React.Component {
  render() {
    return (
      <div className="App">
        <Header />
        <p>
          <Link to="/config">Configuration</Link>
        </p>
      </div>
    );
  }
}
