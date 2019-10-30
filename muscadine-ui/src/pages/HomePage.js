import React, { Component } from "react";
import { Link } from "react-router-dom";
import "../App.css";

export default class HomePage extends React.Component {
  render() {
    return (
      <div className="App">
        <header className="App-header">
          <h3>2020 Southeastern Interscholastic Championships</h3>
        </header>
        <p>
          <Link to="/config">Configuration</Link>
        </p>
      </div>
    );
  }
}
