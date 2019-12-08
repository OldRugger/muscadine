import React from "react";
import Header from "../components/Header";
import Awt from "../components/Awt";
import Teams from "../components/Teams";

import "../App.css";

export default class TeamsPage extends React.Component {
  // TODO: push the refresh to the components
  componentDidMount() {
    this.interval = setInterval(() => window.location.reload(false), 120000);
  }
  componentWillUnmount() {
    clearInterval(this.interval);
  }
  render() {
    return (
      <div className="App">
        <Header />
        <Awt />
        <Teams />
      </div>
    );
  }
}
