import React from "react";
import Header from "../components/Header";
import Config from "../components/Config";
import "../App.css";

export default class ConfigPage extends React.Component {
  render() {
    return (
      <div className="App">
        <Header />
        <Config />
      </div>
    );
  }
}
