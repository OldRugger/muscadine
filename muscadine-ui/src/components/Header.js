import React from "react";
import { Link } from "react-router-dom";
import "../App.css";

export default class Header extends React.Component {
  render() {
    return (
      <div className="error-message">
        <header className="App-header">
          <Link to="/">2020 Southeastern Interscholastic Championships</Link>
        </header>
      </div>
    );
  }
}
