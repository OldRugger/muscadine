import React from "react";
import { Link } from "react-router-dom";
import Header from "../components/Header";

import "../App.css";

export default class HomePage extends React.Component {
  render() {
    return (
      <div className="App">
        <Header />
        <p>
          <Link to="/import">Import Runners / Teams</Link>
        </p>
        <p>
          <Link to="/config">Configuration</Link>
        </p>
        <p>
          <Link to="/teams">Team Results</Link>
        </p>
      </div>
    );
  }
}
