import React from "react";
import axios from "axios";
import { Link } from "react-router-dom";
import "../App.css";

export default class Header extends React.Component {
  constructor() {
    super();
  }

  state = {
    config: []
  };

  componentDidMount() {
    this.loadConfigData();
  }

  loadConfigData() {
    axios
      .get("http://" + window.location.hostname + ":5000/config")
      .then(res => {
        const config = res.data;
        this.setState({ config });
      });
  }

  render() {
    return (
      <div className="error-message">
        <header className="App-header">
          <Link to="/">{this.state.config.title}</Link>
        </header>
      </div>
    );
  }
}
